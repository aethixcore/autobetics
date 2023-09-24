// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:math';
import 'package:flutter/material.dart';

import 'package:autobetics/utils/app_colors.dart';

class TipCard extends StatelessWidget {
  TipCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: const Offset(.2, .2),
                  blurRadius: e,
                  spreadRadius: log10e,
                  blurStyle: BlurStyle.solid,
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.light
                      ? AppColors.primary.withAlpha(70)
                      : DarkAppColors.primary.withAlpha(100))
            ],
            color: MediaQuery.of(context).platformBrightness == Brightness.light
                ? AppColors.surface.withAlpha(240)
                : DarkAppColors.surface.withAlpha(200),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        padding: const EdgeInsets.all(10),
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
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), //border radius
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(.2, .2),
                        blurRadius: pi,
                        spreadRadius: log10e,
                        blurStyle: BlurStyle.solid,
                      )
                    ]),
                child: SizedBox.square(
                  dimension: MediaQuery.sizeOf(context).height * .075,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), //clips radius
                    child: Image.network(
                      "https://picsum.photos/200",
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const CircularProgressIndicator();
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('Error loading image');
                      },
                      scale: 0.5,
                    ),
                  ),
                ),
              )
            ],
          )
        ]));
  }
}
