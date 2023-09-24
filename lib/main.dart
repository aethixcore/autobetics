import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:autobetics/models/app_model.dart';
import 'package:autobetics/providers/onboarding_provider.dart';
import 'package:autobetics/providers/auth_provider.dart';
import 'package:autobetics/utils/app_colors.dart';

void main() async {
  await dotenv.load(fileName: ".env");
    
  runApp(ChangeNotifierProvider(
    lazy: true,
    create: (context) => AppModel(),
    child: const MyApp(),
  ));
}

ColorScheme lightTheme = const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    error: AppColors.error,
    onError: AppColors.onError,
    background: AppColors.background,
    onBackground: AppColors.onBackground,
    onSurface: AppColors.onSurface,
    surface: AppColors.surface);

ColorScheme darkTheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: DarkAppColors.primary,
    onPrimary: DarkAppColors.onPrimary,
    secondary: DarkAppColors.secondary,
    onSecondary: DarkAppColors.onSecondary,
    error: DarkAppColors.error,
    onError: DarkAppColors.onError,
    background: DarkAppColors.background,
    onBackground: DarkAppColors.onBackground,
    onSurface: DarkAppColors.onSurface,
    surface: DarkAppColors.surface);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppModel>(context);
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? lightTheme
                : darkTheme,
        useMaterial3: true,
      ),
      home: appData.freshLauched
          ? const OnboardingProvider()
          : const AuthProvider(),
      
      debugShowCheckedModeBanner: false,
    );
  }
}
