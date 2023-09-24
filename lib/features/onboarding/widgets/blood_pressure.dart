import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:autobetics/models/onboarding_model.dart';
class BloodPressureInputWidget extends StatelessWidget {
  const BloodPressureInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final onBoardingModel = Provider.of<OnBoardingModel>(context, listen: false);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            controller: onBoardingModel.systolicBPController,
            focusNode: onBoardingModel.systolicFocusNode,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Systolic Pressure",
              hintText: '119.9 mmHg',
            ),
            onChanged: (newValue) {
              final double parsedValue = double.tryParse(newValue) ?? 0.0;
              onBoardingModel.bloodPressure["systolicPressure"] = parsedValue;
            },
          
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextFormField(
            textInputAction: TextInputAction.done,
            focusNode: onBoardingModel.diastolicFocusNode,
            controller: onBoardingModel.diastolicBPController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Diastolic Pressure",
              hintText: '80.03 mmHg',
            ),
            onChanged: (newValue) {
              final double parsedValue = double.tryParse(newValue) ?? 0.0;
              onBoardingModel.bloodPressure["diastolicPressure"] = parsedValue;
            },
           
          ),
        ),
      ],
    );
  }
}
