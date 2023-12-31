// ignore_for_file: use_build_context_synchronously

import 'package:autobetics/apis/api.dart';
import 'package:autobetics/features/dashboard/screens/bloodsugar_screen.dart';
import 'package:autobetics/features/dashboard/screens/diet_screen.dart';
import 'package:autobetics/features/dashboard/screens/exercises_screen.dart';
import 'package:autobetics/features/dashboard/screens/insulin_screen.dart';
import 'package:autobetics/features/dashboard/screens/supplement_screen.dart';
import 'package:autobetics/features/widgets/custom_toast.dart';
import 'package:autobetics/models/app_model.dart';
import 'package:autobetics/features/dashboard/screens/home_screen.dart';
import 'package:autobetics/utils/app_colors.dart';
import 'package:autobetics/features/dashboard/widgets/greeting.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Widget> tabbarIcons = const [
  Icon(FontAwesome.hourglass),
  Icon(Icons.bloodtype),
  Icon(Icons.fastfood),
  Icon(FontAwesome.person_running),
  Icon(FontAwesome.syringe),
  Icon(FontAwesome.pills),
];
final blApi = BackendlessAPI();
class DashboardTabbar extends StatefulWidget {
  const DashboardTabbar({super.key});

  @override
  State<DashboardTabbar> createState() => _DashboardTabbarState();
}

class _DashboardTabbarState extends State<DashboardTabbar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  initState() {
    super.initState();
    if (mounted) {
      setState(() {
        _tabController = TabController(length: 6, vsync: this);
      });
    }
  }


  @override
  dispose() {
    if (mounted) {
      _tabController.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppModel>(
      context,
      listen: true,
    );
    return DefaultTabController(
      length: 6, // Specify the number of tabs
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.sizeOf(context).height * 0.105,
          leading: Greeting(),
          leadingWidth: MediaQuery.sizeOf(context).width,
          actions: [
            PopupMenuButton<int>(
              icon: Badge(
                isLabelVisible: appData.showNotificationCount,
                child: const Icon(FontAwesome.ellipsis_vertical),
              ),
              itemBuilder: (context) => <PopupMenuEntry<int>>[
                const PopupMenuItem<int>(
                  value: 1,
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                  ),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: ListTile(
                    leading: Badge(
                      // smallSize: 7,
                      largeSize: 14,
                      offset: const Offset(-10, -3),
                      label: Text(appData.notificationCount.toString()),
                      isLabelVisible: appData.notificationCount > 0,
                      child: const Icon(Icons.notifications),
                    ),
                    title: const Text(
                        'Notifications'), // Use appData.notificationCount
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 3,
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 4,
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                  ),
                ),
              ],
              onSelected: (value) async {
                if (value == 1) {
                  Navigator.pushNamed(context, "/profile");
                } else if (value == 2) {
                  Navigator.pushNamed(context, "/notifications");
                } else if (value == 3) {
                  Navigator.pushNamed(context, "/settings");
                } else if (value == 4) {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool("logout", true);
                  await Backendless.userService.logout();
                  CustomToasts.showDefaultToast("Logged out!");
                  Navigator.pushReplacementNamed(context, "/register");
                }
              },
            )
          ],
          // title: const Text('Top Tab Bar Navigation'),
          bottom: TabBar(
            controller: _tabController,
            dragStartBehavior: DragStartBehavior.down,
            labelColor: appData.activeTabBarColor,
            indicatorColor: appData.activeTabBarColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 1,
            labelPadding: const EdgeInsets.all(10),
            onTap: (int index) {
              switch (index) {
                case 1:
                  appData.updateActiveTabColor(AppColors.error);
                  break;
                case 2:
                  appData.updateActiveTabColor(Colors.teal);
                  break;
                case 3:
                  appData.updateActiveTabColor(AppColors.secondary);
                  break;
                case 4:
                  appData.updateActiveTabColor(Colors.purpleAccent);
                  break;
                case 5:
                  appData.updateActiveTabColor(Colors.amberAccent);
                  break;
                default:
                  appData.updateActiveTabColor(AppColors.primary);
              }
            },
            tabs: tabbarIcons,
          ),
        ),
        body: TabBarView(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          controller: _tabController,
          children: const [
            // Content for Tab 1
            HomeScreen(),
            // Content for Tab 2
            BloodSugarScreen(),
            // Content for Tab 3
            DietScreen(),
            // Content for Tab 4
            ExercisesScreen(),
            // Content for Tab 5
            InsulinScreen(),
            // Content for Tab 6
            SupplementScreen(),
          ],
        ),
      ),
    );
  }
}
