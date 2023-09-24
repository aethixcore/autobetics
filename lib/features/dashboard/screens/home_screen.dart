import 'package:autobetics/features/dashboard/widgets/tip_card.dart';
import 'package:flutter/material.dart';

import 'package:autobetics/features/dashboard/widgets/scircle.dart';
import 'package:autobetics/features/dashboard/widgets/dashboard_piechart.dart';
import 'package:icons_plus/icons_plus.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.sizeOf(context).height,
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
        TipCard()
      ]),
    );
  }
}
