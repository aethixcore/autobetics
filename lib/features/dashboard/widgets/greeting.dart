// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class Greeting extends StatelessWidget {
  final String userName;

  Greeting(
    this.userName, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(2, (index) {
          switch (index) {
            case 0:
              return Text(
                'Hello, $userName!',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              );
            default:
              return const Text(
                'Good Evening.',
                style: TextStyle(
                  // color: ThemeData.from(colorScheme: colorScheme),
                  shadows: [Shadow(blurRadius: 1.12)],
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              );
          }
        }),
      ),
    );
  }
}