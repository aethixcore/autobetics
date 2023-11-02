import 'dart:math';

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:provider/provider.dart';

import 'package:autobetics/models/app_model.dart';
import 'package:autobetics/utils/app_colors.dart';
import 'package:autobetics/features/stories/screens/stories_screen.dart';
import 'package:autobetics/features/dashboard/widgets/dashboard_tabbar.dart';

class DashboardWithBottomNav extends StatelessWidget {
  DashboardWithBottomNav({super.key}); //default index of a first screen
  final List<Widget> bottomBarPages = [
    const DashboardTabbar(),
    const StoriesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    
    // showFirstTimeNotification(context);
    final appData = Provider.of<AppModel>(context);
    final tabColor =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? AppColors.surface
            : DarkAppColors.surface;

    return Scaffold(
        body: bottomBarPages[appData.initialIndex],
        extendBody: true,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: AnimatedNotchBottomBar(
          showShadow: false,
          showBlurBottomBar: false,
          blurOpacity: e,
          // itemLabelStyle: const TextStyle(color: AppColors.onSecondary),
          notchColor: tabColor,
          color: tabColor,
          notchBottomBarController: appData.bottomBarController,
          bottomBarItems: const [
            BottomBarItem(
              activeItem: Icon(
                FontAwesome.heart_pulse,
                color: AppColors.primary,
              ),
              itemLabel: 'Home',
              inActiveItem: Icon(
                FontAwesome.heart_pulse,
                size: 18,
              ),
            ),
            BottomBarItem(
              activeItem: Icon(
                FontAwesome.readme,
                color: AppColors.primary,
              ),
              inActiveItem: Icon(
                FontAwesome.readme,
                size: 18,
              ),
              itemLabel: 'Stories',
            ),
          ],
          onTap: (index) {
            appData.jumpTo(index);
          },
        ));
  }
}
