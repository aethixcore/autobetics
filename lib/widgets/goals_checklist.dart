import 'package:autobetics/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoalsCheckListWidget extends StatelessWidget {
  const GoalsCheckListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final onBoardingData = Provider.of<OnBoardingData>(context);

    return Column(
      children: onBoardingData.goals.map((goal) {
        return ListTile(
          focusNode: onBoardingData.listFocusNode,
          enabled: true,
          title: Text(goal),
          dense: true,
          onTap: () {
            Provider.of<OnBoardingData>(context, listen: false)
                .toggleSelectedGoal(goal);
          },
          trailing: Checkbox(
            value: onBoardingData.selectedGoals.contains(goal),
            onChanged: (value) {
              // Update the selected goals in the provider
              if (value != null) {
                Provider.of<OnBoardingData>(context, listen: false)
                    .toggleSelectedGoal(goal);
              }
            },
          ),
        );
      }).toList(),
    );
  }
}
