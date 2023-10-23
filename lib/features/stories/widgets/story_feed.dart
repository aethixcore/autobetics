import 'package:flutter/material.dart';

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
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(postImageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(profileImageUrl),
              ),
              const SizedBox(height: 12),
              Text(
                username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                postText,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    postHeading,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Add your time and source here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
