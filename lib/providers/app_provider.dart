import 'package:autobetics/models/app_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autobetics/ui/dasboard/dashboard.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppData(), child: DashboardScreen());
  }
}
