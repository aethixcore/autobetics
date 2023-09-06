import 'package:flutter/material.dart';

class AuthData extends ChangeNotifier {
  TextEditingController userIDController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  FocusNode userIdFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();

  bool firstTime = true;
  String name = '';
  String email = '';
  String userID = '';
  // Add more fields as needed

  void updateName(String newName) {
    name = newName;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  void updateUserID(String userID) {
    userID = userID;
    notifyListeners();
  }
}
