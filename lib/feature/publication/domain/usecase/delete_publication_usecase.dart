
import '../publication_repository.dart';

class DeletePublicationUseCase {
  final PublicationRepository publicationRepository;
  DeletePublicationUseCase(this.publicationRepository);
  
  Future<void> execute(String uuid) async{
    return publicationRepository.deletePublication(uuid);
  }
}