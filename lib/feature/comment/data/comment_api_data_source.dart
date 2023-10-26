import 'dart:convert';

import 'package:actividad1c2/feature/comment/data/comment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      // Recuperar el token guardado en SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  // Si no hay token, lanzamos un error
  if (token == null) {
    throw Exception('Token no encontrado. El usuario debe iniciar sesión.');
  }

  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',  // Usar el token recuperado
  };

  // Crear la solicitud
  var request = http.Request('POST', Uri.parse('https://actual-servant-production.up.railway.app/api/v1/comment/create'));
  
  // Agregar el cuerpo a la solicitud
  request.body = json.encode({
    "id_user": idUser,
    "id_public": idPublic,
    "text": text
  });
  print(idUser);
  print(idPublic);
  print(text);

  // Agregar encabezados a la solicitud
  request.headers.addAll(headers);

  try {
    // Enviar la solicitud y esperar una respuesta
    http.StreamedResponse response = await request.send();

    // Si la solicitud fue exitosa
    if (response.statusCode == 201) {
      print(await response.stream.bytesToString());
    } else {
      // Si la solicitud falla, imprimir la razón del fallo
      print(response.reasonPhrase);
      throw Exception('Error al crear el comentario: ${response.reasonPhrase}');
    }
  } catch (e) {
    // Captura y manejo de cualquier error que ocurra durante la operación
    print('Error al enviar la solicitud: $e'); // Re-lanzar el error para ser capturado por cualquier manejo superior
  }
  }

  @override
  Future<void> deletecomment(String uuid) async{
   // Recuperar el token de SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  // Si el token es null, entonces no está disponible en SharedPreferences
  if (token == null) {
    throw Exception('No se encontró el token. Es necesario iniciar sesión.');
  }

  // Preparar los encabezados con el token de autorización
  var headers = {
    'Authorization': 'Bearer $token',
  };

  // Crear la solicitud DELETE
  var request = http.Request('DELETE', Uri.parse('https://actual-servant-production.up.railway.app/api/v1/comment/delete/$uuid'));

  // Añadir los encabezados a la solicitud
  request.headers.addAll(headers);

  try {
    // Enviar la solicitud
    http.StreamedResponse response = await request.send();

    // Manejar la respuesta de la solicitud
    if (response.statusCode == 200) {
      print('Comentario eliminado con éxito.');
    } else {
      // Si el servidor responde con un código de error, imprimirlo
      print('Error al eliminar el comentario: ${response.reasonPhrase}');
      throw Exception('Error al eliminar el comentario: ${response.reasonPhrase}');
    }
  } catch (e) {
    // Si ocurre un error al enviar la solicitud, imprimirlo
    print('Error al enviar la solicitud: $e');
    throw e; // Puedes optar por lanzar la excepción para manejarla en otro lugar
  }
  }

  @override
  Future<List<Comment>> getCommentsByPublic(String uuid) async{
     var url = Uri.parse('https://actual-servant-production.up.railway.app/api/v1/comment/$uuid');
    var headers = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDhlZjMzZTAtNWU1ZS00NDcxLWI3NjMtYjMyZWQ0Y2YxYjA0IiwiZW1haWwiOiJqdWFuMUBleGFtcGxlLmNvbSIsImlhdCI6MTY5ODIyMDU1OCwiZXhwIjoxNjk4NDg2OTU4fQ.O0FvXI1wMJMF8hTgAVvJLazXjIpWenVaHQo7AIopd4s' // Reemplaza con tu token real
    };

    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);

        // Accede al campo 'data' y luego al campo 'list' que contiene las publicaciones
        List<dynamic> commentList = jsonData['data'];


        // Convierte el cuerpo de la respuesta en una lista de comentarios.
        List<Comment> comments = commentList
            .map(
              (dynamic item) => CommenModel.fromJson(item),
            )
            .toList();

        return comments;
      } else {
        // Si el servidor no responde con un código de estado 200, se considera un error.
        throw Exception('Failed to load comments: ${response.statusCode}');
      }
    } catch (exception) {
      // Cualquier excepción lanzada durante la solicitud o el procesamiento de la respuesta se capturará aquí.
      rethrow;  // Puedes manejar el error aquí o simplemente lanzarlo para manejarlo en un nivel superior
    }

  }

  @override
   Future<void> updateComment(String uuid, String text) async {
      // Recuperar el token guardado en SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  // Si no hay token, lanzamos un error
  if (token == null) {
    throw Exception('Token no encontrado. El usuario debe iniciar sesión.');
  }

  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token', // Usar el token recuperado
  };

  var request = http.Request('PUT', Uri.parse('https://actual-servant-production.up.railway.app/api/v1/comment/update'));

  // Agregar el cuerpo a la solicitud
  request.body = json.encode({
    "uuid": uuid,
    "text": text,
  });

  // Agregar encabezados a la solicitud
  request.headers.addAll(headers);

  try {
    // Enviar la solicitud y esperar una respuesta
    http.StreamedResponse response = await request.send();

    // Si la solicitud fue exitosa
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      // Si la solicitud falla, imprimir la razón del fallo
      print(response.reasonPhrase);
      throw Exception('Error al actualizar el comentario: ${response.reasonPhrase}');
    }
  } catch (e) {
    // Captura y manejo de cualquier error que ocurra durante la operación
    print('Error al enviar la solicitud: $e');
    throw e; // Re-lanzar el error para ser capturado por cualquier manejo superior
  }
  }
  
}