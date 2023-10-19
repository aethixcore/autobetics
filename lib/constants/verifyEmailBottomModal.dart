// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:autobetics/features/dashboard/widgets/bottombar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void verfiyEmailBottomModal(BuildContext context, Account account) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        width: MediaQuery.sizeOf(context).width * .95,
        padding: EdgeInsets.all(pow(e, e).roundToDouble()),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              "Registration successful!",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: pow(e, e).roundToDouble()),
            ElevatedButton(
              onPressed: () async {
              
                  Navigator.of(context).pop();
                  final promise = await account.createVerification(
                      url: "https://autobetics-web-services.vercel.app");
                  if (kDebugMode) {
                    print(promise);
                  }
                  // Future.delayed(const Duration(milliseconds: 900));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Email verification link is sent to your mailing address.')),
                  );
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => DashboardWithBottomNav()));
              
              
              },
              child: const Text("Verify email"),
            ),
          ],
        ),
      );
    },
  );
}
