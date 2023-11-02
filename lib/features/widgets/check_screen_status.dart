// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final onboardingComplete = await isOnboardingComplete();
    final registered = await isRegistered();

    if (onboardingComplete) {
      if (registered) {
        Navigator.pushReplacementNamed(context, '/login');
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

Future<bool> isRegistered() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('registered') ?? false;
}

Future<bool> isOnboardingComplete() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('onboardingComplete') ?? false;
}
