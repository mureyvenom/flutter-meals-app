import 'package:flutter/material.dart';
//
import '../dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const String routeName = '/meal-details';
  final Function toggleFavorite;
  final Function isFavorite;
  const MealDetailsScreen(
      {Key? key, required this.toggleFavorite, required this.isFavorite})
      : super(key: key);

  Widget buildSectionTitle(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget buildCustomList(BuildContext context, List list) {
    return Column(
      children: list.map((listItem) {
        return SizedBox(
          width: double.infinity,
          child: Card(
            color: Theme.of(context).colorScheme.secondary,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                listItem,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = dummyMeals.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        titleTextStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        title: Text('Meal details for ${selectedMeal.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              buildSectionTitle('Ingredients'),
              buildCustomList(context, selectedMeal.ingredients),
              buildSectionTitle('Steps'),
              buildCustomList(context, selectedMeal.steps)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(mealId) ? Icons.star : Icons.star_border),
        onPressed: () {
          toggleFavorite(mealId);
        },
        elevation: 10,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
