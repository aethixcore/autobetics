import 'package:autobetics/models/onboarding_model.dart';
import 'package:autobetics/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeightInputScreen extends StatelessWidget {
  const WeightInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onBoardingData = Provider.of<OnBoardingData>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            focusNode: onBoardingData.weightFocusNode,
            controller: onBoardingData.weightController,
            cursorColor: AppColors.onSecondary,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Weight",
              // labelStyle: TextStyle(
              //     color: AppColors.onPrimary,
              //     fontWeight: FontWeight.bold),
              hintText: '53.5kg',
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
            onChanged: (weight) {
              final double parsedValue = double.tryParse(weight) ?? 0.0;
              final userData =
                  Provider.of<OnBoardingData>(context, listen: false);
              userData.updateWeight(parsedValue);
            },
            onEditingComplete: () {
              if (onBoardingData.weight != null) {
                onBoardingData.nextPage();
                FocusScope.of(context)
                    .requestFocus(onBoardingData.systolicFocusNode);
              }
            },
          ),
          const SizedBox(height: 20.0),
          /*   Consumer<OnBoardingData>(
            builder: (context, data, child) {
              return Text(
                'Your Weight: ${data.weight?.toStringAsFixed(2)}. kg',
                style: const TextStyle(fontSize: 18.0),
              );
            },
          ), */
        ],
      ),
    );
  }
}
