import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class BloodSugarScreen extends StatefulWidget {
  @override
  _BloodSugarScreenState createState() => _BloodSugarScreenState();
}

class _BloodSugarScreenState extends State<BloodSugarScreen> {
  List<BloodSugarData> _bloodSugarReadings = [];
  String _newReading = "";
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadBloodSugarData();
  }

  void _loadBloodSugarData() {
    // Replace this with your actual data retrieval logic.
    setState(() {
      _bloodSugarReadings = [
        BloodSugarData(DateTime(2023, 10, 1, 8, 0), 42),
        BloodSugarData(DateTime(2023, 10, 2, 8, 0), 10),
        BloodSugarData(DateTime(2023, 10, 1, 8, 0), 12),
        BloodSugarData(DateTime(2023, 10, 2, 8, 0), 19),
        BloodSugarData(DateTime(2023, 10, 1, 8, 0), 20),
        BloodSugarData(DateTime(2023, 10, 2, 8, 0), 30),
        BloodSugarData(DateTime(2023, 10, 1, 8, 0), 70),
        BloodSugarData(DateTime(2023, 10, 2, 8, 0), 110),
        // Add more data points here.
      ];
    });
  }

  void _addBloodSugarReading() {
    if (_newReading.isNotEmpty) {
      final newReading = int.tryParse(_newReading);
      if (newReading != null) {
        final newEntry = BloodSugarData(_selectedDate, newReading);
        setState(() {
          _bloodSugarReadings.add(newEntry);
          _bloodSugarReadings.sort((a, b) => a.date.compareTo(b.date));
        });
        _newReading = "";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Blood Sugar:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                        color: const Color(0xff37434d),
                        width: 1,
                      ),
                    ),
                    minX: 0,
                    maxX: _bloodSugarReadings.length.toDouble() - 1,
                    minY: 0,
                    maxY: 250, // Adjust the maximum Y value as needed.
                    lineBarsData: [
                      LineChartBarData(
                        spots: _bloodSugarReadings
                            .asMap()
                            .entries
                            .map(
                              (entry) => FlSpot(
                                entry.key.toDouble(),
                                entry.value.value.toDouble(),
                              ),
                            )
                            .toList(),
                        isCurved: true,
                        color: Colors.blue,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
              const Text('Select Date and Time for Reading:'),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        "${_selectedDate.toLocal()}".split(' ')[0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_down),
                      onTap: _pickDate,
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        "${_selectedDate.toLocal()}".split(' ')[1],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_down),
                      onTap: _pickTime,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Enter Blood Sugar Reading'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _newReading = value;
                        });
                      },
                      initialValue: _newReading,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _addBloodSugarReading,
                    child: const Text('Add Reading'),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Recommendations:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  RecommendationItem(
                    text:
                        'Maintain a balanced diet to stabilize your blood sugar levels.',
                  ),
                  RecommendationItem(
                    text:
                        'Regularly engage in physical activities like walking or jogging.',
                  ),
                  // Add more RecommendationItem widgets for additional recommendations.
                  const SizedBox(height: 20),
                  const Text(
                    'Blood Sugar History:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _bloodSugarReadings.map((reading) {
                      return HistoryItem(
                        value: reading.value,
                        date: DateFormat('MMM dd, yyyy hh:mm a')
                            .format(reading.date),
                      );
                    }).toList(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDate),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }
}

class BloodSugarData {
  final DateTime date;
  final int value;

  BloodSugarData(this.date, this.value);
}

class RecommendationItem extends StatelessWidget {
  final String text;

  RecommendationItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final int value;
  final String date;

  HistoryItem({required this.value, required this.date});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Reading: $value mg/dL'),
      subtitle: Text('Date: $date'),
    );
  }
}
