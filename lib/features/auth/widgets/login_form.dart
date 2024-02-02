// ignore_for_file: prefer_const_constructors_in_immutables, use_build_context_synchronously
import 'dart:convert';
import 'package:autobetics/apis/api.dart';
import 'package:autobetics/constants/constants.dart';
import 'package:autobetics/features/widgets/custom_toast.dart';
import 'package:autobetics/models/app_model.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autobetics/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final blApi = BackendlessAPI();

class LoginForm extends StatefulWidget {
  LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context, listen: true);
    final appModel = Provider.of<AppModel>(context, listen: true);
    void handleSubmit() async {
      final prefs = await SharedPreferences.getInstance();

      final pushedStats = prefs.getBool('pushedStats') ?? false;

      if (_formKey.currentState!.validate()) {
        authModel.loading = true;
        authModel.updateLoading(true);
        final result = await blApi.signIn(
            email: authModel.emailController.text,
            password: authModel.passwordController.text);

        result.fold((error) {
          authModel.loading = false;
          authModel.updateLoading(false);
          CustomToasts.showWarningToast(error.message);
        }, (response) async {
          authModel.loading = false;
          authModel.updateLoading(false);
          authModel.reset();
          prefs.setBool("logout", false);
          CustomToasts.showSuccessToast("Success!");
          if (pushedStats == false) {
            final stats = {
              "diet": 0.0,
              "exercises": 0.0,
              "bgl": 0.0,
              "insulin": 0.0,
              "supplements": 0.0,
            };
            Backendless.data.of("Stats").save(stats).then((value) {
              CustomToasts.showInfoToast("Upload successful!");
              prefs.setBool("pushedStats", true);

            }).catchError((e) {
              CustomToasts.showWarningToast(e.toString());
            });
          }
          Navigator.pushReplacementNamed(context, "/dashboard", arguments: {"pageIndex":0});
        });
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
