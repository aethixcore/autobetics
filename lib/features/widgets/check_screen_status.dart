// ignore_for_file: use_build_context_synchronously

import 'package:autobetics/apis/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
final blApi = BackendlessAPI();
class CheckScreenStatus extends StatefulWidget {
  const CheckScreenStatus({super.key});

  @override
  State<CheckScreenStatus> createState() => _CheckScreenStatusState();
}

class _CheckScreenStatusState extends State<CheckScreenStatus> {
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {


    final prefs = await SharedPreferences.getInstance();
    final registered = prefs.getBool('registered') ?? false;
    final logout = prefs.getBool("logout")??false;
    final onboardingComplete = prefs.getBool('onboardingComplete') ?? false;

    if (onboardingComplete) {
      if (registered || logout == false) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        Navigator.pushReplacementNamed(context, '/register');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

