import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

class AppData extends ChangeNotifier {
  final pageController = PageController(initialPage: 0);
  /// Controller to handle bottom nav bar and also handles initial page
  final bottomBarController = NotchBottomBarController(index: 0);
  
}