import 'package:flutter/material.dart';
import 'dart:math';
//
import 'screens/category_meals_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/meal_details_screen.dart';
import 'screens/filters_screen.dart';
import 'models/meal.dart';
import 'dummy_data.dart';

void main() {
  runApp(const MyApp());
}

class Palette {
  static const Color primary = Color(0xff0DB3E7);
  static const Color secondary = Color(0xff003639);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = dummyMeals;
  final List<Meal> _favoriteMeals = [];

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex > -1) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(dummyMeals.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = dummyMeals.where((meal) {
        if (_filters['gluten'] != null &&
            (_filters['gluten'] as bool) &&
            !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] != null &&
            (_filters['lactose'] as bool) &&
            !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] != null &&
            (_filters['vegan'] as bool) &&
            !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] != null &&
            (_filters['vegetarian'] as bool) &&
            !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
        shadeValue(color.red, factor),
        shadeValue(color.green, factor),
        shadeValue(color.blue, factor),
        1,
      );

  //app starts here
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            foregroundColor: Colors.white,
            titleTextStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        fontFamily: 'Nunito',
        canvasColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(
                primarySwatch: generateMaterialColor(Palette.primary))
            .copyWith(
          secondary: generateMaterialColor(Palette.secondary),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(favorites: _favoriteMeals),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(
              availableMeals: _availableMeals,
            ),
        MealDetailsScreen.routeName: (context) => MealDetailsScreen(
              toggleFavorite: _toggleFavorite,
              isFavorite: _isMealFavorite,
            ),
        FiltersScreen.routeName: (context) => FiltersScreen(
              saveFilters: _setFilters,
              currentFilters: _filters,
            ),
      },
    );
  }
}
