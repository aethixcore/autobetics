import 'package:flutter/material.dart';

class DietScreen extends StatelessWidget {
  const DietScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Recommended Diet Plans:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          DietPlanItem(
            title: 'Low-Carb Diet',
            description:
                'A low-carb diet can help control blood sugar levels by reducing glucose intake.',
            imageUrl: 'https://picsum.photos/200',
          ),
          DietPlanItem(
              title: 'Mediterranean Diet',
              description:
                  'The Mediterranean diet is rich in fruits, vegetables, and whole grains.',
              imageUrl: 'https://picsum.photos/200'),
          DietPlanItem(
              title: 'DASH Diet',
              description:
                  'Dietary Approaches to Stop Hypertension (DASH) emphasizes fruits, vegetables, and lean proteins.',
              imageUrl: 'https://picsum.photos/200'),
          // Add more DietPlanItem widgets for additional diet plans.
        ],
      ),
    ));
  }
}

class DietPlanItem extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl; // Add an imageUrl field for the image preview.

  DietPlanItem({
    required this.title,
    required this.description,
    required this.imageUrl, // Pass the image URL when creating a DietPlanItem.
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(description),
            SizedBox(height: 8.0),
            Image.network(
              imageUrl,
              height: 100, // Adjust the height as needed.
              width: double.infinity, // Make the image span the entire width.
              fit: BoxFit.cover, // Ensure the image scales correctly.
            ),
          ],
        ),
        // You can add an onTap callback to navigate to a detailed diet plan screen.
      ),
    );
  }
}
