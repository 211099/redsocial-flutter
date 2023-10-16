

import 'package:actividad1c2/feature/reaction/domain/reaction_repository.dart';

class GetReactionByPublicationUseCase {
  final ReactionRepository reactionRepository;
  GetReactionByPublicationUseCase(this.reactionRepository);

  Future<String> execute(String uuid) async{
    return await reactionRepository.getReactionPublication(uuid);
  }

}