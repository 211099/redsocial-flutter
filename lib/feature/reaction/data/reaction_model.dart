import 'package:actividad1c2/feature/reaction/domain/reaction.dart';

class ReactionModel extends Reaction {
  ReactionModel({
    required String uuid,
    required String idUser,
    required String idPublicaciones,
    required bool reaction,
    required String type
  }) : super (
    uuid: uuid,
    idUser: idUser,
    idPublicaciones: idPublicaciones,
    reaction: reaction,
    type: type
  );


  factory ReactionModel.fromJson(Map<String, dynamic> json) {
    return ReactionModel(
      uuid: json['uuid'],
      idUser: json['id_user'],
      idPublicaciones: json['id_public'],
      reaction: json['reaction'],
      type: json['type'],
    );
  }

   factory ReactionModel.fromEntity(Reaction reaction) {
    return ReactionModel(
      uuid: reaction.uuid,
      idUser: reaction.idUser,
      idPublicaciones: reaction.idPublicaciones,
      reaction: reaction.reaction,
      type: reaction.type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'id_user': idUser,
      'id_public': idPublicaciones,
      'reaction': reaction,
      'type': type,
    };
  }

}


