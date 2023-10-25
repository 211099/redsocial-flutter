import 'dart:convert';

import 'package:actividad1c2/feature/comment/data/comment_model.dart';

import '../model/comment.dart';
import 'package:http/http.dart' as http;
abstract class CommentApiDataSource {
  Future<List<Comment>> getCommentsByPublic(String uuid);
  Future<void> createComment(String idUser, String idPublic, String text);
  Future<void> updateComment(String uuid, String text); 
  Future<void> deletecomment(String uuid);
}

class CommentApiDataSourceImp implements CommentApiDataSource {
  @override
  Future<void> createComment(String idUser, String idPublic, String text) async{
      var headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      "id_user": idUser,
      "id_public": idPublic,
      "text": text
    });

    try {
      // Preparar y enviar la solicitud POST
      var request = http.Request('POST', Uri.parse('http://localhost:3001/api/v1/comment/create'));
      request.body = body;
      request.headers.addAll(headers);

      // Enviar la solicitud y esperar una respuesta
      http.StreamedResponse response = await request.send();

      // Procesar la respuesta
      if (response.statusCode == 200) {
        // Solicitud exitosa, puedes procesar la respuesta aquí, si lo deseas
        // print(await response.stream.bytesToString());
      } else {
        // La respuesta indica un error, puedes manejarlo o lanzar una excepción
        throw Exception('Failed to create comment. Status code: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      // Ocurrió un error al enviar la solicitud, puedes manejar el error aquí o lanzar una excepción
      // print(e.toString());
      throw Exception('Error creating comment: $e');
    }
  }

  @override
  Future<void> deletecomment(String uuid) async{
   try {
      // Preparar la solicitud DELETE
      var request = http.Request('DELETE', Uri.parse('http://localhost:3001/api/v1/comment/delete/$uuid'));

      // Enviar la solicitud y esperar una respuesta
      http.StreamedResponse response = await request.send();

      // Procesar la respuesta
      if (response.statusCode == 200) {
        // Solicitud exitosa, imprimir la respuesta o realizar otras acciones según sea necesario
        // print(await response.stream.bytesToString());
      } else {
        // Si la solicitud falló, imprimir la razón y/o manejar el error de acuerdo a la lógica de tu aplicación
        // print(response.reasonPhrase);
        throw Exception('Failed to delete comment. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar o imprimir errores generales durante la solicitud
      // print(e.toString());
      throw Exception('Error deleting comment: $e');
    }
  }

  @override
  Future<List<Comment>> getCommentsByPublic(String uuid) async{
     try {
      // Preparar la solicitud GET
      var request = http.Request('GET', Uri.parse('http://localhost:3001/api/v1/comment/$uuid'));

      // Enviar la solicitud y esperar una respuesta
      http.StreamedResponse response = await request.send();

      // Procesar la respuesta
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        // Convertir el cuerpo de la respuesta en JSON
        List<dynamic> data = jsonDecode(responseBody);
        
        // Crear una lista de comentarios a partir de la respuesta JSON
        List<Comment> comments = data.map((dynamic item) => CommenModel.fromJson(item)).toList();

        return comments;
      } else {
        // Si la solicitud falló, imprimir la razón y/o manejar el error
        // print(response.reasonPhrase);
        throw Exception('Failed to load comments. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar o imprimir errores generales durante la solicitud
      // print(e.toString());
      throw Exception('Error getting comments: $e');
    }
  }

  @override
  Future<void> updateComment(String uuid, String text) async{
      // Crear encabezados para la solicitud HTTP
    var headers = {
      'Content-Type': 'application/json',
    };

    // Preparar el cuerpo de la solicitud con los datos a actualizar
    var requestBody = json.encode({
      "uuid": uuid,
      "text": text,
    });

    try {
      // Crear y enviar la solicitud PUT
      var request = http.Request('PUT', Uri.parse('http://localhost:3001/api/v1/comment/update'));
      request.body = requestBody;
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      // Verificar el estado de la respuesta
      if (response.statusCode == 200) {
        // Si es exitoso, puedes procesar la respuesta (si es necesario)
        String responseBody = await response.stream.bytesToString();
        print(responseBody); // Imprimir la respuesta o manejarla según sea necesario
      } else {
        // Si la solicitud falló, lanza un error
        print(response.reasonPhrase);
        throw Exception('Failed to update comment. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar o imprimir cualquier error que ocurra durante la solicitud
      print(e.toString());
      throw Exception('Error updating comment: $e');
    }
  }
  
}