import 'package:flutter_svg/flutter_svg.dart';
import 'package:autobetics/models/app_model.dart';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:autobetics/utils/app_colors.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key}); //default index of a first screen
  final List<Widget> bottomBarPages = [];

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);
    void goToPage(int index) {
      appData.pageController.jumpToPage(index);
    }

    return Scaffold(
        body: PageView(
          controller: appData.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
        backgroundColor: AppColors.primary,
        bottomNavigationBar: AnimatedNotchBottomBar(
          notchColor: AppColors.accent.withOpacity(0.95),
          notchBottomBarController: appData.bottomBarController,
          bottomBarItems: const [
            BottomBarItem(
              inActiveItem: Icon(
                Icons.home,
                size: 18,
                color: AppColors.dark,
              ),
              activeItem: Icon(
                Icons.home,
                color: AppColors.dark,
              ),
              itemLabel: 'Home',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                Icons.calendar_today,
                size: 18,
                color: AppColors.dark,
              ),
              activeItem: Icon(
                Icons.calendar_today,
                color: AppColors.dark,
              ),
              itemLabel: 'Calendar',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                HeroIcons.viewfinder_circle,
                size: 18,
                color: AppColors.dark,
              ),
              activeItem: Icon(
                HeroIcons.viewfinder_circle,
                color: AppColors.dark,
              ),
              itemLabel: 'Community',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                Icons.settings,
                size: 18,
                color: AppColors.dark,
              ),
              activeItem: Icon(
                Icons.settings,
                color: AppColors.dark,
              ),
              itemLabel: 'Settings',
            )
          ],
          onTap: (int index) => goToPage,
        ));
  }
}
