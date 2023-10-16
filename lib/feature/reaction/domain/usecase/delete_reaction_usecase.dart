import 'package:actividad1c2/feature/reaction/domain/reaction_repository.dart';

class DeleteReactionUseCase {
  final ReactionRepository reactionRepository;
  DeleteReactionUseCase(this.reactionRepository);

  Future<void> execute(String uuid) async{
    return await reactionRepository.deleteReaction(uuid);
  }

}