import 'package:autobetics/features/auth/screens/auth_screen.dart';
import 'package:autobetics/features/auth/screens/signin_screen.auth.dart';
import 'package:autobetics/features/dashboard/screens/bloodsugar_screen.dart';
import 'package:autobetics/features/dashboard/screens/diet_screen.dart';
import 'package:autobetics/features/dashboard/screens/exercises_screen.dart';
import 'package:autobetics/features/dashboard/screens/insulin_screen.dart';
import 'package:autobetics/features/dashboard/screens/supplement_screen.dart';
import 'package:autobetics/features/dashboard/widgets/bottombar.dart';
import 'package:autobetics/features/notification/screens/notification_screen.dart';
import 'package:autobetics/features/onboarding/screens/onboarding.dart';
import 'package:autobetics/features/profile/screens/profile_screen.dart';
import 'package:autobetics/features/settings/screens/settings_screen.dart';
import 'package:autobetics/features/stories/screens/stories_screen.dart';
import 'package:autobetics/features/stories/screens/story_screen.dart';
import 'package:autobetics/features/widgets/check_screen_status.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "/bgl": (context) => const BloodSugarScreen(),
  "/": (context) => const CheckScreenStatus(),
  "/dashboard": (context) => DashboardWithBottomNav(),
  "/diet": (context) => const DietScreen(),
  "/exercises": (context) => const ExercisesScreen(),
  "/insulin": (context) => const InsulinScreen(),
  "/onboarding": (context) => const OnboardingScreen(),
  "/login": (context) => const LoginScreen(),
  "/notifications": (context) => const NotificationScreen(),
  "/profile": (context) => ProfileScreen(),
  "/register": (context) => AuthScreen(),
  "/settings": (context) => const SettingsScreen(),
  "/stories": (context) => const StoriesScreen(),
  "/story": (context) => const StoryScreen(),
  "/supplements": (context) => const SupplementScreen(),
};
