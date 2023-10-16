import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class ReactionApiDataSource {
  Future<String> getReactionPublication(String uuid);
  Future<void> deleteReaction(String uuid);
  Future<void> createReaction(
      String idUser, String idPublic, String reaction, String type);
}

class ReactionApiDataSourceImp implements ReactionApiDataSource {
  @override
  Future<void> createReaction(
      String idUser, String idPublic, String reaction, String type) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://localhost:3001/api/v1/reaction/create'));
    request.body = json.encode({
      "id_user": "97b44189-18c3-478e-981e-317b2f26c46f",
      "id_public": "afc1a42f-a7a7-4967-b16a-dc35b7eacda3",
      "reaction": "Like",
      "type": "Comment"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
    } else {
      // print(response.reasonPhrase);
    }
  }

  @override
  Future<void> deleteReaction(String uuid) async{
       try {
      // Crear y enviar la solicitud DELETE
      var request = http.Request('DELETE', Uri.parse('http://localhost:3001/api/v1/reaction/delete/$uuid'));

      http.StreamedResponse response = await request.send();

      // Verificar el estado de la respuesta
      if (response.statusCode == 200) {
        // Si es exitoso, puedes procesar la respuesta aquí si es necesario
        String responseBody = await response.stream.bytesToString();
        print(responseBody); // Esto es solo para propósitos de depuración, puedes manejar la respuesta según lo necesites
      } else {
        // Si la solicitud falló, manejar el error
        print(response.reasonPhrase);
        throw Exception('Failed to delete reaction. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar cualquier excepción que ocurra durante la solicitud
      print(e.toString());
      throw Exception('Error deleting reaction: $e');
    }

  }

  @override
  Future<String> getReactionPublication(String uuid) async{
     try {
      // Crear y enviar la solicitud GET
      var request = http.Request('GET', Uri.parse('http://localhost:3001/api/v1/reaction/public/$uuid'));

      http.StreamedResponse response = await request.send();

      // Verificar el estado de la respuesta
      if (response.statusCode == 200) {
        // Si es exitoso, se procesa la respuesta aquí
        String responseBody = await response.stream.bytesToString();
        print(responseBody); // Esto es solo para propósitos de depuración. Puedes retornar el cuerpo de la respuesta o procesarlo según sea necesario.
        return responseBody; // Devolver el cuerpo de la respuesta para su uso en otra parte de tu aplicación.
      } else {
        // Si la solicitud falló, manejar el error
        print(response.reasonPhrase);
        throw Exception('Failed to get reactions for publication. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar cualquier excepción que ocurra durante la solicitud
      print(e.toString());
      throw Exception('Error while retrieving reactions: $e');
    }
  }


}
