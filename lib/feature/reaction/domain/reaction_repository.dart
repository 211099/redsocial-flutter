abstract class ReactionRepository {
  Future<String> getReactionPublication(String uuid);
  Future<void> deleteReaction(String uuid);
  Future<void> createReaction(String idUser, String idPublic, String reaction, String type);
  
}