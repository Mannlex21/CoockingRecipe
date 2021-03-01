import 'package:cooking_recipe_app/src/connection/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabPreparationWidget extends StatelessWidget {
  final Recipe recipe;
  const TabPreparationWidget({this.recipe, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      children: [
        Text(
          recipe.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          recipe.description,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Preparación:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          children: List.generate(
            recipe.steps.length,
            (int index) {
              final step = recipe.steps[index];

              return ListTile(
                leading: Text(
                  "${index + 1}",
                  style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                title: Text(step),
              );
            },
          ),
        ),
      ],
    );
  }
}
