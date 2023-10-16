

import 'package:actividad1c2/feature/publication/domain/publication.dart';

import '../publication_repository.dart';

class GetPublicationByUuidUseCase {
  final PublicationRepository publicationRepository;
  GetPublicationByUuidUseCase(this.publicationRepository);

  Future<Publication> execute(String uuid) async {
    Publication publication = await publicationRepository.getPublicationByUuid(uuid);
    return publication;
  }
}