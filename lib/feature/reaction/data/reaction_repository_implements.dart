import 'package:actividad1c2/feature/reaction/data/reaction_api_data_source.dart';
import 'package:actividad1c2/feature/reaction/domain/reaction_repository.dart';

class ReactionRepositoryImpl implements ReactionRepository {
  final ReactionApiDataSource reactionApiDataSource;
  ReactionRepositoryImpl({required this.reactionApiDataSource});

  @override
  Future<void> createReaction(String idUser, String idPublic, String reaction, String type) async{
   return await  reactionApiDataSource.createReaction(idUser, idPublic, reaction, type);
  }

  @override
  Future<void> deleteReaction(String uuid) async{
    return await reactionApiDataSource.deleteReaction(uuid);
  }

  @override
  Future<String> getReactionPublication(String uuid) async{
    return await reactionApiDataSource.getReactionPublication(uuid);
  }
  
}