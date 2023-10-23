import 'dart:async';
import 'dart:math';
import 'package:autobetics/utils/pick_random_tips.dart';
import 'package:flutter/material.dart';

class TipCard extends StatefulWidget {
  const TipCard({super.key});

  @override
  State<TipCard> createState() => _TipCardState();
}

class _TipCardState extends State<TipCard> {
  late String tip;
  late String imageUrl;
  late StreamSubscription<void> timerSubscription;

  @override
  void initState() {
    super.initState();
    tip = getRandomTip();
    imageUrl = generateRandomImageSource();
    startPeriodicTask();
  }

  void startPeriodicTask() {
    timerSubscription =
        Stream.periodic(const Duration(minutes: 30)).listen((_) {
      setState(() {
        tip = getRandomTip();
        imageUrl = generateRandomImageSource();
      });
    });
  }

  @override
  void dispose() {
    timerSubscription.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Flex(
              direction: Axis.horizontal,
              children: [
                Icon(Icons.tips_and_updates),
                SizedBox(
                  width: pi,
                ),
                Text(
                  "Healthy tip of the moment!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    tip,
                    softWrap: true,
                    style: const TextStyle(fontSize: 15, height: log2e),
                  ),
                ),
                Flexible(
                  child: Card(
                    child: SizedBox.square(
                      dimension: MediaQuery.of(context).size.height * 0.075,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageUrl.isNotEmpty
                              ? imageUrl
                              : "https://picsum.photos/100",
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const CircularProgressIndicator();
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Error loading image');
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
