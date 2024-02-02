// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';

import 'package:autobetics/apis/api.dart';
import 'package:autobetics/features/widgets/custom_toast.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BloodSugarScreen extends StatefulWidget {
  const BloodSugarScreen({super.key});

  @override
  _BloodSugarScreenState createState() => _BloodSugarScreenState();
}
final blApi = BackendlessAPI();
class _BloodSugarScreenState extends State<BloodSugarScreen> {
  List<BloodSugarData> _bloodSugarReadings = [];
  String _userId = "";
  String _newReading = "";
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _readingController = TextEditingController();
  bool _isLoading = true;
  bool _noRecords = false;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _loadBloodSugarData() async {
    final records = await getUserSpecificBGLRecords(_userId);

    if (mounted) {
      setState(() {
        _bloodSugarReadings = records;
        _isLoading = false;
        _noRecords = records.isEmpty;
      });
    }
  }

  void _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final result = await blApi.getCurrentUserDetails(context);
    result.fold((l) {
      prefs.setBool("logout", true);
      Navigator.pushReplacementNamed(context, "/login");
    }, (r){
      final userId = r.getUserId();
      setState(() {
        _userId = userId;
        _loadBloodSugarData();
      });
    });
  }

  void _calculateAndUpdateMean() {
    final sum = _bloodSugarReadings.fold<double>(
      0.0,
      (previousValue, element) => previousValue + element.value,
    );
    final mean = sum / _bloodSugarReadings.length;

    // Calculate percentage value and send it to the Stats table
    final percentageValue = (mean / sum) * 100;

    // Now, you can save the percentageValue to the Stats table
    _saveStatsData(percentageValue);
  }
  Future<void> _saveStatsData(double percentageValue) async {
    try {
      final statsQuery = DataQueryBuilder()
        ..whereClause = "ownerId = '$_userId'"; // Add the appropriate condition to identify the user

      final statsResponse = await Backendless.data.of("Stats").find(statsQuery);
      if (statsResponse != null && statsResponse.length > 0) {
        // Update the existing record
        final existingStatsRecord = statsResponse.first;
        existingStatsRecord!['bgl'] = percentageValue;

        await Backendless.data.of("Stats").save(existingStatsRecord);
      } else {
        // If no existing record is found, you can choose to create a new one or handle it accordingly.
        // For now, I'll just log a message.
        print('No existing record found in Stats table for userId: $_userId');
      }
    } catch (e) {
      CustomToasts.showWarningToast("Error while saving Stats record: $e");
    }
  }


  void _addBloodSugarReading() async {
    if (_newReading.isNotEmpty) {
      final newReading = double.parse(_newReading);
      if (!newReading.isNaN) {
        try {
          final data = {
            "value": newReading,
          };

          await Backendless.data.of("BGL").save(data);
          CustomToasts.showInfoToast("Record succesfully sent.");
          // Clear the text field
          _readingController.clear();
          if (mounted) {
            setState(() {
              _newReading = "";
            });
          }
          final records = await getUserSpecificBGLRecords(_userId);

          setState(() {
            _bloodSugarReadings = records;
          });
          // Calculate and update the mean
          _calculateAndUpdateMean();
        } catch (e) {
          CustomToasts.showWarningToast("Error while saving BGL record: $e");
        }
      }
    }
  }

  _centerWidget() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else {
      return _noRecords
          ? const Center(
              child: Text("No supplement records found."),
            )
          : SizedBox(
              height: 200, // Set a fixed height for the ListView
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _bloodSugarReadings.length,
                itemBuilder: (context, index) {
                  final reading = _bloodSugarReadings[index];
                  return HistoryItem(
                    value: reading.value,
                    date:
                        DateFormat('MMM dd, yyyy hh:mm a').format(reading.date),
                  );
                },
              ),
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blood Sugar',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _readingController,
                      decoration: const InputDecoration(
                        labelText: 'Enter Blood Sugar Reading',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (mounted) {
                          setState(() {
                            _newReading = value;
                          });
                        }
                      },
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
                  // const SizedBox(height: 20),
                  // const Text(
                  //   'Recommendations:',
                  //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  // ),
                  // const SizedBox(height: 10),
                  // const RecommendationItem(
                  //   text:
                  //       'Maintain a balanced diet to stabilize your blood sugar levels.',
                  // ),
                  // const RecommendationItem(
                  //   text:
                  //       'Regularly engage in physical activities like walking or jogging.',
                  // ),
                  const SizedBox(height: 20),
                  const Text(
                    'Blood Sugar History:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _centerWidget()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<BloodSugarData>> getUserSpecificBGLRecords(String userId) async {
  try {
    final whereClause = "ownerId = '$userId'";
    final queryBuilder = DataQueryBuilder()..whereClause = whereClause;

    final response = await Backendless.data.of("BGL").find(queryBuilder);

    final records = (response as List).map<BloodSugarData>((data) {
      final value = double.parse(data['value'].toString());
      final date = DateTime.parse(data['created'].toString());
      return BloodSugarData(objectId: userId, value: value, date: date);
    }).toList();

    return records;
  } catch (e) {
    return [];
  }
}

class BloodSugarData {
  final String objectId; // User's ID
  final double value; // Blood sugar value
  final DateTime date; // Date of the reading

  BloodSugarData(
      {required this.objectId, required this.value, required this.date});

  Map<String, dynamic> toJson() {
    return {
      'objectId': objectId, // User's ID
      'value': value,
      'date': date.toUtc().toIso8601String(),
    };
  }
}

class RecommendationItem extends StatelessWidget {
  final String text;

  const RecommendationItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                text,
                softWrap: true,
              ),
            ),
          ],
        ));
  }
}

class HistoryItem extends StatelessWidget {
  final double value;
  final String date;

  const HistoryItem({super.key, required this.value, required this.date});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Reading: $value mg/dL'),
      subtitle: Text('Date: $date'),
    );
  }
}
