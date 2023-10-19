// ignore_for_file: prefer_const_constructors_in_immutables, use_build_context_synchronously


import 'package:autobetics/apis/apis.dart';
import 'package:autobetics/constants/constants.dart';
import 'package:autobetics/models/app_model.dart';
import 'package:autobetics/models/auth_model.dart';
import 'package:autobetics/providers/auth_provider.dart';
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
    final appModel = Provider.of<AppModel>(context, listen: true);
    void handleSubmit() async {
      if (_formKey.currentState!.validate()) {
        authModel.updateLoading(true);
      
        final accountAPI = AuthAPI(account: autobetAccount);
        accountAPI
            .signUp(
                email: authModel.emailController.text,
                password: authModel.passwordController.text,
                name: authModel.nameController.text)
            .whenComplete(() {
          authModel.reset();
          authModel.updateLoading(false);
          appModel.firstTime = false;
          appModel.freshLauched = false;
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AuthProvider()));
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
                  } else if (value.length < 8) {
                    return "Password must be at least 8 characters!";
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
