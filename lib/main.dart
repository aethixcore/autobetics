import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'package:autobetics/models/onboarding_model.dart';
import 'package:autobetics/utils/app_colors.dart';
import 'package:autobetics/ui/onboarding/onboarding.dart';

void main() async {
  await dotenv.load();
  runApp(ChangeNotifierProvider(
    create: (context) => OnBoardingData(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
          colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: AppColors.primary,
              onPrimary: AppColors.light,
              secondary: AppColors.secondary,
              onSecondary: AppColors.onSecondary,
              error: AppColors.error,
              onError: AppColors.onError,
              background: AppColors.accent,
              onBackground: AppColors.onAccent,
              surface: AppColors.dark,
              onSurface: AppColors.onBackground)),
      theme: ThemeData(
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: AppColors.primary,
            onPrimary: AppColors.onPrimary,
            secondary: AppColors.secondary,
            onSecondary: AppColors.onSecondary,
            error: AppColors.error,
            onError: AppColors.onError,
            background: AppColors.background,
            onBackground: AppColors.onBackground,
            surface: AppColors.dark.withAlpha(90),
            onSurface: AppColors.onAccent),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
      // routes: const {
      //   "/auth":AuthSlider(),
      // },
      debugShowCheckedModeBanner: false,
    );
  }
}
