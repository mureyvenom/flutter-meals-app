import 'package:flutter/material.dart';
//
import 'favorites_screen.dart';
import 'categories_screen.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favorites;
  const TabsScreen({Key? key, required this.favorites}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Widget> _pages;

  final List _pageTitles = const [
    'Categories',
    'Favorites',
  ];

  @override
  initState() {
    _pages = [
      const CategoriesScreen(),
      FavoritesScreen(meals: widget.favorites),
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_selectedPageIndex]),
      ),
      drawer: const MainDrawer(),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedPageIndex,
        enableFeedback: true,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
