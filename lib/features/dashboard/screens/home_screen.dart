import 'package:autobetics/features/dashboard/widgets/tip_card.dart';
import 'package:flutter/material.dart';

import 'package:autobetics/features/dashboard/widgets/scircle.dart';
import 'package:autobetics/features/dashboard/widgets/dashboard_piechart.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const DashboardPieChart(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Scircle(text: "Hi", icon: FontAwesome.align_left),
              Scircle(text: "There", icon: FontAwesome.align_left),
            ],
          ),
          const SizedBox(height: 30),
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
