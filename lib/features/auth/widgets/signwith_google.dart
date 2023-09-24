import 'dart:math';

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class SignWithGoogle extends StatelessWidget {
  const SignWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: FilledButton(
          onPressed: () {},
          style: const ButtonStyle(elevation: MaterialStatePropertyAll(e)),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Logo(Logos.google, size: 18),
              const SizedBox(
                width: 10,
              ),
              const Text("Signin with Google"),
            ],
          )),
    );
  }
}
