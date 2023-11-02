// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:autobetics/models/onboarding_model.dart';
import 'package:autobetics/features/onboarding/widgets/blood_pressure.dart';
import 'package:autobetics/features/onboarding/widgets/goals_checklist.dart';
import 'package:autobetics/features/onboarding/widgets/weight_input.dart';
import 'package:autobetics/features/onboarding/widgets/age_picker.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onBoardingData = Provider.of<OnBoardingModel>(context);
    final List<OnboardingItem> onboardingItems = [
      OnboardingItem(
          title: 'Welcome to Autobetics',
          subtitle: 'Explore the amazing features we offer.',
          image: 'assets/onboard.png',
          nextButton: ElevatedButton(
            onPressed: () {
              onBoardingData.nextPage();
            },
            child: const Text("Get Started!"),
          )),
      OnboardingItem(
          title: 'How old are you?',
          subtitle:
              'We need this information to understand the kind of routine that best fits.',
          image: 'assets/onboard_1.png',
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: AgePicker(),
          )),
      OnboardingItem(
          title: 'What\'s your BMI?',
          subtitle:
              'Hint: Body mass index can indicate whether you’re at a healthy weight.',
          image: 'assets/onboard_2.png',
          nextButton: ElevatedButton(
            child: const Text("Next"),
            onPressed: () {
              if (onBoardingData.weightController.text.isNotEmpty) {
                onBoardingData.nextPage();
                FocusScope.of(context)
                    .requestFocus(onBoardingData.systolicFocusNode);
              } else {
                FocusScope.of(context)
                    .requestFocus(onBoardingData.weightFocusNode);
              }
            },
          ),
          child: const WeightInputScreen()),
      OnboardingItem(
          title: 'Blood Pressure',
          subtitle: 'Previous systolic & diatolic pressure.',
          image: 'assets/onboard_3.png',
          child: const BloodPressureInputWidget(),
          nextButton: ElevatedButton(
            child: const Text("Next"),
            onPressed: () {
              if (onBoardingData.diastolicBPController.text.isEmpty) {
                FocusScope.of(context)
                    .requestFocus(onBoardingData.diastolicFocusNode);
              } else if (onBoardingData.systolicBPController.text.isEmpty) {
                FocusScope.of(context)
                    .requestFocus(onBoardingData.systolicFocusNode);
              } else {
                onBoardingData.nextPage();
              }
            },
          )),
      OnboardingItem(
          title: 'Long Term Goals',
          subtitle: 'pick a one of few goals.',
          image: 'assets/onboard_4.png',
          nextButton: ElevatedButton(
              onPressed: () {
                onBoardingData.finishOnboarding(context);
              },
              child: const Text("FINISH")),
          child: const GoalsCheckListWidget()),
    ];

    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Automatically adjust when the keyboard is active
      body: PageView.builder(
        controller: onBoardingData.pageController,
        itemCount: onboardingItems.length,
        scrollDirection: Axis.vertical,
        pageSnapping: true,
        onPageChanged: (int _) {
          onBoardingData.updateCurrentPageIndex(_);
        },
        itemBuilder: (context, index) {
          // ignore: sized_box_for_whitespace
          return SingleChildScrollView(
            controller: ScrollController(keepScrollOffset: true),
            child: OnboardingPage(
              item: onboardingItems[index],
            ),
          );
        },
      ),
    );
  }
}

class OnboardingItem {
  final String title;
  final String subtitle;
  final String image;
  final Widget? nextButton;
  final Widget? prevButton;
  final Widget? child;

  OnboardingItem({
    this.prevButton,
    this.nextButton,
    this.child,
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final onboardingModel =
        Provider.of<OnBoardingModel>(context, listen: false);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 900),
      curve: Curves.decelerate,
      padding: const EdgeInsets.all(e / log10e),
      height: MediaQuery.sizeOf(context).height,
      child: Flex(
        direction: Axis.vertical,
        children: [
          const SizedBox(height: 50),
          Align(
              alignment: Alignment.topRight,
              child: Text("${onboardingModel.currentPageIndex + 1}/5")),
          if (item.prevButton != null)
            SizedBox(
              height: 50,
              child: item.prevButton,
            ),
          Text(item.title,
              style:
                  const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          Text(item.subtitle,
              style: const TextStyle(
                fontSize: 16,
              )),
          Image.asset(item.image, height: 250),
          const SizedBox(height: 10),
          if (item.child != null)
            SizedBox(
              child: item.child,
            ),
          const SizedBox(height: 10),
          if (item.nextButton != null)
            SizedBox(
              child: item.nextButton,
            ),
        ],
      ),
    );
  }
}
