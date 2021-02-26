import 'package:flutter/material.dart';
import 'package:cooking_recipe_app/src/connection/models.dart';

class HomePage extends StatefulWidget {
  final User loggedUser;
  HomePage(this.loggedUser, {Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(),
      drawer: Drawer(),
    );
  }
}
