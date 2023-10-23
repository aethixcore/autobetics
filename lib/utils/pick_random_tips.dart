import 'dart:math';

import '../constants/constants.dart';


String getRandomTip() {
  Random random = Random();
  int randomIndex = random.nextInt(tips.length);
  String randomTip = tips[randomIndex];
  return randomTip;
}

String generateRandomImageSource() {
  final randomImageNumber =
      Random().nextInt(1000); // Generates a random image number from 0 to 999
  return 'https://picsum.photos/100?image=$randomImageNumber';
}
