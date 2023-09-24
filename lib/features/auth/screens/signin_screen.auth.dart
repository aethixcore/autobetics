
import 'dart:ui' as ui;
import 'package:autobetics/utils/app_colors.dart';
import 'package:autobetics/features/auth/widgets/login_form.dart';
import 'package:autobetics/features/auth/widgets/signwith_google.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const title = "Sign up";
    return Scaffold(
        body: SafeArea(
            top: false,
            maintainBottomViewPadding: true,
            child: Stack(
              children: <Widget>[
                Image.asset("assets/bg_image.jpg",
                    fit: BoxFit.cover,
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    colorBlendMode: BlendMode.hardLight,
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.light
                        ? AppColors.background.withOpacity(0.45)
                        : DarkAppColors.background.withOpacity(0.45)),
                BackdropFilter(
                  filter: ui.ImageFilter.blur(
                      sigmaX: 5, sigmaY: 5), // Adjust blur intensity
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 70),
                        child: Text(title.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 32, letterSpacing: 2.3)),
                      ),
                      SizedBox(
                        height: 200,
                        child: FractionallySizedBox(
                            widthFactor: 0.75,
                            child: Image.asset(
                              "assets/autobetics.png",
                              fit: BoxFit.contain,
                            )),
                      ),
                      LoginForm(),
                      const SignWithGoogle()
                      /*  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(7),
                            child: RoundedIconButton(
                                icon: IconButton(
                              icon: Logo(Logos.google),
                              onPressed: () {},
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(7),
                            child: RoundedIconButton(
                                icon: IconButton(
                              icon: Logo(Logos.facebook_f),
                              onPressed: () {},
                            )),
                          )
                        ],
                      ), */
                    ],
                  ),
                ),
              ],
            )));
  }
}
