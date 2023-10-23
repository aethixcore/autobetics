import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DietScreen extends StatefulWidget {
  const DietScreen({Key? key});

  @override
  State<DietScreen> createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  List meals = [];
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final uri = Uri.parse(
          'https://edamam-recipe-search.p.rapidapi.com/api/recipes/v2?type=public&health=low-sugar&imageSize=THUMBNAIL');
      final response = await http.get(uri, headers: {
        'Accept-Language': 'en',
        'X-RapidAPI-Key': 'c337e8dbeamsh49b435102af33bdp1ccc5bjsnd6343c93d5ad',
        'X-RapidAPI-Host': 'edamam-recipe-search.p.rapidapi.com'
      });
      if (response.statusCode == 200) {
        setState(() {
          final parseData = json.decode(response.body);
          meals = parseData["hits"];
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load data. Please try again later.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'An error occurred. Please check your internet connection.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recommended Diet Plans:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else if (error.isNotEmpty)
                Center(
                  child: Text(error),
                )
              else
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: ScrollController(),
                    itemCount: meals.length,
                    itemBuilder: (context, index) {
                      final meal = meals[index]["recipe"];
                      final List ingredients = meal["ingredients"];
                      return DietPlanItem(
                        title: meal["label"],
                        description:
                            '',
                        imageUrl: meal["image"],
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class DietPlanItem extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const DietPlanItem({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(description),
            const SizedBox(height: 8.0),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
