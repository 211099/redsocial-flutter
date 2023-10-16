
import 'package:actividad1c2/feature/publication/domain/publication.dart';

abstract class PublicationRepository {
  Future<List<Publication>> listPublication();
  Future<Publication> getPublicationByUuid(String uuid);
  Future<Publication> getPublicationByUser(String name);
  Future<void> createPublication(String idUser, String description, dynamic urlFile);
  Future<void> updateDescription(String uuid, String description);  
  Future<void> deletePublication(String uuid);
}