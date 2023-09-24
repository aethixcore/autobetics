// ignore_for_file: prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'package:autobetics/constants/constants.dart';
import 'package:autobetics/models/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterationForm extends StatefulWidget {
  RegisterationForm({super.key});

  @override
  State<RegisterationForm> createState() => _RegisterationFormState();
}

class _RegisterationFormState extends State<RegisterationForm> {
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context, listen: true);
    void handleSubmit() async {
      if (_formKey.currentState!.validate()) {
        authModel.loading = true;
        authModel.updateLoading(true);
        await Future.delayed(const Duration(seconds: 3));
        authModel.loading = false;

        authModel.reset();
        verfiyEmailBottomModal(context);

        /* final Client client = Client()
            .setEndpoint(dotenv.get(
              "APPWRITE_ENDPOINT",
            ))
            .setProject(dotenv.get("APPWRITE_PID"))
            .setSelfSigned(status: true);
        Account account = Account(client);
        authModel.updateLoading(true);
        try {
          account
              .create(
            userId: ID.unique(),
            password: authModel.passwordController.text,
            email: authModel.emailController.text,
            name: authModel.nameController.text,
          )
              .whenComplete(() async {
            authModel.reset();
            verfiyEmailBottomModal(context);

            //  Navigator.of(context).pushReplacement(MaterialPageRoute(
            //     builder: (context) => DashboardWithBottomNav())
            //     );
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(content: Text('Processing Data')),
          // );
          });

        } on AppwriteException catch (e) {
          if (e.message == "user_already_exists") {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Not allowed"),
                    content: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text("""
${authModel.emailController} is already a user here!"""),
                    ),
                    backgroundColor: Colors.red.shade50,
                  );
                });
          }
          throw Exception(e);
        } catch (e) {
          throw Exception(e);
        } */
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
                focusNode: authModel.nameFocusNode,
                controller: authModel.nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Full Name required!";
                  } else if (!RegExp(
                          r"^([a-zA-Z]{2,}\s[a-zA-z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)")
                      .hasMatch(value)) {
                    return "Invalild Fullname";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    labelText: "Full Name", hintText: "Dev Red"),
              ),
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
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
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
              TextFormField(
                onTapOutside: (_) => {FocusNode()},
                focusNode: authModel.confirmPasswordFocusNode,
                controller: authModel.confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field can not be ingnored!";
                  } else if (authModel.passwordController.text.characters !=
                      authModel.confirmPasswordController.text.characters) {
                    return "Confirm passowrd must match Password";
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
                    labelText: "Confirm Password",
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
                      "Register",
                      style: TextStyle(letterSpacing: 2),
                    )),
              ),
            ],
          )),
    );
  }
}
