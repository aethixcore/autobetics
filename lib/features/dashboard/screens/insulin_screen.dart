// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';

import 'package:autobetics/apis/api.dart';
import 'package:autobetics/features/dashboard/screens/bloodsugar_screen.dart';
import 'package:autobetics/features/widgets/custom_toast.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsulinScreen extends StatefulWidget {
  const InsulinScreen({super.key});

  @override
  _InsulinScreenState createState() => _InsulinScreenState();
}
final blApi = BackendlessAPI();
class _InsulinScreenState extends State<InsulinScreen> {
  List<InsulinRecord> _insulinRecords = [];
  String _newInsulinValue = "";
  String _userId = "";
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _insulinController = TextEditingController();
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

  void _loadInsulinData() async {
    final records = await getUserSpecificInsulinRecords(_userId);
    if (mounted) {
      setState(() {
        _insulinRecords = records;
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
        _loadInsulinData();
      });
    });
  }

  _centerWidget() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else {
      return _noRecords
          ? const Center(
              child: Text("No insulin records found."),
            )
          : SizedBox(
              height: 200, // Set a fixed height for the ListView
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _insulinRecords.length,
                itemBuilder: (context, index) {
                  final reading = _insulinRecords[index];
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

  void _calculateAndUpdateMean() {
    final sum = _insulinRecords.fold<double>(
      0.0,
          (previousValue, element) => previousValue + element.value,
    );
    final mean = sum / _insulinRecords.length;

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
        existingStatsRecord!['insulin'] = percentageValue;

        await Backendless.data.of("Stats").save(existingStatsRecord!);
      } else {
        // If no existing record is found, you can choose to create a new one or handle it accordingly.
        // For now, I'll just log a message.
        print('No existing record found in Stats table for userId: $_userId');
      }
    } catch (e) {
      CustomToasts.showWarningToast("Error while saving Stats record: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Insulin Reading:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _insulinController,
                      decoration: const InputDecoration(
                        labelText: 'Insulin Level (mg/dL)',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (mounted) {
                          setState(() {
                            _newInsulinValue = value;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    isExtended: true,
                    onPressed: _addInsulinRecord,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Insulin History:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _centerWidget()
            ],
          ),
        ),
      ),
    );
  }

  void _addInsulinRecord() async {
    if (_newInsulinValue.isNotEmpty) {
      final newInsulin = double.parse(_newInsulinValue);
      if (!newInsulin.isNaN) {
        try {
          final data = {
            "value": newInsulin,
          };

          await Backendless.data.of("Insulin").save(data);
          CustomToasts.showInfoToast("Record succesfully sent.");
          // Clear the text field
          _insulinController.clear();
          if (mounted) {
            setState(() {
              _newInsulinValue = "";
            });
          }
          final records = await getUserSpecificInsulinRecords(_userId);
            setState(() {
              _insulinRecords = records;
            });
          // Calculate and update the mean
          _calculateAndUpdateMean();
        } catch (e) {
          CustomToasts.showWarningToast(
              "Error while saving Insulin record: $e");
        }
      }
    }
  }
}

class InsulinRecord {
  final String objectId; // User's ID
  final double value; // Blood sugar value
  final DateTime date; // Date

  InsulinRecord(
      {required this.objectId, required this.value, required this.date});
  Map<String, dynamic> toJson() {
    return {
      'objectId': objectId, // User's ID
      'value': value,
      'date': date.toUtc().toIso8601String(),
    };
  }
}

class InsulinRecordItem extends StatelessWidget {
  final InsulinRecord record;

  const InsulinRecordItem(this.record, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Insulin Level: ${record.value} mg/dL'),
      subtitle: Text('Date & Time: ${record.date.toLocal()}'),
    );
  }
}

Future<List<InsulinRecord>> getUserSpecificInsulinRecords(String userId) async {
  try {
    final whereClause = "ownerId = '$userId'";
    final queryBuilder = DataQueryBuilder()..whereClause = whereClause;

    final response = await Backendless.data.of("Insulin").find(queryBuilder);

    final records = (response as List).map<InsulinRecord>((data) {
      final value =
          data['value'] is int ? data['value'].toDouble() : data['value'];

      final date = DateTime.parse(data['created'].toString());
      return InsulinRecord(objectId: userId, value: value, date: date);
    }).toList();

    return records;
  } catch (e) {
    return [];
  }
}
