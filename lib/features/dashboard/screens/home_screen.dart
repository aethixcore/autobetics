import 'package:autobetics/apis/apis.dart';
import 'package:autobetics/constants/constants.dart';
import 'package:autobetics/features/dashboard/widgets/dashboard_piechart.dart';
import 'package:autobetics/features/dashboard/widgets/tip_card.dart';
import 'package:autobetics/models/app_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final dbAPI = DBAPI(db: autobetDatabase);

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
