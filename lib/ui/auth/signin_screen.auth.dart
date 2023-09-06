import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:icons_plus/icons_plus.dart';
import 'package:autobetics/utils/app_colors.dart';
import 'package:autobetics/widgets/rounded_iconbutton.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const title = "Sign in";
    return Scaffold(
        body: SafeArea(
      top: false,
      maintainBottomViewPadding: true,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset("assets/bg_image.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              colorBlendMode: BlendMode.difference,
              color: AppColors.background.withOpacity(0.25)),
          BackdropFilter(
            filter: ui.ImageFilter.blur(
                sigmaX: 3, sigmaY: 3), // Adjust blur intensity
            child: Container(
              color: Colors.transparent,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Text(title.toUpperCase(),
                      style: const TextStyle(
                          color: AppColors.secondary,
                          fontSize: 27,
                          letterSpacing: 2.3)),
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
                const Center(
                  child: SizedBox(
                      height: 50,
                      child: Text(
                        "Signin with",
                        style:
                            TextStyle(color: AppColors.secondary, fontSize: 20),
                      )),
                ),
                Row(
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
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(7, 50, 7, 7),
                  child: TextField(
                    cursorColor: AppColors.onSecondary,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "User_ID",
                      labelStyle: TextStyle(
                          // color: AppColors.onPrimary,
                          fontWeight: FontWeight.bold),
                      hintText: '+2349044322277',
                      hintStyle: TextStyle(color: AppColors.onSecondary),
                      // enabledBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(color: AppColors.onPrimary)),
                      focusColor: AppColors.onSecondary,
                      focusedBorder: OutlineInputBorder(
                        // Set border color here
                        borderSide: BorderSide(
                            color: AppColors
                                .onSecondary), // Specify the desired color
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: const ButtonStyle(
                          overlayColor:
                              MaterialStatePropertyAll(Colors.transparent)),
                      onPressed: () {},
                      child: const Text("Forgotten User_ID?",
                          style: TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(7),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        style: const ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll(AppColors.secondary),
                          backgroundColor:
                              MaterialStatePropertyAll(AppColors.primary),
                        ),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(letterSpacing: 2),
                        ),
                        onPressed: () {},
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
