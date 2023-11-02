import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:autobetics/utils/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppModel extends ChangeNotifier {
  late bool freshLauched = true;
  late bool firstTime = true;
  late Map onboardingData;
  late bool showNotificationCount = false;
  late int notificationCount = 0;

  late User? user;
  late Session? session;
  //dashbord data with goals
  late Map dashboardDocs = {};
  updateUser(User user) {
    user = user;
    notifyListeners();
  }

  updateSession(Session session) {
    session = session;
  }

  var _verifyEmail;

  bool get verifiedEmail => _verifyEmail;

  setPhoneToken(token) {
    notifyListeners();
  }

  setDashboardDocs() {
    notifyListeners();
  }

//user information
  setUserInformation() {
    notifyListeners();
  }

  setUserSession() {
    notifyListeners();
  }

  setEmailVerified() {
    decrementNotificationCount();
    notifyListeners();
  }

  incrementNotificationCount(int count) {
    notificationCount += count;
    showNotificationCount = true;
    notifyListeners();
  }

  decrementNotificationCount() {
    notificationCount--;
    if (notificationCount == 0) showNotificationCount = false;
    notifyListeners();
  }
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
