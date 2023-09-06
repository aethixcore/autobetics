import 'package:autobetics/models/onboarding_model.dart';
import 'package:autobetics/widgets/blood_pressure.dart';
import 'package:autobetics/widgets/goals_checklist.dart';
import 'package:autobetics/widgets/weight_input.dart';
import 'package:flutter/material.dart';
import 'package:autobetics/widgets/age_picker.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  _OnboardingScreenState();

  @override
  Widget build(BuildContext context) {
    final onBoardingData = Provider.of<OnBoardingData>(context);
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
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: AgePicker(),
          )),
      OnboardingItem(
          title: 'What\'s your BMI?',
          subtitle:
              'Hint: Body mass index can indicate whether you’re at a healthy weight.',
          image: 'assets/onboard_2.png',
          child: const WeightInputScreen()),
      OnboardingItem(
          title: 'Blood Pressure',
          subtitle: 'Previous systolic & diatolic pressure.',
          image: 'assets/onboard_3.png',
          child: const BloodPressureInputWidget()),
      OnboardingItem(
          title: 'Long term Archeivements',
          subtitle: 'pick a one of few goals.',
          image: 'assets/onboard_4.png',
          nextButton: ElevatedButton(
              onPressed: () {
                final onBoardingData =
                    Provider.of<OnBoardingData>(context, listen: false);
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
        onPageChanged: (int pageIndex) {
          onBoardingData.updateCurrentPageIndex(pageIndex);
        },
        itemBuilder: (context, index) {
          // ignore: sized_box_for_whitespace
          return OnboardingPage(
            item: onboardingItems[index],
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
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        direction: Axis.vertical,
        children: [
          if (item.prevButton != null)
            SizedBox(
              child: item.prevButton,
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(item.title,
                style:
                    const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(item.subtitle,
                style: const TextStyle(
                  fontSize: 18,
                )),
          ),
          Image.asset(item.image, height: 200),
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
