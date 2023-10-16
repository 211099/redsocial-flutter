

import '../comment_repository.dart';

class CreateCommentUseCase {
  final CommentRepository commentRepository;
  CreateCommentUseCase(this.commentRepository);

  Future<void> execute(String idUser, String idPublic, String text) async{
    return await commentRepository.createComment(idUser, idPublic, text);
  }
  
}