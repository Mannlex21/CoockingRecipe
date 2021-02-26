import 'package:flutter/material.dart';
import 'package:cooking_recipe_app/src/connection/modulo1_fake_backend.dart' as server;
import 'package:cooking_recipe_app/src/connection/models.dart';

class ServerController {
  void init(BuildContext context) {
    server.generateData(context);
  }

  Future<User> login(String userName, String password) async {
    return await server.backendLogin(userName, password);
  }

  Future<bool> addUser(User user) async {
    return await server.addUser(user);
  }
}
