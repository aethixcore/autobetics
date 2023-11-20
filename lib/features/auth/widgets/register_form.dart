// ignore_for_file: prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'dart:convert';

import 'package:autobetics/apis/api.dart';
import 'package:autobetics/features/widgets/custom_toast.dart';
import 'package:autobetics/models/auth_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationForm extends StatefulWidget {
  RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

final blApi = BackendlessAPI();

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context, listen: true);
    void handleSubmit() async {
      if (_formKey.currentState!.validate()) {
        authModel.loading = true;
        authModel.updateLoading(true);

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final skippedOnboarding = prefs.getBool("skippedOnboarding");
        final onBoardingData = jsonDecode(prefs.getString("onBoardingData")!);

        if (skippedOnboarding == true || onBoardingData == null) {
          //skipping onbaarding is allowed for existing users
          //new users can not proceed to register if they skip onbaarding
          prefs.setBool('onboardingComplete', false);
          prefs.setBool("skippedOnboarding", false);
          prefs.setBool("registered", false);
          CustomToasts.showWarningToast("Onboarding data not captured!");
          Navigator.pushReplacementNamed(context, "/onboarding");
          authModel.reset();
        } else {
           final email = authModel.emailController.text;
          final password = authModel.passwordController.text;
          final fullname = authModel.nameController.text;
          final goals = prefs.getStringList("goals");
          final result = await blApi.signUp(
            email: email,
            password: password,
            name: fullname,
            bmi: double.parse(onBoardingData["bmi"]),
            dob: onBoardingData["dob"],
            dbp: double.parse(onBoardingData["dbp"]),
            goals: goals!,
            sbp: double.parse(onBoardingData["sbp"]),
          );
          result.fold((error) {
            authModel.loading = false;
            authModel.updateLoading(false);
            CustomToasts.showErrorToast(error.message, context: context);
          }, (response) async {
            authModel.loading = false;
            authModel.updateLoading(false);
            authModel.reset();
            CustomToasts.showSuccessToast(
                "Success. An Email verification is sent!",
                context: context);
            prefs.setBool('onboardingComplete', true);
            prefs.remove("goals");
            prefs.remove("onBoardingData");
            Navigator.pushReplacementNamed(context, "/login");
          });
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
                focusNode: authModel.nameFocusNode,
                controller: authModel.nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Full Name required!";
                  } else if (!RegExp(
                          r"^([a-zA-Z]{2,}\s[a-zA-z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)")
                      .hasMatch(value)) {
                    return "Invalid Fullname";
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
                    return "Password required!";
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
                    return "Field can not be ignored!";
                  } else if (authModel.passwordController.text.characters !=
                      authModel.confirmPasswordController.text.characters) {
                    return "Confirm password must match Password";
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
