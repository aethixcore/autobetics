import 'package:autobetics/ui/auth/auth_provider.dart';
import 'package:flutter/material.dart';

class OnBoardingData extends ChangeNotifier {
  DateTime age = DateTime.now();
  double? weight = 0.00;
  Map<String, dynamic> bloodPressure = {
    "systolicPressure": 0.00,
    "diastolicPressure": 0.00
  };
  List<String> goals = [
    "Manage your cholesterol.",
    "Keep your eyes healthy.",
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
  final PageController pageController = PageController(initialPage: 0);
  final TextEditingController weightController = TextEditingController();
  final TextEditingController systolicBPController = TextEditingController();
  final TextEditingController diastolicBPController = TextEditingController();
  int currentPageIndex = 0;
  static const kDuration = Duration(milliseconds: 1300);
  static const kCurve = Curves.easeInOutSine;

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
  }

  void updateAge(DateTime age) {
    age = age;
    print(age);
    notifyListeners();
  }

  void updateWeight(double weight) {
    weight = weight;
    print(weight);
    notifyListeners();
  }

  void upadateGoals(List goals) {
    goals = goals;
    notifyListeners();
  }

  void finishOnboarding(BuildContext context) {
    if (age == DateTime.now()) {
      pageController.jumpToPage(1);
    } else if (weight != 0.00) {
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
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Completed Data'),
            content: const Text('Thank you!'),
            actions: <Widget>[
              TextButton(
                child: const Text('Proceed'),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const AuthProvider()));
                },
              ),
            ],
          );
        },
      );
    }
    notifyListeners();
  }

  /* void updateBP(Map bloodPressure) {
    bloodPressure = bloodPressure;
    notifyListeners();
  } */
}
