import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:autobetics/models/onboarding_model.dart';
import 'package:autobetics/utils/app_colors.dart';

class WeightInputScreen extends StatelessWidget {
  const WeightInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onBoardingModel =
        Provider.of<OnBoardingModel>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            textInputAction: TextInputAction.done,
            focusNode: onBoardingModel.weightFocusNode,
            controller: onBoardingModel.weightController,
            cursorColor: AppColors.onSecondary,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Weight",
              hintText: '53.5kg',
            ),
            onChanged: (weight) {
              final double parsedValue = double.tryParse(weight) ?? 0.0;
              onBoardingModel.updateWeight(parsedValue);
              onBoardingModel.weight = parsedValue;
            },
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
