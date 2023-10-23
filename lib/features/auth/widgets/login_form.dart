// ignore_for_file: prefer_const_constructors_in_immutables, use_build_context_synchronously
import 'package:appwrite/appwrite.dart';
import 'package:autobetics/apis/apis.dart';
import 'package:autobetics/constants/constants.dart';
import 'package:autobetics/models/app_model.dart';
import 'package:autobetics/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'package:autobetics/features/dashboard/widgets/bottombar.dart';
import 'package:autobetics/models/auth_model.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

final accountAPI = AuthAPI(account: autobetAccount);
final dbAPI = DBAPI(db: autobetDatabase);

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context, listen: true);
    final appModel = Provider.of<AppModel>(context, listen: true);
    final onboardingModel = Provider.of<OnBoardingModel>(context, listen: true);
    void handleSubmit() async {
      if (_formKey.currentState!.validate()) {
        if (appModel.freshLauched) {
          final result = await dbAPI.createDocument(
              uId: ID.unique(),
              colId: appModel.userInformation.$id,
              data: {"goals": onboardingModel.selectedGoals});

          appModel.freshLauched = false;
        }

        authModel.loading = true;
        authModel.updateLoading(true);
        final result = await accountAPI.signIn(
          email: authModel.emailController.text,
          password: authModel.passwordController.text,
        );
        result.fold((error) {
          authModel.reset();
          authModel.updateLoading(false);
          // Show a notification indicating authentication failure.
          authModel.updateLoading(false);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message),
            ),
          );
          authModel.emailFocusNode.requestFocus();
        }, (userSession) async {
          appModel.userSession = userSession;
          appModel.setUserSession(userSession);
          final authAPI = AuthAPI(account: autobetAccount);
          final result = await authAPI.getUser();

          result.fold((error) {
            authModel.reset();
            authModel.updateLoading(false);
            // Show a notification indicating authentication failure.
            authModel.updateLoading(false);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.message),
              ),
            );
            authModel.emailFocusNode.requestFocus();
          }, (userInformation) async {
            //if logging and getting user results is successfuluser
            print(userInformation);
            final r = await dbAPI.getDocument(
                uId: userInformation.$id,
                colId: dotenv.get("COLLECTION_ID_DASHBOARD"));
            r.fold((l) => null,
                (r) => appModel.setDashboardDocs(r)); //set user documnet
            appModel.userInformation = userInformation;
            appModel.setUserInformation(userInformation);
            authModel.reset();
            authModel.updateLoading(false);
            if (!userInformation.emailVerification) {
              appModel.incrementNotificationCount(1);
            }

            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => DashboardWithBottomNav()));
          });
        });
        if (result.isRight()) {
          // Authentication successful, navigate to the dashboard.
        } else {
          authModel.reset();
          authModel.updateLoading(false);
        }
      }
    }

    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(12),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                focusNode: authModel.emailFocusNode,
                controller: authModel.emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email required!";
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return "Invalid mailing address";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: "Email", hintText: "me@devred.dev"),
              ),
              TextFormField(
                onTapOutside: (_) => {FocusNode()},
                focusNode: authModel.passwordFocusNode,
                controller: authModel.passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Passowrd required";
                  } else if (value.length < 8) {
                    return "Password must be at least 8 characters!";
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                obscureText: obscure,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                          obscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          obscure = !obscure; // Toggle the obscure state
                        });
                      },
                    ),
                    labelText: "Password",
                    hintText: "*******"),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(3.2)),
                    onPressed: handleSubmit,
                    child: const Text(
                      "Login",
                      style: TextStyle(letterSpacing: 2),
                    )),
              ),
            ],
          )),
    );
  }
}
