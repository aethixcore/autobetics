import 'package:flutter/material.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Exercise Categories',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CategoryList(), // Display a list of exercise categories.
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: const <Widget>[
          CategoryItem(
            title: 'Cardiovascular',
            exercises: [
              ExerciseItem(
                title: 'Running',
                description: 'Run for at least 30 minutes daily.',
                imageUrl: 'https://picsum.photos/200',
              ),
              ExerciseItem(
                title: 'Cycling',
                description: 'Cycling is great for cardiovascular health.',
                imageUrl: 'https://picsum.photos/200',
              ),
              // Add more exercise items for this category.
            ],
          ),
          CategoryItem(
            title: 'Strength Training',
            exercises: [
              ExerciseItem(
                title: 'Push-Ups',
                description: 'Do 3 sets of 10 push-ups each day.',
                imageUrl: 'https://picsum.photos/200',
              ),
              ExerciseItem(
                title: 'Squats',
                description: 'Squats help build leg muscles.',
                imageUrl: 'https://picsum.photos/200',
              ),
              // Add more exercise items for this category.
            ],
          ),
          // Add more exercise categories here.
        ],
      ),
    );
  }
}

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
    return ListTile(
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
      title: Text(title),
      subtitle: Text(description),
      onTap: () {
        // Implement navigation to a detailed exercise screen.
        // You can show exercise details, videos, and more.
      },
    );
  }
}
