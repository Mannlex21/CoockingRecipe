import 'package:cooking_recipe_app/src/components/tab_ingredient_widget.dart';
import 'package:cooking_recipe_app/src/components/tab_preparation_widget.dart';
import 'package:cooking_recipe_app/src/connection/models.dart';
import 'package:cooking_recipe_app/src/connection/server_controller.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  Recipe recipe;
  final ServerController serverController;

  DetailsPage({
    this.recipe,
    this.serverController,
    Key key,
  }) : super(key: key);

  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool favorite;

  @override
  void initState() {
    super.initState();
    loadState();
  }

  void loadState() async {
    final state = await widget.serverController.getIsFavorite(widget.recipe);

    setState(() {
      this.favorite = state;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(widget.recipe.name),
                expandedHeight: 320,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(
                        widget.recipe.photo,
                      ),
                    ),
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(.5),
                  ),
                ),
                pinned: true,
                bottom: TabBar(
                  indicatorWeight: 4,
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      child: Text(
                        "ingredientes",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Preparación",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
                actions: [
                  if (widget.recipe.user.id == widget.serverController.loggedUser.id)
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        final nRecipe = await Navigator.of(context).pushNamed("/edit_recipe", arguments: widget.recipe);
                        setState(() {
                          widget.recipe = nRecipe;
                        });
                      },
                    ),
                  getFavoriteWidget(),
                  IconButton(
                    icon: Icon(
                      Icons.help,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ];
          },
          body: TabBarView(
            children: [
              TabIngredientWidget(
                recipe: widget.recipe,
              ),
              TabPreparationWidget(
                recipe: widget.recipe,
              ),
            ],
          ),
        ),
        length: 2,
      ),
    );
  }

  Widget getFavoriteWidget() {
    if (favorite != null) {
      if (favorite) {
        return IconButton(
          icon: Icon(Icons.favorite, color: Colors.red),
          onPressed: () {
            widget.serverController.deleteFavorite(widget.recipe);

            setState(() {
              favorite = false;
            });
          },
        );
      } else {
        return IconButton(
          icon: Icon(Icons.favorite, color: Colors.white),
          onPressed: () {
            widget.serverController.addFavorite(widget.recipe);

            setState(() {
              favorite = true;
            });
          },
        );
      }
    } else {
      return Container(
        margin: EdgeInsets.all(15),
        width: 25,
        child: CircularProgressIndicator(),
      );
    }
  }
}
