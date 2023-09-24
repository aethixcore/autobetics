// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class Scircle extends StatelessWidget {
  final String text;
  final IconData icon;

  Scircle({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 2000),
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        // color: AppColors.surface, // You can change the color here
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 4.0),
          Icon(
            icon,
            size: 16,
          ),
          Text(text),
        ],
      ),
    );
  }
}
