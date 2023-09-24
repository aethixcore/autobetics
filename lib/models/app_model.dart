import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

import 'package:autobetics/utils/app_colors.dart';

class AppModel extends ChangeNotifier {
 
  late bool freshLauched = false;
  late Map onboardingData;
  // final GlobalKey formState  = GlobalKey<FormState>;

  /// Controller to handle bottom nav bar and also handles initial page
  final bottomBarController = NotchBottomBarController(index: 0);
  // final pageController = PageController(initialPage: 0);
  int initialIndex = 0;
  Color activeTabBarColor = AppColors.primary;
  updateActiveTabColor(Color color) {
    notifyListeners();
    activeTabBarColor = color;
  }

  jumpTo(int index) {
    initialIndex = index;
    // pageController.jumpToPage(index);
    // bottomBarController.jumpTo(index);
    notifyListeners();
  }
}
