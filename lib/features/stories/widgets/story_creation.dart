// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:autobetics/features/widgets/custom_toast.dart';
import 'package:autobetics/utils/app_colors.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class StoryCreation extends StatefulWidget {
  const StoryCreation({Key? key}) : super(key: key);

  @override
  State<StoryCreation> createState() => _StoryCreationState();
}

class _StoryCreationState extends State<StoryCreation> {
  final _multiImageController = MultiImagePickerController(
    maxImages: 3,
    withReadStream: true,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _storyController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  bool emojiShowing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Story'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTitleInput(),
              const SizedBox(height: 16),
              MultiImagePickerView(
                onChange: (list) {
                  debugPrint(list.toString());
                },
                controller: _multiImageController,
                padding: const EdgeInsets.all(10),
              ),
              const SizedBox(height: 32),
              //  SelectedImagesWidget(
              //   selectedImages: _images!,
              // ),
              const SizedBox(height: 16),
              _buildExtendedTextInput(),
              Offstage(
                offstage: !emojiShowing,
                child: SizedBox(
                    height: 250,
                    child: EmojiPicker(
                      textEditingController: _storyController,
                      onBackspacePressed: _onBackspacePressed,
                      config: Config(
                        columns: 7,
                        // Issue: https://github.com/flutter/flutter/issues/28894
                        emojiSizeMax: 32 *
                            (foundation.defaultTargetPlatform ==
                                    TargetPlatform.iOS
                                ? 1.30
                                : 1.0),
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        gridPadding: EdgeInsets.zero,
                        initCategory: Category.RECENT,
                        bgColor: const Color(0xFFF2F2F2),
                        indicatorColor: Colors.blue,
                        iconColor: Colors.grey,
                        iconColorSelected: Colors.blue,
                        backspaceColor: Colors.blue,
                        skinToneDialogBgColor: Colors.white,
                        skinToneIndicatorColor: Colors.grey,
                        enableSkinTones: true,
                        recentTabBehavior: RecentTabBehavior.RECENT,
                        recentsLimit: 28,
                        replaceEmojiOnLimitExceed: false,
                        noRecents: const Text(
                          'No Recent',
                          style: TextStyle(fontSize: 20, color: Colors.black26),
                          textAlign: TextAlign.center,
                        ),
                        loadingIndicator: const SizedBox.shrink(),
                        tabIndicatorAnimDuration: kTabScrollDuration,
                        categoryIcons: const CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL,
                        checkPlatformCompatibility: true,
                      ),
                    )),
              ),
              const SizedBox(height: 16),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleInput() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Title required!";
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: _titleController,
      decoration: const InputDecoration(
        hintText: 'Story Title',
        disabledBorder: InputBorder.none,
      ),
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  _onBackspacePressed() {
    _storyController
      ..text = _storyController.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _storyController.text.length));
  }

  Widget _buildExtendedTextInput() {
    final lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? true
            : false;
    return Container(
      decoration: BoxDecoration(
        color: lightMode
            ? AppColors.surface
            : DarkAppColors.surface, // Adjust the background color as needed
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Content required!";
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              controller: _storyController,
              decoration: const InputDecoration(
                hintText: 'Write your story...',
                border: InputBorder.none,
              ),
            ),
          ),
          Positioned(
              bottom: 8,
              right: 8,
              child: Row(children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      emojiShowing = !emojiShowing;
                    });
                  },
                  icon: const Icon(Icons.emoji_emotions),
                ),
                // IconButton(
                //   onPressed: () async {
                //     final List<File>? images = await pickMultipleImages();
                //     setState(() {
                //       _images = images;
                //     });
                //   },
                //   icon: const Icon(Icons.add_a_photo_outlined),
                // ),
              ])),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            // Handle the cancel action
            Navigator.pop(context);
          },
          child: const Icon(Icons.cancel),
        ),
        const SizedBox(
          width: 20,
        ),
        TextButton(
          onPressed: _createAndShareStory,
          child: const Icon(
            CupertinoIcons.share,
            color: Colors.greenAccent,
          ),
        ),
      ],
    );
  }

  void _createAndShareStory() async {
    if (_formKey.currentState!.validate()) {
      final user = await Backendless.userService.getCurrentUser();
      final name = user!.getProperty('name');
      List<String> uploadedImageUrls = await _uploadMultipleImages();
      if (_multiImageController.images.isEmpty) {
        try {
          await Backendless.data.of("Stories").save({
            "title": _titleController.text,
            "content": _storyController.text,
            "images": jsonEncode([]),
            "alias_name": name,
          });
          CustomToasts.showInfoToast("Story created");
          _storyController.clear();
          _titleController.clear();
          Navigator.pushNamed(context, "stories");
        } catch (e) {
          debugPrint(e.toString());
        }
      } else {
        try {
          // Create and send the post to Backendless Table
          await Backendless.data.of("Stories").save({
            "title": _titleController.text,
            "content": _storyController.text,
            "images": jsonEncode(uploadedImageUrls),
            "alias_name": name,
          });
          CustomToasts.showInfoToast("Story created");
          _multiImageController.clearImages();
          _multiImageController.dispose();
          _titleController.clear();
          _storyController.clear();
          Navigator.pushNamed(context, "stories");
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }
  }

  Future<List<String>> _uploadMultipleImages() async {
    final images = _multiImageController.images;
    List<String> uploadedImageUrls = [];
    var i = 0;
    for (var image in images) {
      try {
        // Assuming ImageFile has a readAsBytes method
        final file = File(image.path!);
        final path = file.path;
        // final String originalExtension = path.split('.').last;
        final newFileName =
            "${_titleController.text.replaceAll(' ', '_').toLowerCase()}-$i";
        final newFilePath = path.replaceAll(RegExp(r'[^\/]+$'), newFileName);
        final renamedFile = File(newFilePath);

        file.copySync(newFilePath);
        // Upload the File to Backendless
        final String? imageUrl =
            await Backendless.files.upload(renamedFile, "stories_covers");

        uploadedImageUrls.add(imageUrl ?? '');
        i++;
      } catch (e) {
        debugPrint("Error uploading image: $e");
      }
    }

    return uploadedImageUrls;
  }
}
