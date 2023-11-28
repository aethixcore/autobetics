import 'dart:io';

import 'package:flutter/cupertino.dart';

class SelectedImagesWidget extends StatelessWidget {
  final List<File> selectedImages;

  const SelectedImagesWidget({super.key, required this.selectedImages});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: selectedImages.isNotEmpty
          ? [
              const Text(
                'Selected Images:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 100, // Adjust the height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        selectedImages[index],
                        width: 80, // Adjust the width as needed
                        height: 80, // Adjust the height as needed
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ]
          : [],
    );
  }
}
