import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  // late String errMsg;

  bool loading = false;
  void updateLoading(bool loading) {
    notifyListeners();
    loading = loading;
  }

  void reset() {
    loading = false;
    passwordController.text = "";
    confirmPasswordController.text = "";
    emailController.text = "";
    nameController.text = "";
    notifyListeners();
  }
}
