import 'package:flutter/material.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  State<StoryScreen> createState() => _StoryState();
}

class _StoryState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _alias_name = '';
  String _alias_avatar = '';
  String _alias_created_at = '';
  String _alias_post = '';
  String _alias_title = '';
  List<dynamic> _alias_covers = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? storyData =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (storyData != null) {
      setState(() {
        _alias_name = storyData['name'] ?? '';
        _alias_avatar = storyData['avatar'] ?? '';
        _alias_created_at = storyData['created'] ?? '';
        _alias_post = storyData['post'] ?? '';
        _alias_title = storyData['title'] ?? '';
        _alias_covers = storyData['covers'] ?? [];
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_alias_title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Use PageView.builder for displaying multiple pictures
            if (_alias_covers.isNotEmpty)
              Container(
                height: 200,
                child: PageView.builder(
                  itemCount: _alias_covers.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      _alias_covers[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: _alias_post,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}