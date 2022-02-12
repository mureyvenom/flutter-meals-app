import 'package:flutter/material.dart';
//
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = '/favorites';
  final List<Meal> meals;
  const FavoritesScreen({Key? key, required this.meals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: meals.isEmpty
            ? const Text('No Favorites Yet')
            : ListView.builder(
                itemBuilder: (context, index) {
                  return MealItem(
                    id: meals[index].id,
                    title: meals[index].title,
                    imageUrl: meals[index].imageUrl,
                    duration: meals[index].duration,
                    complexity: meals[index].complexity,
                    affordability: meals[index].affordability,
                  );
                },
                itemCount: meals.length,
              ),
      ),
    );
  }
}
