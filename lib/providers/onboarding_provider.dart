import 'package:autobetics/models/onboarding_model.dart';
import 'package:autobetics/features/onboarding/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class OnboardingProvider extends StatelessWidget {
  const OnboardingProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => OnBoardingModel(), child: const OnboardingScreen());
  }
}
