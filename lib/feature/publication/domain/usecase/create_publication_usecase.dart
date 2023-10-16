
import 'package:actividad1c2/feature/publication/domain/publication_repository.dart';

class CreatePublicationUseCase {
  final PublicationRepository publicationRepository;
  CreatePublicationUseCase(this.publicationRepository);

  Future<void> execute(String idUser, String description, dynamic urlFile) async{
    return await publicationRepository.createPublication(idUser, description, urlFile);
  }

}