// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:autobetics/utils/get_greetings.dart';
import 'package:flutter/material.dart';

class Greeting extends StatelessWidget {
  final String userName;
  final bool isNewUser;

  Greeting(
    this.userName, {
    super.key,
    this.isNewUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Expanded(
        flex: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getGreeting(isNewUser),
              style: const TextStyle(
                // color: ThemeData.from(colorScheme: colorScheme),
                shadows: [Shadow(blurRadius: 1.12)],
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
