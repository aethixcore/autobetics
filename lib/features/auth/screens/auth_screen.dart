import 'package:autobetics/features/auth/screens/signup_screen.auth.dart';
import 'package:autobetics/features/auth/screens/signin_screen.auth.dart';
import 'package:autobetics/models/app_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    List<Widget> authPages = const [RegisterScreen(), LoginScreen()];
    return PageView.builder(
      itemBuilder: (BuildContext context, index) {
        return authPages[index];
      },
      pageSnapping: true,
      itemCount: authPages.length,
      controller: PageController(
          initialPage: appModel.firstTime ? 0 : 1, keepPage: false),
    );
  }
}
