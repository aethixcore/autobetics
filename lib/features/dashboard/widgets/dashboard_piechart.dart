import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import 'package:autobetics/utils/app_colors.dart';

class DashboardPieChart extends StatefulWidget {
  const DashboardPieChart({super.key});

  @override
  State<StatefulWidget> createState() => DashboardPieChartState();
}

class DashboardPieChartState extends State {
  int touchedIndex = -1;
  Map touchedSection = {};

  void updateSectionTextOnTouch(Map activeItem) {
    setState(() {
      touchedSection = activeItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Container(
        decoration: BoxDecoration(),
        child: Stack(children: [
          PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    // touch events
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      touchedSection = {}; //reset the settings for active
                      return;
                    }
                    int index =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                    touchedIndex = index;
                    switch (index) {
                      case 0:
                        touchedSection = {
                          "icon": Icons.bloodtype,
                          "placeholder": "Blood Sugar",
                          "value": 49.35,
                          "color": AppColors.error,
                        };
                        break;
                      case 1:
                        touchedSection = {
                          "icon": FontAwesome.plate_wheat,
                          "placeholder": "Diet",
                          "value": 76.15,
                          "color": Colors.teal,
                        };
                        break;
                      case 2:
                        touchedSection = {
                          "icon": FontAwesome.person_running,
                          "placeholder": "Exercises",
                          "value": 38.13,
                          "color": AppColors.error.withAlpha(140),
                        };
                        break;
                      case 3:
                        touchedSection = {
                          "icon": FontAwesome.syringe,
                          "placeholder": "Insulin/Med",
                          "value": 56.7,
                          "color": Colors.purpleAccent,
                        };
                      case 4:
                        touchedSection = {
                          "icon": FontAwesome.pills,
                          "placeholder": "Suppliments",
                          "value": 40.0,
                          "color": Colors.amberAccent,
                        };
                        break;
                      default:
                        return;
                    }
                  });
                },
              ),
              borderData: FlBorderData(
                show: true,
              ),
              sectionsSpace: 4.5,
              centerSpaceRadius: 60,
              sections: showingSections(),
            ),
          ),
          Center(
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                curve: decelerateEasing,
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: touchedSection.isEmpty
                            ? AppColors.primary.withAlpha(120)
                            : touchedSection["color"],
                        blurRadius: 2,
                      ),
                    ],
                    border: Border.all(
                        width: 0.35,
                        color: touchedSection.isEmpty
                            ? AppColors.primary
                            : touchedSection["color"])),
                child: Center(
                  child: touchedSection.isEmpty
                      ? const CenterPlaceholder(
                          iconData: Icons.graphic_eq_outlined,
                          value:
                              ((49.35 + 76.15 + 38.13 + 56.7 + 40) / 500) * 100,
                          placeholder: "Overview")
                      : CenterPlaceholder(
                          iconData: touchedSection["icon"],
                          value: touchedSection["value"],
                          placeholder: touchedSection["placeholder"]),
                )),
          ),
        ]),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? touchedSection["value"] : 35.25;
      final widgetSize = isTouched ? 35.0 : 30.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
              color: AppColors.error,
              value: 49.35,
              title: isTouched ? "" : '49.35%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff),
              ),
              badgeWidget: _Badge(
                Icons.bloodtype,
                size: widgetSize,
                color: AppColors.error,
                borderColor: AppColors.error,
              ),
              badgePositionPercentageOffset: 1,
              titlePositionPercentageOffset: .40);
        case 1:
          return PieChartSectionData(
              color: Colors.teal,
              value: 76.15,
              title: isTouched ? "" : '76.15%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff),
              ),
              badgeWidget: _Badge(
                FontAwesome.plate_wheat,
                size: widgetSize,
                color: Colors.teal,
                borderColor: Colors.teal,
              ),
              badgePositionPercentageOffset: 1,
              titlePositionPercentageOffset: .40);
        case 2:
          return PieChartSectionData(
              color: AppColors.secondary.withAlpha(220),
              value: 38.13,
              title: isTouched ? "" : '38.13%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff),
              ),
              badgeWidget: _Badge(
                FontAwesome.person_running,
                size: widgetSize,
                color: AppColors.secondary.withAlpha(220),
                borderColor: AppColors.secondary,
              ),
              badgePositionPercentageOffset: 1,
              titlePositionPercentageOffset: .40);
        case 3:
          return PieChartSectionData(
              color: Colors.purpleAccent,
              value: 56.70,
              title: isTouched ? "" : '56.7%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff),
              ),
              badgeWidget: _Badge(
                FontAwesome.syringe,
                size: widgetSize,
                color: Colors.purpleAccent,
                borderColor: Colors.purpleAccent,
              ),
              badgePositionPercentageOffset: 1,
              titlePositionPercentageOffset: .40);
        case 4:
          return PieChartSectionData(
              color: Colors.amberAccent,
              value: 40.0,
              title: isTouched ? "" : '40%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff),
              ),
              badgeWidget: _Badge(
                FontAwesome.pills,
                size: widgetSize,
                color: Colors.amberAccent,
                borderColor: Colors.amberAccent,
              ),
              badgePositionPercentageOffset: 1,
              titlePositionPercentageOffset: .40);
        default:
          throw Exception("Nothing matched!");
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.svgAsset, {
    required this.color,
    required this.borderColor,
    required this.size,
  });
  final IconData svgAsset;
  final double size;
  final Color borderColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 70),
      curve: accelerateEasing,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white70,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 0.35,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: borderColor,
            // offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Center(
          child: Icon(
        color: color,
        svgAsset,
        size: size * 0.6,
      )),
    );
  }
}

class CenterPlaceholder extends StatelessWidget {
  const CenterPlaceholder(
      {super.key,
      required this.iconData,
      required this.value,
      required this.placeholder});
  final IconData iconData;
  final double value;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(
        iconData,
        color: Colors.white70,
      ),
      Text("$value%", style: const TextStyle(color: Colors.white)),
      Text(placeholder, style: const TextStyle(color: Colors.white))
    ]);
  }
}
