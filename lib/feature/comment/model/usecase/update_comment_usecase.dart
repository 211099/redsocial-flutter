

import '../comment_repository.dart';

class UpdateCommentUseCase {
  final CommentRepository commentRepository;
  UpdateCommentUseCase(this.commentRepository);

  Future<void> execute(String uuid, String text) async{
    return await commentRepository.updateComment(uuid, text);
  }
}