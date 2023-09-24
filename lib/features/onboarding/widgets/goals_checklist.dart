import 'dart:math';

import 'package:autobetics/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import 'package:autobetics/models/onboarding_model.dart';

class GoalsCheckListWidget extends StatelessWidget {
  const GoalsCheckListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final onBoardingModel = Provider.of<OnBoardingModel>(context);
    final activeColor =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? AppColors.primary
            : DarkAppColors.primary;

    final inActiveColor =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? AppColors.surface
            : DarkAppColors.surface;
    return Column(
      children: onBoardingModel.goals.map((goal) {
        bool selected = onBoardingModel.selectedGoals.contains(goal);
        return Container(
          margin: const EdgeInsets.all(log2e),
          decoration: BoxDecoration(
              border: Border.all(
                  width: selected ? log10e : 0,
                  color: selected ? activeColor : inActiveColor),
              borderRadius: BorderRadius.circular(log2e)),
          child: ListTile(
            style: ListTileStyle.drawer,
            visualDensity: VisualDensity.compact,
            focusNode: onBoardingModel.listFocusNode,
            selected: onBoardingModel.selectedGoals.contains(goal),
            selectedTileColor: activeColor,
            selectedColor: inActiveColor,
            enabled: true,
            title: Text(goal),
            dense: true,
            trailing: selected ? const Icon(LineAwesome.check_solid) : null,
            onTap: () {
              onBoardingModel.toggleSelectedGoal(goal);
            },
            
          ),
        );
      }).toList(),
    );
  }
}
