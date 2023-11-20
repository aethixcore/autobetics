import 'package:autobetics/features/notification/screens/notification_screen.dart';
import 'package:flutter/material.dart';

class StoriesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StoriesAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      elevation: 0.7,
      bottomOpacity: .1,
      leadingWidth: MediaQuery.sizeOf(context).width * 0.3,
      title:  const Text(
          'Stories',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.notifications,
            size: 28,
          ),
        ),
      ],
    );
  }
}
