// ignore_for_file: prefer_const_constructors_in_immutables, use_build_context_synchronously
import 'package:autobetics/apis/apis.dart';
import 'package:autobetics/common/loaders.dart';
import 'package:autobetics/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:autobetics/features/dashboard/widgets/bottombar.dart';
import 'package:autobetics/models/auth_model.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context, listen: true);
    void handleSubmit() async {
      if (_formKey.currentState!.validate()) {
        final accountAPI = AuthAPI(account: autobetAccount);
        authModel.updateLoading(true);
        try {
          final result = await accountAPI.signIn(
            email: authModel.emailController.text,
            password: authModel.passwordController.text,
          );

          // Check the result to determine if the authentication was successful.
          if (result.isRight()) {
            // Authentication successful, navigate to the dashboard.
            authModel.reset();
            authModel.updateLoading(false);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => DashboardWithBottomNav()));
          } else {
            // Show a notification indicating authentication failure.
            authModel.updateLoading(false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Invalid credentials. Please check the email and password.'),
              ),
            );
            authModel.emailFocusNode.requestFocus();
          }
        } catch (error) {
          // Handle other errors here, e.g., network issues.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('An error occurred. Please try again later.'),
            ),
          );
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
