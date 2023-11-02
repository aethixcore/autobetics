import 'package:autobetics/features/auth/screens/auth_screen.dart';
import 'package:autobetics/features/auth/screens/signin_screen.auth.dart';
import 'package:autobetics/features/dashboard/widgets/bottombar.dart';
import 'package:autobetics/features/onboarding/screens/onboarding.dart';
import 'package:autobetics/features/widgets/check_screen_status.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "/check_screen_status": (context) => const CheckScreenStatus(),
  "/dashboard": (context) => DashboardWithBottomNav(),
  "/onboarding": (context) => const OnboardingScreen(),
  "/login": (context) => const LoginScreen(),
  "/register": (context) => const AuthScreen()
};
