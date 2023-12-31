// ignore_for_file: use_build_context_synchronously

import 'package:autobetics/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgePicker extends StatelessWidget {
  const AgePicker({super.key});

  Future<void> _selectDate(BuildContext context) async {
    final onBoardingModel =
        Provider.of<OnBoardingModel>(context, listen: false);
    DateTime selectedDate = onBoardingModel.age;
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        fieldLabelText: "Date of Birth",
        confirmText: "SET",
        cancelText: "CANCEL");
    if (picked != null) {
      // String dob = getFormattedDate(picked);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("dob", picked.toIso8601String());
      onBoardingModel.updateAge(picked);
      onBoardingModel.age = picked;
      onBoardingModel.nextPage();
      FocusScope.of(context).requestFocus(onBoardingModel.weightFocusNode);
    }
  }

  String getFormattedDate(DateTime date) {
    return DateFormat('EEE MMMM dd, y').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<OnBoardingModel>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            getFormattedDate(data.age),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: const Text('Set Birthday'),
          ),
        ],
      ),
    );
  }
}
