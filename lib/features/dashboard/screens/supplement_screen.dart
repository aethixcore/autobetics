import 'package:flutter/material.dart';

class SupplementScreen extends StatefulWidget {
  const SupplementScreen({super.key});

  @override
  State<SupplementScreen> createState() => _SupplementScreenState();
}

class _SupplementScreenState extends State<SupplementScreen> {
  final TextEditingController _supplementNameController = TextEditingController();

  void _showAddSupplementModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Add New Supplement',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _supplementNameController,
                  decoration: const InputDecoration(
                    labelText: 'Supplement Name',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement logic to add the supplement based on the input.
                    String supplementName = _supplementNameController.text;
                    if (supplementName.isNotEmpty) {
                      // Add your logic to handle adding the supplement here.
                      Navigator.pop(context); // Close the modal.
                    }
                  },
                  child: const Text('Add Supplement'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Your Supplements:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                isExtended: true,
                onPressed: () {
                  // Implement adding new supplements functionality.
                  _showAddSupplementModal(context);
                },
                child: const Icon(Icons.add),
              ),
              const SupplementItem(
                name: 'Vitamin C',
                dosage: '1000mg',
                frequency: 'Once daily',
              ),
              const SupplementItem(
                name: 'Fish Oil',
                dosage: '500mg',
                frequency: 'Twice daily',
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: const <Widget>[
                    RecommendedSupplementItem(
                      name: 'Vitamin D',
                      description: 'Supports bone health and immunity.',
                      imageUrl: 'https:/picsum.photos/200',
                    ),
                    RecommendedSupplementItem(
                      name: 'Omega-3 Fatty Acids',
                      description: 'Promotes heart and brain health.',
                      imageUrl: 'https:/picsum.photos/200',
                    ),
                    RecommendedSupplementItem(
                      name: 'Probiotics',
                      description: 'Improves gut health and digestion.',
                      imageUrl: 'https:/picsum.photos/200',
                    ),
                    // Add more RecommendedSupplementItem widgets for additional supplements.
                  ],
                ),
              ),
            ],
          ),
        ),
        extendBody: false,
      ),
    );
  }
}

class RecommendedSupplementItem extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;

  const RecommendedSupplementItem({super.key, 
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  NetworkImage(imageUrl), // Recommended supplement image URL.
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            // Implement functionality to add recommended supplement to user's list.
          },
        ),
      ),
    );
  }
}

class SupplementItem extends StatelessWidget {
  final String name;
  final String dosage;
  final String frequency;

  const SupplementItem({
    super.key,
    required this.name,
    required this.dosage,
    required this.frequency,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Dosage: $dosage'),
            Text('Frequency: $frequency'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            // Implement delete functionality for this supplement.
          },
        ),
      ),
    );
  }
}
