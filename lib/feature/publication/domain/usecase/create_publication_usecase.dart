
import 'package:actividad1c2/feature/publication/domain/publication.dart';
import 'package:actividad1c2/feature/publication/domain/publication_repository.dart';

class CreatePublicationUseCase {
  final PublicationRepository publicationRepository;
  CreatePublicationUseCase(this.publicationRepository);

  Future<void> execute(Publication publication) async{
    return await publicationRepository.createPublication(publication);
  }

}