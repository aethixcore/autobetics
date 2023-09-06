import 'package:autobetics/utils/app_colors.dart';
import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  final IconButton icon;

  const RoundedIconButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              50.0), // Adjust the value for the desired roundness
          color: AppColors.primary.withAlpha(100), // Button background color
        ),
        child: icon);
  }
}
