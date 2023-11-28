
import 'package:autobetics/features/dashboard/screens/bloodsugar_screen.dart';
import 'package:autobetics/features/dashboard/screens/diet_screen.dart';
import 'package:autobetics/features/dashboard/screens/exercises_screen.dart';
import 'package:autobetics/features/dashboard/screens/supplement_screen.dart';
import 'package:autobetics/features/notification/widgets/notification_card.dart';
// import 'package:autobetics/models/app_model.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final appModel = Provider.of<AppModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes Management'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // if (appModel.verifiedEmail == false)
          //   TextButton(
          //     onPressed: () async {
              
                  
          //     },
          //     child: const Text('Verify Email'),
          //   ),
          buildNotificationCard(
            title: 'Medication Reminder',
            description: 'Take your medication at 8:00 AM and 8:00 PM',
            icon: Icons.medication,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SupplementScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          buildNotificationCard(
            title: 'Blood Sugar Check',
            description: 'Check your blood sugar level at 9:00 AM',
            icon: Icons.favorite,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BloodSugarScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          buildNotificationCard(
            title: 'Meal Time',
            description: 'Lunch time at 12:30 PM',
            icon: Icons.fastfood,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DietScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          buildNotificationCard(
            title: 'Exercise Reminder',
            description: 'Start your exercise routine at 5:30 PM',
            icon: Icons.directions_run,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExercisesScreen(),
                ),
              );
            },
          
          ),
        ],
      ),
    );
  }
}
