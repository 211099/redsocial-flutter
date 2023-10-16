import 'dart:convert';
import 'dart:io';

import 'package:actividad1c2/feature/publication/data/publication_model.dart';

import '../domain/publication.dart';
import 'package:http/http.dart' as http;

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
    var uri = Uri.parse('http://localhost:3001/api/v1/public/create');
    var request = http.MultipartRequest('POST', uri);

    request.fields['idUser'] = idUser;
    request.fields['description'] = description;

    // Manejando el 'urlFile' que puede ser un File o una String.
    if (urlFile is File) {
      // Si es un archivo, crea un MultipartFile directamente.
      try {
        var multipartFile =
            await http.MultipartFile.fromPath('img_file', urlFile.path);
        request.files.add(multipartFile);
      } catch (e) {
        // Manejo de errores durante la creación del MultipartFile.
        throw Exception('Error al adjuntar el archivo: $e');
      }
    } else if (urlFile is String) {
      //estaria mal ya que estoy esperando un archivo no un string(url)
    } else {
      // Si 'urlFile' no es ni File ni String, deberás decidir cómo manejar este caso.
      throw Exception(
          'Tipo de "urlFile" no soportado: Se espera un File o una String.');
    }

    // Procesando la respuesta del servidor igual que antes.
    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
      } else {
        // print(response.reasonPhrase);
        throw Exception(
            'Error al crear la publicación: ${response.reasonPhrase}');
      }
    } catch (e) {
      // print(e.toString());
      throw Exception('Error durante la creación de la publicación: $e');
    }
  }

  @override
  Future<void> deletePublication(String uuid) async {
    // Crear el URI utilizando el 'uuid' proporcionado.
    var uri = Uri.parse('http://localhost:3001/api/v1/public/delete/$uuid');

    // Crear la solicitud DELETE.
    var request = http.Request('DELETE', uri);

    try {
      // Enviar la solicitud y esperar la respuesta.
      http.StreamedResponse response = await request.send();

      // Verificar si la respuesta fue exitosa.
      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
      } else {
        // Si el servidor responde con un código de error, se lanza una excepción.
        throw Exception(
            'Error al eliminar la publicación: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Capturar y manejar o reenviar cualquier excepción que ocurra durante la solicitud.
      // print(e.toString());
      throw Exception('Error durante la eliminación de la publicación: $e');
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
    var uri = Uri.parse('http://localhost:3001/api/v1/public/all');

    // Crear la solicitud GET
    var request = http.Request('GET', uri);

    try {
      // Enviar la solicitud y esperar una respuesta
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // Si la respuesta fue exitosa, decodificar el cuerpo de la respuesta
        String responseBody = await response.stream.bytesToString();
        List<dynamic> responseData = json.decode(responseBody);

        // Transformar el JSON de respuesta en una lista de objetos 'Publication'.
        // Esto asume que tu clase 'Publication' tiene un constructor 'fromJson'.
        List<Publication> publications = responseData.map((data) {
          return PublicationModel.fromJson(data);
        }).toList();

        return publications;
      } else {
        // Si el servidor respondió con un error, lanzar una excepción
        throw Exception(
            'Failed to load publications: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Si ocurrió un error en el proceso de solicitud, lanzar una excepción
      // print(e.toString());
      throw Exception('Error retrieving publications: $e');
    }
  }

  @override
  Future<void> updateDescription(String uuid, String description) async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({"uuid": uuid, "description": description});

    try {
      // Crear la solicitud PUT
      var request = http.Request(
          'PUT', Uri.parse('http://localhost:3001/api/v1/public/description'));
      request.body = body;
      request.headers.addAll(headers);

      // Enviar la solicitud y esperar una respuesta
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // La solicitud fue exitosa, imprimir o procesar la respuesta aquí si es necesario
        // print(await response.stream.bytesToString());
      } else {
        // El servidor respondió con un error, puedes manejarlo o lanzar una excepción
        throw Exception(
            'Failed to update description. Status code: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      // Ocurrió un error al enviar la solicitud, imprimir o manejar el error aquí
      // print(e.toString());
      throw Exception('Error updating description: $e');
    }
  }
}
