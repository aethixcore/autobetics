import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class StoryFeed extends StatelessWidget {
  final String username;
  final String profileImageUrl;
  final String postHeading;
  final String postText;
  final String postImageUrl;

  const StoryFeed({
    super.key,
    required this.username,
    required this.profileImageUrl,
    required this.postHeading,
    required this.postText,
    required this.postImageUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(width: 12),
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(profileImageUrl),
            ),
            const SizedBox(width: 12),
            Text(
              username,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Text(
          postText,
          style: const TextStyle(),
        ),
        const SizedBox(height: 8),
        Image.network(postImageUrl, height: 250, fit: BoxFit.fitWidth),
        const SizedBox(height: 12),
        Stack(
          children: [
            IconButton.filled(
                onPressed: () {}, icon: const Icon(EvaIcons.activity)),
            Text(
              postHeading,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  shadows: [BoxShadow()]),
            ),
          ],
        )
      ],
    );
  }
}
