import 'package:autobetics/models/onboarding_model.dart';
import 'package:autobetics/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BloodPressureInputWidget extends StatelessWidget {
  const BloodPressureInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<OnBoardingData>(context, listen: false);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextFormField(
              controller: data.systolicBPController,
              focusNode: data.systolicFocusNode,
              cursorColor: AppColors.onSecondary,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Systolic Pressure",
                // labelStyle: TextStyle(
                //     color: AppColors.onPrimary,
                //     fontWeight: FontWeight.bold),
                hintText: '119.9 mmHg',
                hintStyle: TextStyle(color: AppColors.onSecondary),
                // enabledBorder: OutlineInputBorder(
                //     borderSide: BorderSide(color: AppColors.onPrimary)),
                focusColor: AppColors.onSecondary,
                focusedBorder: OutlineInputBorder(
                  // Set border color here
                  borderSide: BorderSide(
                      color:
                          AppColors.onSecondary), // Specify the desired color
                ),
              ),
              onChanged: (newValue) {
                final double parsedValue = double.tryParse(newValue) ?? 0.0;
                data.bloodPressure["systolicPressure"] = parsedValue;
                print(data.bloodPressure);
              },
              onFieldSubmitted: (_) {
                if (data.systolicBPController.text.isNotEmpty) {
                  FocusScope.of(context).requestFocus(data.diastolicFocusNode);
                } else {
                  FocusScope.of(context).requestFocus(data.systolicFocusNode);
                }
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextFormField(
            focusNode: data.diastolicFocusNode,
            controller: data.diastolicBPController,
            cursorColor: AppColors.onSecondary,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Diastolic Pressure",
              // labelStyle: TextStyle(
              //     color: AppColors.onPrimary,
              //     fontWeight: FontWeight.bold),
              hintText: '80.03 mmHg',
              hintStyle: TextStyle(color: AppColors.onSecondary),
              // enabledBorder: OutlineInputBorder(
              //     borderSide: BorderSide(color: AppColors.onPrimary)),
              focusColor: AppColors.onSecondary,
              focusedBorder: OutlineInputBorder(
                // Set border color here
                borderSide: BorderSide(
                    color: AppColors.onSecondary), // Specify the desired color
              ),
            ),
            onChanged: (newValue) {
              final double parsedValue = double.tryParse(newValue) ?? 0.0;
              data.bloodPressure["diastolicPressure"] = parsedValue;
              print(data.bloodPressure);
            },
            onFieldSubmitted: (_) {
              if (data.bloodPressure["systolicPressure"] != 0.00 &&
                  data.bloodPressure["diastolicPressure"] != 0.00) {
                data.nextPage();
              }
            },
          ),
        ),
      ],
    );
  }
}
