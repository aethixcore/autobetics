// ignore_for_file: prefer_const_constructors_in_immutables, use_build_context_synchronously
import 'dart:async';
import 'package:autobetics/models/app_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as SB;
import 'package:autobetics/models/auth_model.dart';

final supabase = SB.Supabase.instance.client;

class LoginForm extends StatefulWidget {
  LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late StreamSubscription<SB.AuthState> _sessionStreamSubscription;
  bool obscure = true;
  @override
  void initState() {
    _sessionStreamSubscription =
        supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        AppModel().updateSession(session);
        Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _sessionStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context, listen: true);

    void handleSubmit() async {
      if (_formKey.currentState!.validate()) {}
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
