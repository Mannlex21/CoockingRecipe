import 'package:cooking_recipe_app/src/connection/server_controller.dart';
import 'package:cooking_recipe_app/src/screens/home_page.dart';
import 'package:cooking_recipe_app/src/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';

ServerController serverController = ServerController();

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
        accentColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Esta opcion de rutas te da un espacio para poner codigo de la logica de negocio antes de llamar una ruta
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case '/':
              return LoginPage(serverController, context);
            case '/home':
              User userLogged = settings.arguments;
              return HomePage(userLogged);
            default:
              return LoginPage(serverController, context);
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
