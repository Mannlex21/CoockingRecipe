import 'package:cooking_recipe_app/src/connection/server_controller.dart';
import 'package:cooking_recipe_app/src/screens/add_recipe_page.dart';
import 'package:cooking_recipe_app/src/screens/details_page.dart';
import 'package:cooking_recipe_app/src/screens/home_page.dart';
import 'package:cooking_recipe_app/src/screens/login_page.dart';
import 'package:cooking_recipe_app/src/screens/my_favorite_page.dart';
import 'package:cooking_recipe_app/src/screens/mys_recipes_page.dart';
import 'package:cooking_recipe_app/src/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:cooking_recipe_app/src/connection/models.dart';

ServerController _serverController = ServerController();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // fontFamily: "Oi",
        brightness: Brightness.light,
        primaryColor: Colors.cyan,
        accentColor: Colors.cyan[300],
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: TextTheme(
            headline6: TextStyle(
              // es el titulo del appbar
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ), // Asigna tema de color a los iconos de appBar
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Esta opcion de rutas te da un espacio para poner codigo de la logica de negocio antes de llamar una ruta
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case '/':
              return LoginPage(_serverController, context);
            case '/home':
              User loggedUser = settings.arguments;
              _serverController.loggedUser = loggedUser;
              return HomePage(_serverController);
            case '/favorites':
              User loggedUser = settings.arguments;
              _serverController.loggedUser = loggedUser;
              return MyFavoritePage(_serverController);
            case '/register':
              User loggedUser = settings.arguments;
              return RegisterPage(
                _serverController,
                context,
                userToEdit: loggedUser,
              );
            case "/my_recipes":
              return MyRecipesPage(
                _serverController,
              );
            case '/details':
              Recipe recipe = settings.arguments;
              return DetailsPage(
                recipe: recipe,
                serverController: _serverController,
              );
            case "/add_recipe":
              return AddRecipePage(
                _serverController,
              );
            case "/edit_recipe":
              Recipe recipe = settings.arguments;
              return AddRecipePage(
                _serverController,
                recipe: recipe,
              );
            default:
              return LoginPage(_serverController, context);
          }
        });
      },
      // Esta opcion de rutas te manda directamente a la ruta que llamaste sin customizar nada
      // initialRoute: "/",
      // routes: {
      //   "/": (BuildContext buildContext) => LoginPage(serverController, context),
      // },
    );
  }
}
