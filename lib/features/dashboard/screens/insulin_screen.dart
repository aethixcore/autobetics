import 'package:flutter/material.dart';

class InsulinScreen extends StatefulWidget {
  const InsulinScreen({super.key});

  @override
  _InsulinScreenState createState() => _InsulinScreenState();
}

class _InsulinScreenState extends State<InsulinScreen> {
  late List<InsulinRecord> _insulinRecords = [];
  String _newInsulinValue = "";
  DateTime _selectedDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    setState(() {
      _insulinRecords = [
        InsulinRecord(DateTime(2023, 10, 1, 8, 0), 12),
        InsulinRecord(DateTime(2023, 10, 2, 12, 30), 18),
        InsulinRecord(DateTime(2023, 10, 3, 10, 15), 15),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Add New Insulin Reading:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Insulin Level (mg/dL)',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _newInsulinValue = value;
                        });
                      },
                      initialValue: _newInsulinValue,
                    ),
                  ),
                  SizedBox(width: 10),
                  FloatingActionButton(
                    isExtended: true,
                    onPressed: () {
                      // Implement adding new supplements functionality.
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Insulin History:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _insulinRecords.length,
                itemBuilder: (context, index) {
                  return InsulinRecordItem(_insulinRecords[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addInsulinRecord() {
    if (_newInsulinValue.isNotEmpty) {
      final newInsulin = int.tryParse(_newInsulinValue);
      if (newInsulin != null) {
        final newRecord = InsulinRecord(_selectedDateTime, newInsulin);
        setState(() {
          _insulinRecords.add(newRecord);
          _insulinRecords.sort((a, b) => a.dateTime.compareTo(b.dateTime));
        });
        _newInsulinValue = "";
      }
    }
  }
}

class InsulinRecord {
  final DateTime dateTime;
  final int value;

  InsulinRecord(this.dateTime, this.value);
}

class InsulinRecordItem extends StatelessWidget {
  final InsulinRecord record;

  InsulinRecordItem(this.record, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Insulin Level: ${record.value} mg/dL'),
      subtitle: Text('Date & Time: ${record.dateTime.toLocal()}'),
    );
  }
}
