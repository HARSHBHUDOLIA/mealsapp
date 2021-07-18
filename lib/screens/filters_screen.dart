import 'package:flutter/material.dart';
import 'package:mealsapp/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FilterScreen(this.currentFilters, this.saveFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool glutenFree = false;
  bool vegetarian = false;
  bool vegan = false;
  bool lactoseFree = false;

  @override
  void initState() {
    glutenFree = widget.currentFilters['gluten'];
    vegetarian = widget.currentFilters['vegetarian'];
    vegan = widget.currentFilters['vegan'];
    lactoseFree = widget.currentFilters['lactose'];
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters'),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilter = {
                  'gluten': glutenFree,
                  'lactose': lactoseFree,
                  'vegan': vegan,
                  'vegetarian': vegetarian,
                };
                widget.saveFilters(selectedFilter);
              },
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust Your Filters',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchListTile(
                    'Gluten-Free',
                    'Only Gluten-Free',
                    glutenFree,
                    (newValue) {
                      setState(
                        () {
                          glutenFree = newValue;
                        },
                      );
                    },
                  ),
                  _buildSwitchListTile(
                    'Vegetarian',
                    'Only Vegetarian',
                    vegetarian,
                    (newValue) {
                      setState(
                        () {
                          vegetarian = newValue;
                        },
                      );
                    },
                  ),
                  _buildSwitchListTile(
                    ' vegan',
                    'Only  vegan',
                    vegan,
                    (newValue) {
                      setState(
                        () {
                          vegan = newValue;
                        },
                      );
                    },
                  ),
                  _buildSwitchListTile(
                    'lactoseFree',
                    'Only lactoseFree',
                    lactoseFree,
                    (newValue) {
                      setState(
                        () {
                          lactoseFree = newValue;
                        },
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ));
  }
}
