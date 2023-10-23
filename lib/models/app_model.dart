import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import "package:appwrite/models.dart" as model;
import 'package:autobetics/utils/app_colors.dart';

class AppModel extends ChangeNotifier {
  late bool freshLauched = true;
  late bool firstTime = true;
  late Map onboardingData;
  late bool showNotificationCount = false;
  late int notificationCount = 0;
  late model.Token? phoneToken;
  late model.Account userInformation;
  late model.Session userSession;
  late bool verifiedEmail = userInformation.emailVerification;
  //dashbord data with goals
  late Map dashboardDocs = {};

  setPhoneToken(token) {
    phoneToken = token;
    notifyListeners();
  }

  setDashboardDocs(model.Document document) {
    dashboardDocs = document.data;
    notifyListeners();
  }

//user information
  setUserInformation(model.Account userInformation) {
    this.userInformation = userInformation;
    notifyListeners();
  }

  setUserSession(model.Session userSession) {
    this.userSession = userSession;
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
