import 'dart:convert';

import 'package:actividad1c2/feature/user/data/user_model.dart';

import '../domain/user.dart';
import 'package:http/http.dart' as http;

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
        User user = UserMolde.fromJson(data);
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
            data.map((item) => UserMolde.fromJson(item)).toList();
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

  @override
  Future<void> logIn({required String email, required String password}) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var request = http.Request(
        'POST', Uri.parse('http://localhost:3001/api/v1/user/login'));

    // Aquí estamos tomando el email y la contraseña proporcionados y colocándolos en el cuerpo de la solicitud.
    request.body = json.encode({
      "email": email,
      "password": password,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        //desde qui almacenar el token
        // print(await response.stream.bytesToString());
      } else {
        // print(response.reasonPhrase);
        throw Exception(
            'Failed to log in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar cualquier error que ocurra durante la llamada de red.
      // print(e.toString());
      throw Exception('Failed to log in due to a network error');
    }
  }

  @override
  Future<void> registerUser(User user) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var request = http.Request(
        'POST', Uri.parse('http://localhost:3001/api/v1/user/register'));
    // Aquí estamos tomando la información del usuario proporcionado y colocándola en el cuerpo de la solicitud.
    request.body = json.encode({
      "name": user.name,
      "last_name": user.lastName,
      "phone_number": user.phoneNumber,
      "email": user.email,
      "password": user.password,
    });
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // Si la llamada fue exitosa, puedes manejar la respuesta aquí, por ejemplo, convertirlo en un objeto o almacenar información.
        // print(await response.stream.bytesToString());
      } else {
        // Si la llamada no fue exitosa, lanzar un error. Podrías manejar esto de manera diferente, dependiendo de tus necesidades de manejo de errores.
        // print(response.reasonPhrase);
        throw Exception(
            'Failed to register user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar cualquier error que ocurra durante la llamada de red.
      // print(e.toString());
      throw Exception('Failed to register user due to a network error');
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
