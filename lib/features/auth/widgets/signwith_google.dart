import 'dart:math';

import 'package:autobetics/apis/api.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
final blApi = BackendlessAPI();

class SignWithGoogle extends StatelessWidget {
  const SignWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: FilledButton(
          onPressed: () async {
            final result = await blApi.signInWithGoogle();
            result.fold((error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(error.message),
              ));
            }, (res) {
              Future.delayed(const Duration(seconds: 3));
              Navigator.pushReplacementNamed(
                context,
                "/dashboard",
              );
            });
          },
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
