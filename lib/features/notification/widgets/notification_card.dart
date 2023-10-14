import 'package:flutter/material.dart';

Widget buildNotificationCard({
  required String title,
  required String description,
  required IconData icon,
}) {
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: ListTile(
      leading: Icon(
        icon,
        size: 36.0,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
      subtitle: Text(description),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 20.0,
      ),
      onTap: () {
        // Add functionality to navigate to a detailed notification screen
        // or perform the corresponding action for the notification.
      },
    ),
  );
}
