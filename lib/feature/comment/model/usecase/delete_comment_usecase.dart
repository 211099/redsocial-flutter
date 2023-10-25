

import '../comment_repository.dart';

class DeleteCommentUseCase {
  final CommentRepository commentRepository;
  DeleteCommentUseCase(this.commentRepository);

  Future<void> execute(String uuid) async{
    return await commentRepository.deletecomment(uuid);
  }
  
}