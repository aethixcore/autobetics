// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously
import 'dart:convert';
import 'package:autobetics/apis/api.dart';
import 'package:autobetics/core/core.dart';
import 'package:autobetics/utils/app_colors.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'dart:io';

final blApi = BackendlessAPI();

final GlobalKey<_ProfileScreenState> profileScreenKey =
    GlobalKey<_ProfileScreenState>();

class ProfileScreen extends StatefulWidget {
  ProfileScreen() : super(key: profileScreenKey);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  BackendlessUser _userDetails = BackendlessUser();
  String? _avatarUrl;
  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  _getUserDetails() async {
    final result = await blApi.getCurrentUserDetails(context);
    result.fold((error) {}, (response) {
      final String avatarUrl = "${dotenv.get('BL_ENDPOINT')}/${dotenv.get('BL_APPID')}/${dotenv.get('BL_RESTFUL_KEY')}/files/avatars/avatar_${response.getUserId()}";

      setState(() {
        _userDetails = response;
        _avatarUrl = avatarUrl;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? true
            : false;

    final List<dynamic> goals = jsonDecode(_userDetails.getProperty("goals"));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                color:
                    Colors.transparent, // Make the background color transparent
                child: Stack(
                  alignment: Alignment
                      .bottomRight, // Align the upload icon to the bottom right
                  children: [
                 CircleAvatar(radius: 70,backgroundImage: NetworkImage(_avatarUrl??'https://picsum.photos/200'),),
                    IconButton(
                      icon: const Icon(Icons.add_a_photo_rounded, color: Colors.blueGrey,weight: 10, size: 32,fill: 0.6,),
                      onPressed: () async {
                        final selectedImage = await pickImage();
                        if (selectedImage != null) {
                          final path = selectedImage.path;
                          final String originalExtension = path.split('.').last;
                          final userId = _userDetails.getUserId();
                          final newFileName =
                              "avatar_$userId";
                          final newFilePath =
                              path.replaceAll(RegExp(r'[^\/]+$'), newFileName);
                          final renamedFile = File(newFilePath);

                          selectedImage.copySync(newFilePath);

                          if (mounted) {
                            await uploadImageToBackendless(renamedFile);
                           Navigator.pushReplacementNamed(context, '/profile');
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
              Text(
                _userDetails.getProperty("name") ?? "N/A",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Text(
                _userDetails.email ?? "N/A",
                style:
                    const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
              Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Card(
                        color: lightMode
                            ? AppColors.surface
                            : DarkAppColors.surface,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            // Rounded top left corner
                            Radius.circular(20), // Rounded top right corner
                          ),
                        ),
                        child: Column(children: [
                          const SizedBox(
                            height: 40,
                          ),
                          ExpansionTile(
                            shape: Border.all(width: 0),
                            subtitle: const Text(
                                "Journey to a healthier you, one metric at a time. 💪"),
                            title: const Text("Health Metrics",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            children: [
                              ListTile(
                                title: const Text("Body Mass Index"),
                                subtitle:
                                    Text("${_userDetails.getProperty('bmi')}"),
                              ),
                              ListTile(
                                title: const Text("Systolic Pressure"),
                                subtitle: Text(
                                    "${_userDetails.getProperty('sbp')} mmHg"),
                              ),
                              ListTile(
                                title: const Text("Diastolic Pressure"),
                                subtitle: Text(
                                    "${_userDetails.getProperty('dbp')} mmHg"),
                              ),
                            ],
                          ),
                        ]),
                      ),
                      Card(
                        color: lightMode
                            ? AppColors.surface
                            : DarkAppColors.surface,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ExpansionTile(
                            shape: Border.all(width: 0),
                            subtitle: const Text("Preview goals"),
                            title: const Text("Goals",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            children: [
                              for (var goal in goals)
                                ListTile(
                                  title: Text(goal),
                                  // Add more ListTile customization as needed
                                ),
                            ],
                          )
                        ]),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      Card(
                        color: lightMode
                            ? AppColors.onSurface
                            : DarkAppColors.accent,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListTile(
                          textColor: AppColors.onPrimary,
                          title: const Text(
                            'DOB',
                          ),
                          subtitle: Text(DateFormat.yMEd().format(
                              DateTime.parse(_userDetails.getProperty("dob")))),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
