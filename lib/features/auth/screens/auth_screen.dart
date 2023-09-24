import 'package:autobetics/features/auth/screens/signup_screen.auth.dart';
import 'package:autobetics/features/auth/screens/signin_screen.auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> authPages = const [RegisterScreen(), LoginScreen()];
    return PageView.builder(
      itemBuilder: (BuildContext context, index) {
        return authPages[index];
      },
      pageSnapping: true,
      itemCount: authPages.length,
      controller: PageController(initialPage: 1, keepPage: false),
    );
  }
}
