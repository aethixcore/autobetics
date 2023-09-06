import 'package:autobetics/models/auth_model.dart';
import 'package:autobetics/providers/auth_sider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider extends StatelessWidget {
  const AuthProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthData(), child: const AuthSlider());
  }
}
