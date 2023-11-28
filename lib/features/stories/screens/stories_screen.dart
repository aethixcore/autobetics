// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously
import 'dart:convert';

import 'package:autobetics/features/stories/widgets/stories_appbar.dart';
import 'package:autobetics/features/stories/widgets/story_creation.dart';
import 'package:autobetics/features/stories/widgets/story_feed.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({Key? key}) : super(key: key);

  @override
  _StoriesState createState() => _StoriesState();
}

class _StoriesState extends State<StoriesScreen> {
  List<StoryFeed> _stories = [];
  final _scrollController = ScrollController();
  bool isFetching = true;

  @override
  void initState() {
    super.initState();
    _loadStories();
  }

  Future<void> _loadStories() async {
    try {
      final myQueryBuilder = DataQueryBuilder();
      final backendlessStories = await Backendless.data
          .of('Stories')
          .find(myQueryBuilder..addAllProperties());
      final stories = backendlessStories!.map((story) {
        // Decode the 'images' field if it's a JSON-encoded string
        final List<dynamic> decodedImages = jsonDecode(story!['images']);
        final created = story['created'].toString();

        return StoryFeed(
          username: story['alias_name'],
          created: created,
          avatar: story['avatarUrl'],
          postText: story['content'],
          coverImages: decodedImages,
          postHeading: story['title'],
        );
      }).toList();

      setState(() {
        _stories = stories;
        isFetching = false;
      });
    } catch (e) {
      debugPrint('Error loading stories: $e');
      setState(() {
        isFetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 100),
        child: FloatingActionButton(
          onPressed: () {
            // Open the story creation page
            Navigator.of(context).push(_createStoryPageRoute());
          },
          child: const Icon(Icons.add),
        ),
      ),
      appBar: const StoriesAppBar(),
      resizeToAvoidBottomInset: false,
      body: isFetching
          ? const LinearProgressIndicator()
          : SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: _stories.isEmpty
                      ? const [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text('No Stories'),
                          )
                        ]
                      : List.generate(_stories.length, (index) {
                          final created = _stories[index].created;
                          final username = _stories[index].username;
                          final avatar = _stories[index].avatar;
                          final postHeading = _stories[index].postHeading;
                          final postText = _stories[index].postText;
                          final coverImages = _stories[index].coverImages;

                          debugPrint("=== username ===");
                          debugPrint(username);
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                "/story",
                                arguments: {
                                  "avatar": avatar,
                                  "post": postText,
                                  "title": postHeading,
                                  "created": created,
                                  "name": username,
                                  "covers": coverImages,
                                },
                              );
                            },
                            child: StoryFeed(
                              created: created,
                              username: username,
                              avatar: avatar,
                              postHeading: postHeading,
                              postText: postText,
                              coverImages: coverImages,
                            ),
                          );
                        }),
                ),
              )),
    );
  }

  // Function to create the page route for story creation
  PageRouteBuilder _createStoryPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return const StoryCreation();
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
