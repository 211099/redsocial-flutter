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
   var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDhlZjMzZTAtNWU1ZS00NDcxLWI3NjMtYjMyZWQ0Y2YxYjA0IiwiZW1haWwiOiJqdWFuMUBleGFtcGxlLmNvbSIsImlhdCI6MTY5ODIyMDU1OCwiZXhwIjoxNjk4NDg2OTU4fQ.O0FvXI1wMJMF8hTgAVvJLazXjIpWenVaHQo7AIopd4s'
  };

  var request = http.Request('POST', Uri.parse('https://actual-servant-production.up.railway.app/api/v1/comment/create'));
  request.body = json.encode({
    "id_user": idUser,
    "id_public": idPublic,
    "text": text
  });
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      // Imprimir solo la razón del error puede no ser muy informativo, considera manejar diferentes códigos de estado
      print(response.reasonPhrase);
    }
  } catch (e) {
    // Manejar cualquier excepción que ocurra durante la solicitud
    // Podrías manejar diferentes tipos de errores (como timeouts, falta de conexión a internet, etc.) de manera más específica
    print(e);
    // Aquí podrías lanzar la excepción de nuevo, o manejarla según sea necesario para tu aplicación
    // throw e; 
  }
  }

  @override
  Future<void> deletecomment(String uuid) async{
    var headers = {
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDhlZjMzZTAtNWU1ZS00NDcxLWI3NjMtYjMyZWQ0Y2YxYjA0IiwiZW1haWwiOiJqdWFuMUBleGFtcGxlLmNvbSIsImlhdCI6MTY5ODIyMDU1OCwiZXhwIjoxNjk4NDg2OTU4fQ.O0FvXI1wMJMF8hTgAVvJLazXjIpWenVaHQo7AIopd4s'
  };

  var request = http.Request('DELETE', Uri.parse('https://actual-servant-production.up.railway.app/api/v1/comment/delete/$uuid'));

  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      // Imprimir solo la razón del error puede no ser muy informativo. Considera manejar diferentes códigos de estado.
      print(response.reasonPhrase);
    }
  } catch (e) {
    // Manejar cualquier excepción que ocurra durante la solicitud.
    print(e);
    // Dependiendo de tu flujo de control, podrías optar por lanzar la excepción de nuevo o manejarla de otra manera.
  }
  }

  @override
  Future<List<Comment>> getCommentsByPublic(String uuid) async{
     var url = Uri.parse('https://actual-servant-production.up.railway.app/api/v1/comment/$uuid');
    var headers = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDhlZjMzZTAtNWU1ZS00NDcxLWI3NjMtYjMyZWQ0Y2YxYjA0IiwiZW1haWwiOiJqdWFuMUBleGFtcGxlLmNvbSIsImlhdCI6MTY5ODIyMDU1OCwiZXhwIjoxNjk4NDg2OTU4fQ.O0FvXI1wMJMF8hTgAVvJLazXjIpWenVaHQo7AIopd4s' // Reemplaza con tu token real
    };
  print(uuid);
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
  Future<void> updateComment(String uuid, String text) async{
     var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDhlZjMzZTAtNWU1ZS00NDcxLWI3NjMtYjMyZWQ0Y2YxYjA0IiwiZW1haWwiOiJqdWFuMUBleGFtcGxlLmNvbSIsImlhdCI6MTY5ODIyMDU1OCwiZXhwIjoxNjk4NDg2OTU4fQ.O0FvXI1wMJMF8hTgAVvJLazXjIpWenVaHQo7AIopd4s'
  };
  var body = jsonEncode({
    "uuid": uuid,
    "text": text
  });

  var uri = Uri.parse('https://actual-servant-production.up.railway.app/api/v1/comment/update');
  try {
    var response = await http.put(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Comentario actualizado con éxito.');
    } else {
      // Si el servidor responde con un código de error, lanza un error.
      print('Falló la actualización del comentario: ${response.reasonPhrase}');
      throw Exception('Falló la actualización del comentario. Estado: ${response.statusCode}');
    }
  } catch (error) {
    // Si ocurre algún error durante la ejecución, lanza un error.
    print('Error al actualizar el comentario: $error');
    throw Exception('Error al actualizar el comentario: $error');
  }
  }
  
}