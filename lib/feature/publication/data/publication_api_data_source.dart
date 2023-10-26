import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:actividad1c2/feature/publication/data/publication_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/publication.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


abstract class PublicationApiDataSource {
  Future<List<Publication>> listPublication();
  Future<Publication> getPublicationByUuid(String uuid);
  Future<Publication> getPublicationByUser(String name);
  Future<void> createPublication(
      String idUser, String description, dynamic urlFile);
  Future<void> updateDescription(String uuid, String description);
  Future<void> deletePublication(String uuid);
}

class PublicationApiDataSourceImp implements PublicationApiDataSource {
  late final BuildContext context;

  PublicationApiDataSourceImp({required this.context});
  @override
  Future<void> createPublication(
      String idUser, String description, dynamic urlFile) async {
         String? token; // Variable para almacenar el token recuperado
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token');
       if (token == null) {
        throw Exception('No token found! Unable to send the request.');
      }
      var headers = {
        'Authorization': 'Bearer $token'
      };

      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://actual-servant-production.up.railway.app/api/v1/public/create'));

        request.fields.addAll({
      'idUser': idUser,
      'description': description,
      'url_file': urlFile != null ? urlFile : "", // Utiliza urlFile si no es nulo, de lo contrario, usa una cadena vacía
    });

    if (urlFile != null) {
      request.files.add(await http.MultipartFile.fromPath('url_file', urlFile));
    }

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        
        print(await response.stream.bytesToString());
        
      } else {
        Navigator.pushReplacementNamed(context, '/Home');
        print(response.reasonPhrase);
      }
    } catch (e) {
      // Manejar la excepción adecuadamente
      print(e);
    }
  }

  @override
Future<void> deletePublication(String uuid) async {
    // Recupera las SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Intenta obtener el token del almacenamiento local
    String? token = prefs.getString('token');

    // Si el token es null, debemos lanzar un error
    if (token == null) {
      throw Exception('Token is null. Please re-login or obtain a new token.');
    }

    // Prepara los encabezados de la solicitud con el token
    var headers = {
      'Authorization': 'Bearer $token', // usa el token real desde SharedPreferences
    };

    var url = Uri.parse('https://actual-servant-production.up.railway.app/api/v1/public/delete/$uuid'); 

    try {
      var response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        print('Publicación eliminada con éxito. Respuesta: ${response.body}');
      } else {
        print('Error al eliminar la publicación. Estado: ${response.statusCode}. Razón: ${response.reasonPhrase}');
        // Aquí puedes lanzar una excepción o manejar este estado de error como prefieras
      }
    } catch (e) {
      print('Ocurrió un error al enviar la solicitud: $e');
      // Aquí también puedes lanzar la excepción para manejarla en una capa superior
      throw Exception('Error deleting publication: $e');
    }
  }
  @override
  Future<Publication> getPublicationByUser(String name) async {
    //no se usa
    // Construir el URI usando el nombre proporcionado
    var uri = Uri.parse('http://localhost:3001/api/v1/public/user/$name');

    // Crear la solicitud GET
    var request = http.Request('GET', uri);

    try {
      // Enviar la solicitud y esperar una respuesta
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // Si la respuesta fue exitosa, decodificar el cuerpo de la respuesta
        String responseBody = await response.stream.bytesToString();
        var responseData = json.decode(responseBody);

        // Aquí deberías mapear los datos de la respuesta a tu objeto 'Publication'.
        // Esto depende de cómo esté estructurado tu 'Publication' y el JSON de respuesta.
        // Asegúrate de que los nombres de campo coincidan con los de tu clase 'Publication'.
        Publication publication = PublicationModel.fromJson(responseData);
        return publication;
      } else {
        // Si la respuesta no fue exitosa, lanza una excepción.
        throw Exception(
            'Failed to load publication by user: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Manejar cualquier excepción que ocurra durante la solicitud o el procesamiento de la respuesta
      print(e.toString());
      throw Exception('Error retrieving publication by user: $e');
    }
  }

  @override
  Future<Publication> getPublicationByUuid(String uuid) async {
    //no se usa
    // Construir el URI usando el UUID proporcionado
    var uri = Uri.parse('http://localhost:3001/api/v1/public/$uuid');

    // Crear la solicitud GET
    var request = http.Request('GET', uri);

    try {
      // Enviar la solicitud y esperar una respuesta
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // Si la respuesta fue exitosa, decodificar el cuerpo de la respuesta
        String responseBody = await response.stream.bytesToString();
        var responseData = json.decode(responseBody);

        // Aquí deberías mapear los datos de la respuesta a tu objeto 'Publication'.
        // Esto depende de cómo esté estructurado tu 'Publication' y el JSON de respuesta.
        // Asegúrate de que los nombres de campo coincidan con los de tu clase 'Publication'.
        Publication publication = PublicationModel.fromJson(responseData);
        return publication;
      } else {
        // Si la respuesta no fue exitosa, lanza una excepción.
        throw Exception(
            'Failed to load publication by UUID: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Manejar cualquier excepción que ocurra durante la solicitud o el procesamiento de la respuesta
      print(e.toString());
      throw Exception('Error retrieving publication by UUID: $e');
    }
  }

  @override
  Future<List<Publication>> listPublication() async {
        // Inicializando el SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    // Si el token es null, debemos lanzar un error
    if (token == null) {
      throw Exception('Token is null. Please re-login or obtain a new token.');
    }

    var headers = {
      'Authorization': 'Bearer $token', // utiliza el token real desde SharedPreferences
    };

    try {
      print("entre a listar");
      var response = await http.get(
        Uri.parse('https://actual-servant-production.up.railway.app/api/v1/public/all'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        // Decodifica la respuesta JSON
        Map<String, dynamic> jsonData = jsonDecode(response.body);

        // Accede al campo 'data' y luego al campo 'list' que contiene las publicaciones
        List<dynamic> publicationsList = jsonData['data']['list'];

        // Convierte cada elemento en la lista a un objeto 'Publication'.
        List<Publication> publications = publicationsList
            .map((dynamic item) => PublicationModel.fromJson(item))
            .toList();

        return publications;
      } else {
        // Si el servidor responde con un código de error, lanzamos una excepción
        throw Exception('Failed to load publications from API with status code ${response.statusCode}');
      }
    } catch (error) {
      // Esto atrapará cualquier error de la solicitud y lo lanzará para ser manejado por el código que llama al método
      print(error.toString());
      throw Exception('Failed to load publications: $error');
    }
  }

  @override
  Future<void> updateDescription(String uuid, String description) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  // Si el token no existe, es una buena práctica lanzar un error o manejar esta situación de alguna manera.
  if (token == null) {
    throw Exception("No se encontró el token. Es necesario iniciar sesión de nuevo.");
  }

  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token', // Aquí se usa el token recuperado de SharedPreferences
  };

  var request = http.Request(
    'PUT',
    Uri.parse('https://actual-servant-production.up.railway.app/api/v1/public/description')
  );

  var body = json.encode({
    "uuid": uuid,
    "description": description,
  });

  request.body = body;
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      // En caso de un código de estado diferente a 200, se debe manejar el error.
      print('Error al actualizar la descripción. Estado: ${response.statusCode}.');
      throw Exception('Error al actualizar la descripción: ${response.reasonPhrase}');
    }
  } catch (e) {
    // Si se produce una excepción durante la solicitud, se atrapa aquí.
    print('Error al realizar la solicitud: $e');
    throw Exception('Error al realizar la solicitud: $e');
  }
}}
