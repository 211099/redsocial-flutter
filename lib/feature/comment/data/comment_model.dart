

import 'package:actividad1c2/feature/comment/model/comment.dart';

class CommenModel extends Comment {
  CommenModel({
    required String uuid,
    required String idUser,
    required String idPublic,
    required String text,
  }) : super (
    uuid: uuid,
    idPublic: idPublic,
    idUser: idUser,
    text: text
    );

    factory CommenModel.fromJson(Map<String,dynamic> json) {
      return CommenModel(
        uuid: json['uuid'],
        idUser: json['id_user'],
        idPublic: json['id_public'],
        text: json['text']
      );
    }

     factory CommenModel.fromEntity(Comment comment) {
      return CommenModel(
        uuid: comment.uuid,
        idPublic: comment.idPublic,
        idUser: comment.idUser,
        text: comment.text,
      );
    }

    Map<String,dynamic> toJson() {
      return{
        'uuid': uuid,
        'id_user': idUser,
        'id_public': idPublic,
        'text': text
      };
    }

}