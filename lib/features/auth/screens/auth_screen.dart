// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:autobetics/features/auth/screens/signup_screen.auth.dart';
import 'package:autobetics/features/auth/screens/signin_screen.auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool logout = false;

  @override
  void initState() {
    super.initState();
    getLoginState();
  }

  getLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    final state = prefs.getBool("logout") ?? false;
    setState(() {
      logout = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> authPages = const [RegisterScreen(), LoginScreen()];
    return PageView.builder(
      itemBuilder: (BuildContext context, index) {
        return authPages[index];
      },
      pageSnapping: true,
      itemCount: authPages.length,
      controller: PageController(initialPage: logout ? 1 : 0),
    );
  }
}
