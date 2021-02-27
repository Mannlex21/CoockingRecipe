import 'package:cooking_recipe_app/src/components/recipe_widget.dart';
import 'package:cooking_recipe_app/src/connection/models.dart';
import 'package:cooking_recipe_app/src/connection/server_controller.dart';
import 'package:flutter/material.dart';

class MyFavoritePage extends StatefulWidget {
  final ServerController serverController;
  MyFavoritePage(this.serverController, {Key key}) : super(key: key);

  @override
  _MyFavoritePageState createState() => _MyFavoritePageState();
}

class _MyFavoritePageState extends State<MyFavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis recetas favoritas'),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: widget.serverController.getFavoritesList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final list = snapshot.data;
            if (list.length == 0) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    Text(
                      "No hay favoritos",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  Recipe recipe = list[index];

                  return RecipeWidget(
                    recipe: recipe,
                    serverController: widget.serverController,
                    onChange: () {
                      setState(() {});
                    },
                  );
                },
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
