import 'package:actividad1c2/feature/publication/domain/publication.dart';

import '../publication_repository.dart';

class GetPublicationByUserUseCase {
  final PublicationRepository publicationRepository;
  GetPublicationByUserUseCase(this.publicationRepository);

  Future<Publication> execute(String name) async {
    Publication publication = await publicationRepository.getPublicationByUser(name);
    return publication;
  }
  
}