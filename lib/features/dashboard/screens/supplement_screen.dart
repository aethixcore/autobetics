// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:autobetics/features/widgets/custom_toast.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplementScreen extends StatefulWidget {
  const SupplementScreen({Key? key}) : super(key: key);

  @override
  State<SupplementScreen> createState() => _SupplementScreenState();
}

class _SupplementScreenState extends State<SupplementScreen> {
  List<SupplementItem> _supplementRecords = [];
  String _userId = "";
  String _name = "";
  String _frequencty = "";
  double _dosage = 0.0;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _supplementNameController =
      TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();
  bool _isLoading = true;
  bool _noRecords = false;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  void _loadSupplementData() async {
    final records = await getUserSpecificSupplementRecords(_userId);
    if (mounted) {
      setState(() {
        _supplementRecords = records;
        _isLoading = false;
        _noRecords = records.isEmpty;
      });
    }
  }

  void _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString("userDetails");
    final userDetails = jsonDecode(userJson!);
    try {
      final user = BackendlessUser.fromJson(userDetails);
      final userId = user.getObjectId();
      if (mounted) {
        setState(() {
          _userId = userId;
          _loadSupplementData();
        });
      }
    } catch (e) {
      prefs.setBool("logout", true);
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  void _showAddSupplementModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Add New Supplement',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onChanged: (value) => {
                    if (mounted)
                      {
                        setState(() {
                          _name = value;
                        })
                      }
                  },
                  controller: _supplementNameController,
                  decoration: const InputDecoration(
                    labelText: 'Supplement Name',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onChanged: (value) => {
                    if (mounted)
                      {
                        setState(() {
                          _dosage = double.parse(value);
                        })
                      }
                  },
                  controller: _dosageController,
                  decoration: const InputDecoration(
                    labelText: 'Dosage',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onChanged: (value) => {
                    if (mounted)
                      {
                        setState(() {
                          _frequencty = value;
                        })
                      }
                  },
                  controller: _frequencyController,
                  decoration: const InputDecoration(
                    labelText: 'Frequency',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addSupplementRecord,
                  child: const Text('Add Supplement'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  void _calculateAndUpdateMean() {
    final sum = _supplementRecords.fold<double>(
      0.0,
          (previousValue, element) => previousValue + element.dosage,
    );
    final mean = sum / _supplementRecords.length;

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
        existingStatsRecord!['supplements'] = percentageValue;

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


  void _addSupplementRecord() async {
    if (_name.isNotEmpty && !_dosage.isNaN && _frequencty.isNotEmpty) {
      try {
        final data = {
          "dosage": _dosage,
          "name": _name,
          "frequency": _frequencty
        };

        await Backendless.data.of("Supplements").save(data);
        CustomToasts.showInfoToast("Record successfully sent.");
        // Clear the text field
        _supplementNameController.clear();
        _dosageController.clear();
        _frequencyController.clear();
          setState(() {
            _name = "";
            _frequencty = "";
            _dosage = 0;
          });
        _calculateAndUpdateMean();
        Navigator.pop(context);
        final records = await getUserSpecificSupplementRecords(_userId);
        if (mounted) {
          setState(() {
            _supplementRecords = records;
          });
        }
      } catch (e) {
        CustomToasts.showWarningToast(
            "Error while saving Supplement record: $e");
      }
    }
  }

  Future<void> _deleteSupplementRecord(String objectId) async {
    try {
      await Backendless.data
          .of("Supplements")
          .remove(whereClause: "objectId = '$objectId'");
      CustomToasts.showInfoToast("Record deleted successfully.");
      final records = await getUserSpecificSupplementRecords(_userId);

        setState(() {
          _supplementRecords = records;
        });
      _calculateAndUpdateMean();
    } catch (e) {
      CustomToasts.showWarningToast(
          "Error while deleting Supplement record: $e");
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
              height: 400, // Set a fixed height for the ListView
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _supplementRecords.length,
                itemBuilder: (context, index) {
                  final SupplementItem supplement = _supplementRecords[index];
                  return SupplementItem(
                    dosage: supplement.dosage,
                    frequency: supplement.frequency,
                    name: supplement.name,
                    objectId: supplement.objectId,
                    onDelete: () {
                      _deleteSupplementRecord(supplement.objectId);
                    },
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
          'Supplements',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            FloatingActionButton(
              isExtended: true,
              onPressed: () {
                _showAddSupplementModal(context);
              },
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 10),
            _centerWidget(),
            const SizedBox(height: 20),
            // const Text(
            //   'Recommended:',
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Expanded(
            //   child: ListView(
            //     padding: const EdgeInsets.all(16.0),
            //     children: const <Widget>[
            //       RecommendedSupplementItem(
            //         name: 'Vitamin D',
            //         description: 'Supports bone health and immunity.',
            //         imageUrl: 'https:/picsum.photos/200',
            //       ),
            //       RecommendedSupplementItem(
            //         name: 'Omega-3 Fatty Acids',
            //         description: 'Promotes heart and brain health.',
            //         imageUrl: 'https:/picsum.photos/200',
            //       ),
            //       RecommendedSupplementItem(
            //         name: 'Probiotics',
            //         description: 'Improves gut health and digestion.',
            //         imageUrl: 'https:/picsum.photos/200',
            //       ),
            //       // Add more RecommendedSupplementItem widgets for additional supplements.
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
      extendBody: false,
    );
  }
}

Future<List<SupplementItem>> getUserSpecificSupplementRecords(
    String userId) async {
  try {
    final whereClause = "ownerId = '$userId'";
    final queryBuilder = DataQueryBuilder()..whereClause = whereClause;

    final response =
        await Backendless.data.of("Supplements").find(queryBuilder);

    final records = (response as List).map<SupplementItem>((data) {
      final name = data['name'] as String;
      final dosage = data['dosage'] as double;
      final frequency = data['frequency'] as String;
      final objectId = data["objectId"] as String;

      return SupplementItem(
          objectId: objectId, name: name, dosage: dosage, frequency: frequency);
    }).toList();

    return records;
  } catch (e) {
    return [];
  }
}

class RecommendedSupplementItem extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;

  const RecommendedSupplementItem({
    super.key,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            // Implement functionality to add recommended supplement to the user's list.
          },
        ),
      ),
    );
  }
}

class SupplementItem extends StatelessWidget {
  final String name;
  final double dosage;
  final String frequency;
  final void Function()? onDelete;
  final String objectId;

  const SupplementItem(
      {super.key,
      required this.name,
      required this.dosage,
      required this.frequency,
      this.onDelete,
      required this.objectId});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Dosage: $dosage mg'),
            Text('Frequency: $frequency'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
