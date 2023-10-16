import 'package:actividad1c2/feature/comment/model/comment.dart';
import 'package:actividad1c2/feature/comment/model/comment_repository.dart';

class GetCommentByPublicationUseCase {
  final CommentRepository commentRepository;
  GetCommentByPublicationUseCase(this.commentRepository);
  
  Future<List<Comment>> execute(String uuid) async{
    return await commentRepository.getCommentsByPublic(uuid);
  }
  
}