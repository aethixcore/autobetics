// ignore_for_file: prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'package:autobetics/apis/supabase.dart';
import 'package:autobetics/models/app_model.dart';
import 'package:autobetics/models/auth_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterationForm extends StatefulWidget {
  RegisterationForm({super.key});

  @override
  State<RegisterationForm> createState() => _RegisterationFormState();
}

final subaseAPI = SupaBaseAPI();

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
        final email = authModel.emailController.text;
        final password = authModel.passwordController.text;
        final fullname = authModel.nameController.text;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("email", email);
        prefs.setString("fullname", fullname);
        prefs.setString("password", password);
        final result = await subaseAPI.signUp(email: email, password: password);
        result.fold((error) {
          authModel.loading = false;
          authModel.updateLoading(false);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.message)));
        }, (response) {
          authModel.loading = false;
          authModel.updateLoading(false);
          prefs.setBool("newUser", true);
          prefs.setBool("verified", false);
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Success")));
          Future.delayed(const Duration(milliseconds: 2001));
          Navigator.pushReplacementNamed(context, "/dashboard");
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
