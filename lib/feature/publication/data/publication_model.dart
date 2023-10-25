import 'package:actividad1c2/feature/publication/domain/publication.dart';

class PublicationModel extends Publication {
  PublicationModel({
    required String uuid,
    required String idUser, 
    required String description, 
    required dynamic urlFile,
    required String typeFile,
    required String userName,
    required String userNickName
    }) : super (
      uuid: uuid,
      idUser: idUser,
      description: description,
      urlFile: urlFile,
      typeFile: typeFile,
      userName: userName,
      userNickName: userNickName
    );

    factory PublicationModel.fromJson(Map<String,dynamic> json) {
      return PublicationModel(
        uuid: json['uuid'],
        idUser: json['idUser'],
        description: json['description'],
        urlFile: json['img_file'],
        typeFile: json['type_file'],
        userName: json["userName"],
        userNickName: json["userNickName"]
      );
    }

    factory PublicationModel.fromEntity(Publication publication) {
      return PublicationModel(
        uuid: publication.uuid,
        idUser: publication.idUser,
        description: publication.description,
        urlFile: publication.urlFile,
        typeFile: publication.typeFile,
        userName: publication.userName,
        userNickName: publication.userNickName
      );
    }

    Map<String, dynamic> toJson() {
      return{
        'uuid': uuid,
        'idUser': idUser,
        'description': description,
        'img_file': urlFile,
        'type_file': typeFile,
        'userName': userName,
        "userNickName": userNickName,
      };
    }
  
}