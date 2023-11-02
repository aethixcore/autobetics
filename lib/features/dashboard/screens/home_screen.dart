import 'package:autobetics/features/dashboard/widgets/dashboard_piechart.dart';
import 'package:autobetics/features/dashboard/widgets/tip_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: const Column(children: [
          DashboardPieChart(),
          /*   Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Scircle(text: "Hi", icon: FontAwesome.align_left),
              Scircle(text: "There", icon: FontAwesome.align_left),
            ],
          ), */
          SizedBox(height: 30),
          TipCard(),
          //end of content normalize
          SizedBox(
            height: 70,
          )
        ]),
      ),
    );
  }
}
