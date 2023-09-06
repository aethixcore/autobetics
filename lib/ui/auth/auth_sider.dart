import 'package:autobetics/models/auth_model.dart';
import 'package:autobetics/ui/auth/signin_screen.auth.dart';
import 'package:autobetics/ui/auth/signup_screen.auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AuthSlider extends StatelessWidget {
  const AuthSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthData>(context);
    return SafeArea(
        top: false,
        child:
            authData.firstTime ? const RegisterScreen() : const LoginScreen());
  }
}
