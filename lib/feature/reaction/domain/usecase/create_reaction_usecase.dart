import 'package:actividad1c2/feature/reaction/domain/reaction_repository.dart';

class CreateReactionUseCase {
  final ReactionRepository reactionRepository;
  CreateReactionUseCase(this.reactionRepository);

  Future<void> execute(String idUser, String idPublic, String reaction, String type) async{
    return await reactionRepository.createReaction(idUser, idPublic, reaction, type);
  }

}