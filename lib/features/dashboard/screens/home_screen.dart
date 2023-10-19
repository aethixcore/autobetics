// import 'package:autobetics/features/dashboard/widgets/tip_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// import 'package:autobetics/features/dashboard/widgets/scircle.dart';
// import 'package:autobetics/features/dashboard/widgets/dashboard_piechart.dart';
// import 'package:icons_plus/icons_plus.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ActivityCardWithChart(
              title: 'Blood Sugar',
              chartData: const [1.0, 1.5, 1.7, 1.2, 1.8, 1.6, 1.9],
              chartColor: Colors.blue,
              onTap: () {
                // Navigate to the Blood Sugar screen.
                // Add navigation logic here.
              },
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2, 
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              padding: const EdgeInsets.all(16.0),
              children: [
                ActivityCardWithChart(
                  title: 'Blood Sugar',
                  chartData: const [1.0, 1.5, 1.7, 1.2, 1.8, 1.6, 1.9],
                  chartColor: Colors.blue,
                  onTap: () {
                    // Navigate to the Blood Sugar screen.
                    // Add navigation logic here.
                  },
                ),
                ActivityCardWithChart(
                  title: 'Diet',
                  chartData: const [150, 220, 180, 200, 250, 170, 210],
                  chartColor: Colors.green,
                  onTap: () {
                    // Navigate to the Diet screen.
                    // Add navigation logic here.
                  },
                ),
                ActivityCardWithChart(
                  title: 'Exercises',
                  chartData: const [30, 45, 60, 40, 55, 35, 50],
                  chartColor: Colors.red,
                  onTap: () {
                    // Navigate to the Exercises screen.
                    // Add navigation logic here.
                  },
                ),
                ActivityCardWithChart(
                  title: 'Insulin',
                  chartData: const [10, 15, 12, 18, 14, 16, 20],
                  chartColor: Colors.orange,
                  onTap: () {
                    // Navigate to the Insulin screen.
                    // Add navigation logic here.
                  },
                ),
                ActivityCardWithChart(
                  title: 'Supplements',
                  chartData: const [5, 6, 7, 6, 8, 6, 7],
                  chartColor: Colors.purple,
                  onTap: () {
                    // Navigate to the Supplements screen.
                    // Add navigation logic here.
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityCardWithChart extends StatelessWidget {
  final String title;
  final List<double> chartData;
  final void Function() onTap;
  final Color chartColor;

  const ActivityCardWithChart({
    super.key,
    required this.title,
    required this.chartData,
    required this.onTap,
    required this.chartColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      horizontalInterval: 10.0,
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                        showTitles: true,
                        interval: 20.0,
                        reservedSize: 20,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toInt().toString());
                        },
                      )
                      ),
                      bottomTitles: const AxisTitles(
                          sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1.0,
                      )),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                        color: const Color(0xff37434d),
                        width: 1,
                      ),
                    ),
                    minX: 0,
                    maxX: (chartData.length - 1).toDouble(),
                    minY: chartData.reduce(
                            (min, current) => min > current ? current : min) -
                        5.0,
                    maxY: chartData.reduce(
                            (max, current) => max < current ? current : max) +
                        5.0,
                    lineBarsData: [
                      LineChartBarData(
                        spots: chartData.asMap().entries.map((entry) {
                          return FlSpot(entry.key.toDouble(), entry.value);
                        }).toList(),
                        isCurved: true,
                        color: chartColor,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
