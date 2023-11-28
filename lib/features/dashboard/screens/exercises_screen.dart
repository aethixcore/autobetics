import 'dart:math';

import 'package:autobetics/apis/api.dart';
import 'package:autobetics/utils/calculate_age.dart';
import 'package:autobetics/utils/choose_exercise_type.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}
final blApi = BackendlessAPI();
class _ExercisesScreenState extends State<ExercisesScreen> {
  List exercises = []; // This will store the fetched exercise data.
  bool isLoading = true;
  String error = '';
  @override
  void initState() {
    super.initState();
    fetchData();
  }



  Future<void> fetchData() async {
    var ageString;
    final result = await blApi.getCurrentUserDetails(context);
    result.fold((error) {}, (response) {
     ageString = response.getProperty("dob");
    });
    final int age = calculateAge(ageString);
    debugPrint("====age====");
    debugPrint(age.toString());
    try {
      final uri = Uri.parse(
          'https://api.api-ninjas.com/v1/exercises?type=${chooseExerciseType(age, 49)}');
      final response =
          await http.get(uri, headers: {'X-Api-Key': dotenv.get("NINJA_KEY")});
      if (response.statusCode == 200) {
        setState(() {
          exercises = json.decode(response.body);
          isLoading = false;
          });
      } else {
        setState(() {
          error = 'Failed to load data. Please try again later.';
          isLoading = false;
        });
      }
    } catch (e) {  setState(() {
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
          'Exercises',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (isLoading) // Loading State
            const Center(
              child: LinearProgressIndicator(),
            )
          else if (error.isNotEmpty) // Error State
            Center(
              child: Text(error),
            )
          else // Data Fetched
            CategoryList(exercises: exercises),
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({super.key, required this.exercises});
  final List exercises;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: exercises.length, // Use the length of the exercises list
        itemBuilder: (BuildContext context, index) {
          final exercise = exercises[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ExerciseItem(
              title: exercise["name"],
              description: exercise["instructions"],
              imageUrl:
                  'https://picsum.photos/100/${Random().nextInt(exercises.length * 100)}',
            ),
          );
        },
      ),
    );
  }
}

/* 
class CategoryItem extends StatelessWidget {
  final String title;
  final List<ExerciseItem> exercises;

  const CategoryItem({
    super.key,
    required this.title,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              return exercises[index];
            },
          ),
        ],
      ),
    );
  }
}
 */
class ExerciseItem extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const ExerciseItem({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl), // Exercise image URL.
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onTap: () {
            // Implement navigation to a detailed exercise screen.
            // You can show exercise details, videos, and more.
          },
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(description),
        ),
      ],
    );
  }
}
