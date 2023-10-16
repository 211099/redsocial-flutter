import 'package:actividad1c2/feature/publication/domain/publication.dart';

import '../publication_repository.dart';

class ListPublicationUseCase {
  final PublicationRepository publicationRepository;
  ListPublicationUseCase(this.publicationRepository);

  Future<List<Publication>> execute() async {
    return await publicationRepository.listPublication();
  }
  
}