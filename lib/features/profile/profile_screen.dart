import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              // First Section (Avatar and Bio Data)
              Container(
                color:
                    Colors.transparent, // Make the background color transparent
                child: Stack(
                  alignment: Alignment
                      .bottomRight, // Align the upload icon to the bottom right
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage('your_avatar_url_here'),
                      radius: 70, // Adjust the size as needed
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt),
                      onPressed: () {
                        // Add your logic to handle image upload here
                      },
                    ),
                  ],
                ),
              ),

              Stack(
                children: [
                  // Second Section (Goals, Achievements, Badges)
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        // Rounded top left corner
                        Radius.circular(20), // Rounded top right corner
                      ),
                    ),
                    child: Column(
                      children: [
                        const ListTile(
                          title: Text('Goals & Achievements',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        ExpansionTile(
                          // Collapsible section for Goals
                          title: const Text('Goals'),
                          children: [
                            EditableListItem(
                              title: 'Goal 1: Description of Goal 1',
                            ),
                            // Add more goals as needed
                          ],
                        ),
                        ExpansionTile(
                          // Collapsible section for Achievements
                          title: const Text('Achievements'),
                          children: [
                            EditableListItem(
                              title:
                                  'Achievement 1: Description of Achievement 1',
                            ),
                            // Add more achievements as needed
                          ],
                        ),
                        // Add more collapsible sections as needed
                      ],
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      title: const Text('Your Name'),
                      subtitle: const Text('Age: XX | Gender: XX'),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Implement edit bio data logic here
                        },
                      ),
                    ),
                  ),
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

  EditableListItem({super.key, required this.title});

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
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: _openEditDialog,
      ),
    );
  }
}
