import 'package:actividad1c2/feature/publication/data/publication_api_data_source.dart';
import 'package:actividad1c2/feature/publication/domain/publication.dart';
import 'package:actividad1c2/feature/publication/domain/publication_repository.dart';

class PublicationRepositoryImp implements PublicationRepository {
  final PublicationApiDataSource publicationApiDataSource;
  PublicationRepositoryImp({required this.publicationApiDataSource});

  @override
  Future<void> createPublication(String idUser, String description, dynamic urlFile) async{
    return await publicationApiDataSource.createPublication(idUser, description, urlFile);
  }

  @override
  Future<void> deletePublication(String uuid) async{
    return await publicationApiDataSource.deletePublication(uuid);
  }

  @override
  Future<Publication> getPublicationByUser(String name) async{
    return await publicationApiDataSource.getPublicationByUser(name);
  }

  @override
  Future<Publication> getPublicationByUuid(String uuid) async{
    return await publicationApiDataSource.getPublicationByUuid(uuid);
  }

  @override
  Future<List<Publication>> listPublication() async{
    return await publicationApiDataSource.listPublication();
  }

  @override
  Future<void> updateDescription(String uuid, String description) async{
    return await publicationApiDataSource.updateDescription(uuid, description);
  }
  
  
}