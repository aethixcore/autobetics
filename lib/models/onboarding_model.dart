import 'package:autobetics/models/app_model.dart';
import 'package:autobetics/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:autobetics/providers/auth_provider.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class OnBoardingModel extends ChangeNotifier {
  DateTime age = DateTime.now();
  double? weight = 0.00;
  Map<String, dynamic> bloodPressure = {
    "systolicPressure": 0.00,
    "diastolicPressure": 0.00
  };
  List<String> goals = [
    "Manage your cholesterol.",
    "Keep yourself healthy.",
    "Maintain a healthy weight.",
    "Prevent foot problems.",
    "Manage chronic stress.",
    "Journal your blood sugar levels",
    "Others..."
  ];
  List<String> selectedGoals = [];
  FocusNode weightFocusNode = FocusNode();
  FocusNode listFocusNode = FocusNode();
  FocusNode diastolicFocusNode = FocusNode();
  FocusNode systolicFocusNode = FocusNode();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController systolicBPController = TextEditingController();
  final TextEditingController diastolicBPController = TextEditingController();
  final PageController pageController = PageController();
  int currentPageIndex = 0;
  static const kDuration = Duration(milliseconds: 1300);
  static const kCurve = decelerateEasing;

  void toggleSelectedGoal(String goal) {
    if (selectedGoals.contains(goal)) {
      selectedGoals.remove(goal);
    } else {
      selectedGoals.add(goal);
    }
    notifyListeners();
  }

  void updateCurrentPageIndex(int pageIndex) {
    currentPageIndex = pageIndex;
    notifyListeners();
  }

  void nextPage() {
    if (currentPageIndex < 5) {
      // Change the number '2' to the total number of pages.
      currentPageIndex++;
      pageController.animateToPage(
        currentPageIndex,
        duration: kDuration,
        curve: kCurve,
      );
    }
    notifyListeners();
  }

  void prevPage() {
    if (currentPageIndex > 0) {
      // Change the number '2' to the total number of pages.
      currentPageIndex++;
      pageController.animateToPage(
        currentPageIndex,
        duration: kDuration,
        curve: kCurve,
      );
    }
    notifyListeners();
  }

  void updateAge(DateTime age) {
    age = age;
    notifyListeners();
  }

  void updateWeight(double w) {
    weight = w;
    if (kDebugMode) {
      print(weight);
    }
    notifyListeners();
  }

  void upadateGoals(List goals) {
    goals = goals;
    notifyListeners();
  }

  void finishOnboarding(BuildContext context) {
    final appModel = Provider.of<AppModel>(context, listen: false);
    if (age == DateTime.now()) {
      pageController.jumpToPage(1);
    } else if (weightController.text.isEmpty) {
      pageController.jumpToPage(2);
      FocusScope.of(context).requestFocus(weightFocusNode);
    } else if (bloodPressure["systolicPressure"] == 0.00) {
      pageController.jumpToPage(3);
      FocusScope.of(context).requestFocus(systolicFocusNode);
    } else if (bloodPressure["diastolicPressure"] == 0.00) {
      pageController.jumpToPage(3);
      FocusScope.of(context).requestFocus(diastolicFocusNode);
    } else if (selectedGoals.isEmpty) {
      pageController.jumpToPage(4);
      FocusScope.of(context).requestFocus(listFocusNode);
    } else {
      final data = {
        "age": "${age.month}-${age.day}-${age.year}",
        "weight": weightController.text,
        "bloodPressure": bloodPressure,
        "goals": selectedGoals
      };
      showDialog(
        context: context,
        builder: (context) {
          appModel.freshLauched = false;
          appModel.onboardingData = data;
          return AlertDialog(
            title: const Text('Data collection complete.'),
            content: const Text('Thank you!'),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    LineAwesome.times_solid,
                    color: AppColors.secondary,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const AuthProvider()));
                  },
                  icon: const Icon(
                    LineAwesome.check_solid,
                    color: AppColors.onAccent,
                  ))
            ],
          );
        },
      );
    }
    notifyListeners();
  }
}
