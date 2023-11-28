import 'dart:io';

import 'package:autobetics/features/widgets/custom_toast.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:image_picker/image_picker.dart';

export "failure.dart";
export "type_defs.dart";


Future<File?> pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    return File(image.path); // Convert XFile to File
  }
  return null;
}
Future<List<File>?> pickMultipleImages() async {
  final ImagePicker picker = ImagePicker();
  final List<XFile> images = await picker.pickMultiImage();
  if (images.isNotEmpty) {
    final List<File> files = [];
    for (var image in images){
      files.add(File(image.path));
    }
    return files; // Convert XFile to File
  }
  return null;
}

Future<String?> uploadImageToBackendless(File? imageFile) async {
  if (imageFile == null) {
    // Handle the case where no image is selected
    return "";
  }

  final filePath = imageFile.path;
  try {
    final file = File(filePath);
    // Use the Backendless File Service to upload the image
    final response =
    await Backendless.files.upload(file, "avatars", overwrite: true);

    if (response != null) {
      // Image uploaded successfully
      CustomToasts.showInfoToast("Avatar uploaded.");
      return response; // Return the file URL
    } else {
      // Handle the error case
      CustomToasts.showWarningToast("Error uploading image.");
      return "";
    }
  } catch (e) {
    // Handle any exceptions
    CustomToasts.showWarningToast("Error: $e");
    return "";
  }
}
