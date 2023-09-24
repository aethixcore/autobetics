import 'dart:math';

import 'package:flutter/material.dart';

void verfiyEmailBottomModal(BuildContext context) {
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
                  Future.delayed(const Duration(milliseconds: 900));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Email verification link is sent to your mailing address.')),
                  );
                
              },
              child: const Text("Verify email"),
            ),
          ],
        ),
      );
    },
  );
}
