import 'dart:math';

import 'package:autobetics/features/notification/widgets/notification_card.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes Management'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildNotificationCard(
            title: 'Medication Reminder',
            description: 'Take your medication at 8:00 AM and 8:00 PM',
            icon: Icons.medication,
          ),
          const SizedBox(height: 12),
          buildNotificationCard(
            title: 'Blood Sugar Check',
            description: 'Check your blood sugar level at 9:00 AM',
            icon: Icons.favorite,
          ),
          const SizedBox(height: 12),
          buildNotificationCard(
            title: 'Meal Time',
            description: 'Lunch time at 12:30 PM',
            icon: Icons.fastfood,
          ),
          const SizedBox(height: 12),
          buildNotificationCard(
            title: 'Exercise Reminder',
            description: 'Start your exercise routine at 5:30 PM',
            icon: Icons.directions_run,
          ),
        ],
      ),
    );
  }
}
