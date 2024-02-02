import 'package:autobetics/common/routes.dart';
import 'package:autobetics/models/auth_model.dart';
import 'package:autobetics/models/onboarding_model.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autobetics/models/app_model.dart';
import 'package:autobetics/utils/app_colors.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  await dotenv.load(fileName: ".env");
   Backendless.setUrl(dotenv.get("BL_ENDPOINT"));
   Backendless.initApp(
      applicationId: dotenv.get("BL_APPID"),
      androidApiKey: dotenv.get("BL_ANDROID_API_KEY"),
      iosApiKey: dotenv.get("BL_IOS_API_KEY"),
      customDomain: dotenv.get("BL_SUBDOMAIN"));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AppModel()),
      ChangeNotifierProvider(create: (context) => AuthModel()),
      ChangeNotifierProvider(create: (context) => OnBoardingModel()),
    ],
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? lightTheme
                : darkTheme,
        useMaterial3: true,
      ),
      // debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: "/",
    );
  }
}
