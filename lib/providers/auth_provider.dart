import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:autobetics/models/auth_model.dart';
import 'package:autobetics/features/auth/screens/auth_screen.dart';

class AuthProvider extends StatelessWidget {
  const AuthProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthModel(), child: const AuthScreen());
  }
}
