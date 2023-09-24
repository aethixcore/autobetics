import 'package:flutter/material.dart';

class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: MediaQuery.sizeOf(context).height,
      child: const Column(children: [
        Row(
          children: [
            Text(
              "Stories",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            )
          ],
        )
      ]),
    );
  }
}
