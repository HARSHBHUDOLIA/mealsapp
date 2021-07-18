import 'package:flutter/material.dart';
import 'package:mealsapp/dummy_data.dart';
import 'package:mealsapp/screens/category_meals_screen.dart';
import 'package:mealsapp/screens/filters_screen.dart';
import 'package:mealsapp/screens/meal_detail_screen.dart';
import 'package:mealsapp/screens/tab_screen.dart';

import 'modals/meals.dart';
import 'screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritesMeals = [];
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavorites(String mealId) {
    final existingIndex =
        _favoritesMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoritesMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritesMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool isMealFavorite(String id) {
    return _favoritesMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(_favoritesMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(toggleFavorites, isMealFavorite),
        FilterScreen.routeName: (context) =>
            FilterScreen(_filters, _setFilters),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },
      onUnknownRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
