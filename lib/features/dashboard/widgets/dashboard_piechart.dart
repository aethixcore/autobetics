import 'package:autobetics/apis/api.dart';
import 'package:autobetics/features/widgets/custom_toast.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:icons_plus/icons_plus.dart';

class DashboardPieChart extends StatefulWidget {
  const DashboardPieChart({super.key});

  @override
  State<StatefulWidget> createState() => DashboardPieChartState();
}
final blApi = BackendlessAPI();
class DashboardPieChartState extends State {
  int touchedIndex = -1;
  Map touchedSection = {};
  Map? _stats;

  void updateSectionTextOnTouch(Map activeItem) {
    if (mounted) {
      setState(() {
        touchedSection = activeItem;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getStats();
  }

  Future<void> getStats() async {
    try {
      var userId;
      final userResult = await blApi.getCurrentUserDetails(context);
      userResult.fold((error) {}, (response) {
        userId = response.getProperty("ownerId");
      });
      final statsQuery = DataQueryBuilder()
        ..whereClause = "ownerId = '$userId'"; // Add the appropriate condition to identify the user
      // Simulate fetching data - Replace this with your actual data retrieval code
      final result =
          await Backendless.data.of("Stats").find(statsQuery); // Simulating a delay
final response = result!.first;
      // Replace this with your actual data retrieval code
      final data = {
        "bgl": response!["bgl"], // Replace with actual values
        "exercises": response["exercises"],
        "insulin": response["insulin"],
        "supplements": response["supplements"],
        "diet": response["diet"],
      };

      setState(() {
        if (mounted) {
          _stats = data;
        }
      });
    } catch (e) {
      CustomToasts.showErrorToast(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final gbl = _stats != null ? _stats!["bgl"] : 0;
    final exer = _stats != null ? _stats!["exercises"] : 0;
    final insulin = _stats != null ? _stats!["insulin"] : 0;
    final supps = _stats != null ? _stats!["supplements"] : 0;
    final diet = _stats != null ? _stats!["diet"] : 0;
    final sum = gbl + exer + insulin + supps + diet;

    // Calculate the average in percentage.
    final averagePercentage = ((sum / 500) * 100);

    return AspectRatio(
      aspectRatio: 1.3,
      child: Container(
        decoration: const BoxDecoration(),
        child: Stack(
          children: [
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
                            "value": double.parse('${_stats!["bgl"]}'),
                            "color": Colors.red,
                          };
                          break;
                        case 1:
                          touchedSection = {
                            "icon": FontAwesome.plate_wheat,
                            "placeholder": "Diet",
                            "value": double.parse('${_stats!["diet"]}'),
                            "color": Colors.teal,
                          };
                          break;
                        case 2:
                          touchedSection = {
                            "icon": FontAwesome.person_running,
                            "placeholder": "Exercises",
                            "value": double.parse('${_stats!["exercises"]}'),
                            "color": Colors.orange,
                          };
                          break;
                        case 3:
                          touchedSection = {
                            "icon": FontAwesome.syringe,
                            "placeholder": "Insulin/Med",
                            "value": double.parse('${_stats!["insulin"]}'),
                            "color": Colors.purple,
                          };
                          break;
                        case 4:
                          touchedSection = {
                            "icon": FontAwesome.pills,
                            "placeholder": "Supplements",
                            "value": double.parse('${_stats!["supplements"]}'),
                            "color": Colors.green,
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
                curve: Curves.decelerate,
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: touchedSection.isEmpty
                          ? Colors.blue.withAlpha(120)
                          : touchedSection["color"],
                      blurRadius: 2,
                    ),
                  ],
                  border: Border.all(
                    width: 0.35,
                    color: touchedSection.isEmpty
                        ? Colors.blue
                        : touchedSection["color"],
                  ),
                ),
                child: Center(
                  child: touchedSection.isEmpty
                      ? CenterPlaceholder(
                          iconData: Icons.graphic_eq_outlined,
                          value: double.parse('$averagePercentage')
                              .roundToDouble(),
                          placeholder: "Overview")
                      : CenterPlaceholder(
                          iconData: touchedSection["icon"],
                          value: touchedSection["value"],
                          placeholder: touchedSection["placeholder"],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final sections = <PieChartSectionData>[];

    if (_stats != null) {
      final gbl = _stats!["bgl"];
      final exer = _stats!["exercises"];
      final insulin = _stats!["insulin"];
      final supps = _stats!["supplements"];
      final diet = _stats!["diet"];

      if (gbl > 0) {
        sections.add(PieChartSectionData(
          color: Colors.red,
          value: gbl.toDouble(),
          title: "${double.parse(gbl.toString()).floorToDouble()}%",
          radius: touchedIndex == 0 ? 45 : 35.25,
          titleStyle: TextStyle(
            fontSize: touchedIndex == 0 ? 20 : 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
          badgeWidget: _Badge(
            Icons.bloodtype,
            size: touchedIndex == 0 ? 40 : 30,
            color: Colors.red,
            borderColor: Colors.red,
          ),
          badgePositionPercentageOffset: 1,
          titlePositionPercentageOffset: touchedIndex == 0 ? .45 : .40,
        ));
      }

      if (diet > 0) {
        sections.add(PieChartSectionData(
          color: Colors.teal,
          value: diet.toDouble(),
          title:  "${double.parse(diet.toString()).floorToDouble()}%",
          radius: touchedIndex == 1 ? 45 : 35.25,
          titleStyle: TextStyle(
            fontSize: touchedIndex == 1 ? 20 : 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
          badgeWidget: _Badge(
            FontAwesome.plate_wheat,
            size: touchedIndex == 1 ? 40 : 30,
            color: Colors.teal,
            borderColor: Colors.teal,
          ),
          badgePositionPercentageOffset: 1,
          titlePositionPercentageOffset: touchedIndex == 1 ? .45 : .40,
        ));
      }

      if (exer > 0) {
        sections.add(PieChartSectionData(
          color: Colors.orange,
          value: exer.toDouble(),
          title:  "${double.parse(exer.toString()).floorToDouble()}%",
          radius: touchedIndex == 2 ? 45 : 35.25,
          titleStyle: TextStyle(
            fontSize: touchedIndex == 2 ? 20 : 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
          badgeWidget: _Badge(
            FontAwesome.person_running,
            size: touchedIndex == 2 ? 40 : 30,
            color: Colors.orange,
            borderColor: Colors.orange,
          ),
          badgePositionPercentageOffset: 1,
          titlePositionPercentageOffset: touchedIndex == 2 ? .45 : .40,
        ));
      }

      if (insulin > 0) {
        sections.add(PieChartSectionData(
          color: Colors.purple,
          value: insulin.toDouble(),
          title:  "${double.parse(insulin.toString()).floorToDouble()}%",
          radius: touchedIndex == 3 ? 45 : 35.25,
          titleStyle: TextStyle(
            fontSize: touchedIndex == 3 ? 20 : 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
          badgeWidget: _Badge(
            FontAwesome.syringe,
            size: touchedIndex == 3 ? 40 : 30,
            color: Colors.purple,
            borderColor: Colors.purple,
          ),
          badgePositionPercentageOffset: 1,
          titlePositionPercentageOffset: touchedIndex == 3 ? .45 : .40,
        ));
      }

      if (supps > 0) {
        sections.add(PieChartSectionData(
          color: Colors.green,
          value: supps.toDouble(),
          title:  "${double.parse(supps.toString()).roundToDouble()}%",
          radius: touchedIndex == 4 ? 45 : 35.25,
          titleStyle: TextStyle(
            fontSize: touchedIndex == 4 ? 20 : 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
          badgeWidget: _Badge(
            FontAwesome.pills,
            size: touchedIndex == 4 ? 40 : 30,
            color: Colors.green,
            borderColor: Colors.green,
          ),
          badgePositionPercentageOffset: 1,
          titlePositionPercentageOffset: touchedIndex == 4 ? .45 : .40,
        ));
      }
    }

    return sections;
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
      curve: Curves.easeIn,
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
            blurRadius: 3,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          color: color,
          svgAsset,
          size: size * 0.6,
        ),
      ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          color: Colors.white70,
        ),
        Text("${value.toStringAsFixed(2)}%", style: const TextStyle(color: Colors.white)),
        Text(placeholder, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
