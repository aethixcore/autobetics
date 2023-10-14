import 'package:autobetics/features/stories/widgets/stories_appbar.dart';
import 'package:autobetics/features/stories/widgets/story_feed.dart';
import 'package:flutter/material.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({Key? key}) : super(key: key);

  @override
  _StoriesState createState() => _StoriesState();
}

class _StoriesState extends State<StoriesScreen> {
  late List<StoryFeed> stories;
  final _scrollController = ScrollController(keepScrollOffset: false);

  @override
  void initState() {
    super.initState();
    stories = [
      const StoryFeed(
        username: 'John Doe',
        profileImageUrl: 'https://picsum.photos/200',
        postText: 'This is a sample post text!',
        postImageUrl: 'https://picsum.photos/200',
        postHeading: 'Man gain freedom from...',
      ),
      // Add more posts as needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StoriesAppBar(),
      resizeToAvoidBottomInset: false,
      body: Container(
        child: ListView.separated(
          controller: _scrollController,
          itemCount: stories.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: 8), // Add spacing between cards
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Handle the tap on the story, e.g., navigate to a detailed view.
                // You can replace this with your specific navigation logic.
                print('StoryFeed tapped: ${stories[index].username}');
              },
              child: Card(
                elevation: 4, // Add elevation for a card-like effect
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 15,
                        backgroundImage:
                            NetworkImage(stories[index].profileImageUrl),
                      ),
                      title: Text(
                        stories[index].username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Post Image
                    Image.network(
                      stories[index].postImageUrl,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: 200,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stories[index].postHeading,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(stories[index].postText),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
