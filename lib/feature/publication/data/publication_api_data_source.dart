import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:actividad1c2/feature/publication/data/publication_model.dart';

import '../domain/publication.dart';

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
  @override
  Future<void> createPublication(
      String idUser, String description, dynamic urlFile) async {
    try {
      var headers = {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZDZlNGJlNTYtZDk4MC00YTE5LWE5NjAtZDNhY2ZjNzdjMThmIiwiZW1haWwiOiJqdWFuMTJAZXhhbXBsZS5jb20iLCJpYXQiOjE2OTgwODc1MjQsImV4cCI6MTY5ODM1MzkyNH0.2YW_ueR2faKIeHJfYshh13JNrL241cfYefEKeAYZXDE', // Coloca aquí tu token actual
      };

      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://actual-servant-production.up.railway.app/api/v1/public/create'));

      request.fields.addAll({
        'idUser':
            idUser, // esto toma el valor de idUser que se pasa a la función
        'description':
            description, // esto toma el valor de description que se pasa a la función
      });

      // Adjunta el archivo. filePath debe ser la ruta del archivo en el dispositivo.
      request.files.add(await http.MultipartFile.fromPath('url_file', urlFile));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      // Manejar la excepción adecuadamente
      print(e);
    }
  }

  @override
  Future<void> deletePublication(String uuid) async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDhlZjMzZTAtNWU1ZS00NDcxLWI3NjMtYjMyZWQ0Y2YxYjA0IiwiZW1haWwiOiJqdWFuMUBleGFtcGxlLmNvbSIsImlhdCI6MTY5ODIyMDU1OCwiZXhwIjoxNjk4NDg2OTU4fQ.O0FvXI1wMJMF8hTgAVvJLazXjIpWenVaHQo7AIopd4s'
    };

    var url = Uri.parse(
        'https://actual-servant-production.up.railway.app/api/v1/public/delete/$uuid'); // Asegúrate de que tu endpoint puede manejar la variable uuid.

    // Usando un try-catch para manejar posibles errores durante la solicitud.
    try {
      var response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        print('Publicación eliminada con éxito. Respuesta: ${response.body}');
      } else {
        print(
            'Error al eliminar la publicación. Estado: ${response.statusCode}. Razón: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Esto atrapará cualquier otra excepción que pueda ocurrir.
      // Puedes manejarlo de manera diferente, dependiendo de tus necesidades.
      print('Ocurrió un error al enviar la solicitud: $e');
    }
  }

  @override
  Future<Publication> getPublicationByUser(String name) async {
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
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZDZlNGJlNTYtZDk4MC00YTE5LWE5NjAtZDNhY2ZjNzdjMThmIiwiZW1haWwiOiJqdWFuMTJAZXhhbXBsZS5jb20iLCJpYXQiOjE2OTgwODc1MjQsImV4cCI6MTY5ODM1MzkyNH0.2YW_ueR2faKIeHJfYshh13JNrL241cfYefEKeAYZXDE'
    };
    print("entre a listar");
    var response = await http.get(
      Uri.parse(
          'https://actual-servant-production.up.railway.app/api/v1/public/all'),
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
      throw Exception('Failed to load publications from API');
    }
  }

  @override
  Future<void> updateDescription(String uuid, String description) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZDZlNGJlNTYtZDk4MC00YTE5LWE5NjAtZDNhY2ZjNzdjMThmIiwiZW1haWwiOiJqdWFuMTJAZXhhbXBsZS5jb20iLCJpYXQiOjE2OTgwODc1MjQsImV4cCI6MTY5ODM1MzkyNH0.2YW_ueR2faKIeHJfYshh13JNrL241cfYefEKeAYZXDE', // reemplaza con tu token real
    };

    var request = http.Request(
        'PUT', Uri.parse('https://actual-servant-production.up.railway.app/api/v1/public/description'));

    // Asegúrate de que el cuerpo de la solicitud contenga los campos que espera tu API.
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
        // Aquí puedes manejar errores de diferentes maneras, no solo imprimir
        print(
          'Error al actualizar la descripción: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      // Manejo de errores de red, etc.
      print('Error al realizar la solicitud: $e');
    }
  }
}
