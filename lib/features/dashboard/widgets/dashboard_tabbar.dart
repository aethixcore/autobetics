import 'package:autobetics/models/app_model.dart';
import 'package:autobetics/features/dashboard/screens/home_screen.dart';
import 'package:autobetics/utils/app_colors.dart';
import 'package:autobetics/features/dashboard/widgets/greeting.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

List<Widget> tabbarIcons = const [
  Icon(FontAwesome.hourglass),
  Icon(Icons.bloodtype),
  Icon(FontAwesome.plate_wheat),
  Icon(FontAwesome.person_running),
  Icon(FontAwesome.syringe),
  Icon(FontAwesome.pills),
];

class DashboardTabbar extends StatefulWidget {
  const DashboardTabbar({super.key});

  @override
  State<DashboardTabbar> createState() => _DashboardTabbarState();
}

class _DashboardTabbarState extends State<DashboardTabbar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 6, vsync: this); // Specify the vsync parameter here.
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppModel>(context);
    return DefaultTabController(
      length: 6, // Specify the number of tabs
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.sizeOf(context).height * 0.105,
          leading: Greeting("devRed"),
          leadingWidth: MediaQuery.sizeOf(context).width,
          actions: [
            PopupMenuButton<int>(
              icon: const Icon(FontAwesome.ellipsis_vertical),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('Option 1'),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text('Option 2'),
                ),
              ],
              onSelected: (value) {
                // Handle the selected option here
                if (value == 1) {
                  // Do something for Option 1
                } else if (value == 2) {
                  // Do something for Option 2
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
          controller: _tabController,
          children: const [
            // Content for Tab 1
            Home(),
            // Content for Tab 2
            Center(child: Text('Tab 2 Content')),
            // Content for Tab 3
            Center(child: Text('Tab 3 Content')),
            // Content for Tab 4
            Center(child: Text('Tab 4 Content')),
            // Content for Tab 5
            Center(child: Text('Tab 5 Content')),
            // Content for Tab 6
            Center(child: Text('Tab 6 Content')),
          ],
        ),
      ),
    );
  }
}
