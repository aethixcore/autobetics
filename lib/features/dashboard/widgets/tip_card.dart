// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:math';
import 'package:flutter/material.dart';

class TipCard extends StatelessWidget {
  TipCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Flex(
          direction: Axis.horizontal,
          children: [
            Icon(Icons.tips_and_updates),
            SizedBox(
              width: pi,
            ),
            Text(
              "Health tips!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .6,
              child: const Text(
                  "Regularly check your blood pressure and cholesterol levels.",
                  softWrap: true,
                  style: TextStyle(fontSize: 15, height: log2e)),
            ),
            Card(
              child: SizedBox.square(
                dimension: MediaQuery.sizeOf(context).height * .075,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), //clips radius
                  child: Image.network(
                    "https://picsum.photos/100",
                    fit: BoxFit.fitWidth,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const CircularProgressIndicator();
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Text('Error loading image');
                    },
                    // scale: 0.5,
                  ),
                ),
              ),
            )
          ],
        )
      ]),
    ));
  }
}
