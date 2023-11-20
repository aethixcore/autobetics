// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:autobetics/apis/api.dart';
import 'package:autobetics/utils/get_greetings.dart';
import 'package:flutter/material.dart';

final blApi = BackendlessAPI();
class Greeting extends StatefulWidget {
  final bool isNewUser;

  Greeting({
    super.key,
    this.isNewUser = false,
  });

  @override
  State<Greeting> createState() => _GreetingState();
}
class _GreetingState extends State<Greeting> {
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  _getUsername() async {
    final result = await blApi.getCurrentUserDetails(context);
    result.fold((error) {}, (response) async {
      final username = response.getProperty("name");
      if (mounted) {
        setState(() {
          _userName = username;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getGreeting(widget.isNewUser),
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _userName,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
