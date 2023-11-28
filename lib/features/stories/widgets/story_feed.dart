import 'dart:math';

import 'package:autobetics/utils/truncate_string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StoryFeed extends StatelessWidget {
  final String created;
  final String username;
  final String avatar;
  final String postHeading;
  final String postText;
  final List<dynamic> coverImages;

  StoryFeed({super.key,
    required this.created,
    required this.username,
    required this.avatar,
    required this.postHeading,
    required this.postText,
    required this.coverImages,
  });
  @override
  Widget build(BuildContext context) {
    final cover = coverImages.isNotEmpty? coverImages.first: 'https://picsum.photos/200';
    return Card(child: Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Container(padding: const EdgeInsets.all(e * pi), width: MediaQuery.sizeOf(context).width * 0.6,child:  RichText(
           text: TextSpan(
             style: DefaultTextStyle.of(context).style,
             children:  [
               TextSpan(
                 text: truncateString(postHeading, 30),
                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
               ),
               const TextSpan(
                 text: '\n', // Adding some space between description and timestamp
               ),
               TextSpan(
                 text: truncateString(postText, 50),
                 style: const TextStyle(fontSize: 14),
               ),
               const TextSpan(
                 text: '\n\n', // Adding some space between description and timestamp
               ),
                TextSpan(
                 text:'Posted on ${DateFormat.yMd().format(DateTime.parse(created))}',
                 style: const TextStyle(color: Colors.grey),
               ),
               // const TextSpan(
               //   text: '  ', // Add some space between timestamp and read duration
               // ),
               // const TextSpan(
               //   text: 'Read Duration: 5 min',
               //   style: TextStyle(color: Colors.grey),
               // ),
             ],
           ),
         )),
          Stack(
            children: [

              Container(
                padding: const EdgeInsets.all(pi),
                width: MediaQuery.of(context).size.width * 0.30,
                height: 150,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.elliptical(12, 12)),
                  child: Image.network(
cover,                    fit: BoxFit.fitHeight, // Use BoxFit.cover to ensure the image fills the rounded container
                  ),
                ),
              ),
               Positioned(bottom: 7, left: 7,child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(avatar),
              )),
            ],
          )
        ],
      ),
    ));
  }
}
