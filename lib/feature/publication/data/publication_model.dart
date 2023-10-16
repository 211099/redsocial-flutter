import 'package:actividad1c2/feature/publication/domain/publication.dart';

class PublicationModel extends Publication {
  PublicationModel({
    required String uuid,
    required String idUser, 
    required String description, 
    required dynamic urlFile
    }) : super (
      uuid: uuid,
      idUser: idUser,
      description: description,
      urlFile: urlFile
    );

    factory PublicationModel.fromJson(Map<String,dynamic> json) {
      return PublicationModel(
        uuid: json['idUser'],
        idUser: json['id_user'],
        description: json['description'],
        urlFile: json['url_file']
      );
    }

    factory PublicationModel.fromEntity(Publication publication) {
      return PublicationModel(
        uuid: publication.uuid,
        idUser: publication.idUser,
        description: publication.description,
        urlFile: publication.urlFile
      );
    }

    Map<String, dynamic> toJson() {
      return{
        'uuid': uuid,
        'id_user': idUser,
        'description': description,
        'url_file': urlFile
      };
    }
  
}