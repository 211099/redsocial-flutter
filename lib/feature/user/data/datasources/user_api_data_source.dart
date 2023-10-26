import 'dart:convert';

import 'package:actividad1c2/feature/user/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../presentation/pages/login.dart';
import '../../presentation/pages/new_password.dart';





abstract class UserApiDataSource {
  Future<void> registerUser(User user);
  Future<void> logIn({required String email, required String password});
  Future<void> deleteUser(String uuid);
  Future<void> updateUser({
    required String uuid,
    required String name,
    required String lastName,
    required String phoneNumber,
    required String email,
  });
  Future<User> getUser(String uuid);
  Future<List<User>> listUsers();
}

class UserApiDataSourceImp implements UserApiDataSource {
  final BuildContext context;

  UserApiDataSourceImp({required this.context});

  @override
  Future<void> deleteUser(String uuid) async {
    var url = Uri.parse('http://localhost:3001/api/v1/user/$uuid');
    var request = http.Request('DELETE', url);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print('User successfully deleted.');
      } else {
        // print(response.reasonPhrase);
        throw Exception(
            'Failed to delete user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // print(e.toString());
      throw Exception('Failed to delete user due to a network error');
    }
  }

  @override
  Future<User> getUser(String uuid) async {
    var url = Uri.parse('http://localhost:3001/api/v1/user/$uuid');
    var request = http.Request('GET', url);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // Si la llamada fue exitosa, parseamos la respuesta.
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> data = jsonDecode(responseBody);

        // Creamos un objeto UserMolde a partir de los datos JSON.
        User user = UserModel.fromJson(data);
        return user;
      } else {
        // Si la llamada no fue exitosa, lanzamos un error.
        // print(response.reasonPhrase);
        throw Exception(
            'Failed to load user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar cualquier error que ocurra durante la llamada de red.
      // print(e.toString());
      throw Exception('Failed to load user due to a network error');
    }
  }

  @override
  Future<List<User>> listUsers() async {
    var request =
        http.Request('GET', Uri.parse('http://localhost:3001/api/v1/user/all'));

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // Si la llamada fue exitosa, parseamos la respuesta y convertimos cada elemento a un objeto 'User'.
        String responseBody = await response.stream.bytesToString();
        List<dynamic> data = jsonDecode(responseBody);

        // Aquí utilizamos el método 'fromJson' que definiste en tu clase 'UserMolde'.
        List<User> users =
            data.map((item) => UserModel.fromJson(item)).toList();
        return users;
      } else {
        // Si la llamada no fue exitosa, lanzamos un error.
        // print(response.reasonPhrase);
        throw Exception(
            'Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar cualquier error que ocurra durante la llamada de red.
      // print(e.toString());
      throw Exception('Failed to load users due to a network error');
    }
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse('https://actual-servant-production.up.railway.app/api/v1/user/login');

      var data = jsonEncode({
        "email": email,
        "password": password,
      });

      print("email   " + email);
      print('Entrando al método de inicio de sesión...');

      var response = await http.post(
        url,
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseBody = response.body;
        print('Cuerpo de la respuesta: $responseBody');

        Map<String, dynamic> responseData = jsonDecode(responseBody);

        if (responseData.containsKey("token")) {
          String token = responseData["token"];
          print('Token de acceso: $token');
          Navigator.pushReplacementNamed(context, '/new_password');


          print("entre");

          // Guardar el token en SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);

          // Redirigir a otra página (por ejemplo, la página de inicio)

        } else {
          print('La respuesta no contiene un token.');
        }

      } else {
        throw Exception('Failed to log in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al iniciar sesión: $e');
      throw Exception('Failed to log in due to a network error');
    }
  }


  Future<void> registerUser(User user) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var request = http.Request(
        'POST',
        Uri.parse('https://actual-servant-production.up.railway.app/api/v1/user/register'));

    request.body = json.encode({
      "name": user.name,
      "last_name": user.lastName,
      "phone_number": user.phoneNumber,
      "email": user.email,
      "nick_name": user.nickName,
      "password": user.password,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
        // Redirigir al usuario a la pantalla de inicio de sesión
      } else {
        throw Exception('Failed to log in. Status code: ${response.statusCode}');
      }

    } catch (e) {
      print('Error during network call: $e');
      throw Exception('Failed to register user due to a network error: $e');
    }
  }





  @override
  Future<void> updateUser(
      {required String uuid,
      required String name,
      required String lastName,
      required String phoneNumber,
      required String email}) async {
    var url = Uri.parse('http://localhost:3001/api/v1/user/update');
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      "uuid": uuid,
      "name": name,
      "last_name": lastName,
      "phone_number": phoneNumber,
      "email": email
    });

    var request = http.Request('PUT', url)
      ..headers.addAll(headers)
      ..body = body;

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // Si la llamada fue exitosa, podrías imprimir la respuesta o realizar otras acciones.
        // print('User successfully updated.');
      } else {
        // Si la llamada no fue exitosa, lanza una excepción.
        // print(response.reasonPhrase);
        throw Exception(
            'Failed to update user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar cualquier error que ocurra durante la llamada de red.
      // print(e.toString());
      throw Exception('Failed to update user due to a network error');
    }
  }
}
