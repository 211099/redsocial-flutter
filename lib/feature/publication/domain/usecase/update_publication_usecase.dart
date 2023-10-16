

import '../publication_repository.dart';

class UpdatePublicationUseCase {
  final PublicationRepository publicationRepository;
  UpdatePublicationUseCase(this.publicationRepository);

  Future<void> execute(String uuid, String description) async{
    return await publicationRepository.updateDescription(uuid, description);
  }
}