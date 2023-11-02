// ignore_for_file: library_private_types_in_public_api
import 'package:autobetics/models/app_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context, listen: true);
    print("docs $appModel.dashboardDocs");
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              // Container(
              //   color:
              //       Colors.transparent, // Make the background color transparent
              //   child: Stack(
              //     alignment: Alignment
              //         .bottomRight, // Align the upload icon to the bottom right
              //     children: [
              //       const CircleAvatar(
              //         backgroundColor: Colors.grey,
              //         backgroundImage: NetworkImage('your_avatar_url_here'),
              //         radius: 70, // Adjust the size as needed
              //       ),
              //       IconButton(
              //         icon: const Icon(Icons.camera_alt),
              //         onPressed: () {
                        
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            // Rounded top left corner
                            Radius.circular(20), // Rounded top right corner
                          ),
                        ),
                        child: Column(children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const ListTile(
                            title: Text('Goals & Achievements',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          ExpansionTile(
                            title: const Text("Goals"),
                            children: appModel.dashboardDocs.isNotEmpty
                                ? List<Widget>.generate(
                                    appModel.dashboardDocs["goals"].length,
                                    (index) {
                                    return ListTile(
                                      title: Text(appModel
                                          .dashboardDocs["goals"][index]),
                                    );
                                  })
                                : [],
                          ),
                        ]),
                      ),
                    ],
                  ),
                  const Column(
                    children: [
                      SizedBox(height: 20),
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: ListTile(
                          title: Text('Your Name'),
                          subtitle: Text(''),
                          /*   trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Show a dialog for changing the name
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  _nameController.text =
                                      appModel.userInformation.name;
                                  return AlertDialog(
                                    title: const Text('Edit Your Name'),
                                    content: TextFormField(
                                      controller: _nameController,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          // Update the name in the AppModel
                                          final authAPI =
                                              AuthAPI(account: autobetAccount);
                                          final result =
                                              await authAPI.updateName(
                                            name: _nameController.text,
                                          );
                                          result.fold((error) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(error.message),
                                              ),
                                            );
                                            Navigator.of(context).pop();
                                          }, (account) {
                                            appModel.userInformation = account;
                                            appModel
                                                .setUserInformation(account);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "$account.name updated successfully!"),
                                              ),
                                            );
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Text('Save'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                       */
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

class EditableListItem extends StatefulWidget {
  final String title;

  const EditableListItem({super.key, required this.title});

  @override
  _EditableListItemState createState() => _EditableListItemState();
}

class _EditableListItemState extends State<EditableListItem> {
  String _editedTitle = '';

  @override
  void initState() {
    super.initState();
    _editedTitle = widget.title;
  }

  void _openEditDialog() async {
    final editedTitle = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Item'),
          content: TextFormField(
            initialValue: _editedTitle,
            autofocus: true,
            onChanged: (value) {
              _editedTitle = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(_editedTitle);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (editedTitle != null) {
      setState(() {
        _editedTitle = editedTitle;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_editedTitle),
      // trailing: IconButton(
      //   icon: const Icon(Icons.edit),
      //   onPressed: _openEditDialog,
      // ),
    );
  }
}
