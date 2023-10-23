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
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Image.asset(
            'assets/autobetics.png',
            height: 50,
            fit: BoxFit.contain,
            colorBlendMode: BlendMode.hue,
            color: Colors.transparent,
          ),
        ),
        title: const Text(
          'Stories',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
        // IconButton(
        //   onPressed: () {
        //     // Add your search functionality here
        //   },
        //   icon: const Icon(
        //     Icons.search,
        //     size: 28,
        //   ),
        // ),
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
        // IconButton(
        //   onPressed: () {
        //     // Add your user profile functionality here
        //   },
        //   icon: const CircleAvatar(
        //     backgroundImage: NetworkImage(
        //       'https://picsum.photos/100', // Replace with user profile image URL
        //     ),
        //   ),
        // ),
        ],
      );
  }
}