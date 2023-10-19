import 'dart:ui' as ui;
import 'package:autobetics/common/loaders.dart';
import 'package:autobetics/models/auth_model.dart';
import 'package:autobetics/utils/app_colors.dart';
import 'package:autobetics/features/auth/widgets/register_form.dart';
import 'package:autobetics/features/auth/widgets/signwith_google.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context, listen: true);
    const title = "Sign up";
    return Scaffold(
      body: SafeArea(
          top: false,
          maintainBottomViewPadding: false,
          child: Stack(
            children: <Widget>[
              Image.asset("assets/insulin.jpg",
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
              Opacity(
                alwaysIncludeSemantics: true,
                opacity: authModel.loading ? 0.5 : 1,
                child: AbsorbPointer(
                  absorbing: authModel.loading,
                  child: SingleChildScrollView(
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
                        RegisterationForm(),
                        const SignWithGoogle(),
                        /* Row(
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
                ),
              ),
              if (authModel.loading) const Loader()
            ],
          )),
    );
  }
}
