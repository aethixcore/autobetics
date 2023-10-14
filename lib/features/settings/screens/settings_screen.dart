import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'General Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: true, // Replace with your logic
              onChanged: (bool value) {
                // Implement your logic here
              },
            ),
            ListTile(
              title: const Text('Units'),
              subtitle: const Text('Change units of measurement'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to units settings
              },
            ),
            const Divider(),
            const Text(
              'Account',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Change Password'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to change password screen
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              trailing: const Icon(Icons.exit_to_app),
              onTap: () {
                // Implement log out functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
