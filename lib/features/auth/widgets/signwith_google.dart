import 'dart:math';

import 'package:autobetics/apis/supabase.dart';
import 'package:autobetics/models/app_model.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

final supabaseAPI = SupaBaseAPI();

class SignWithGoogle extends StatelessWidget {
  const SignWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context, listen: true);
    return Container(
      padding: const EdgeInsets.all(10),
      child: FilledButton(
          onPressed: () async {
            final result = await supabaseAPI.signInWithGoogle();
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
