import 'package:actividad1c2/feature/comment/data/comment_api_data_source.dart';
import 'package:actividad1c2/feature/comment/model/comment.dart';
import 'package:actividad1c2/feature/comment/model/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentApiDataSource commentApiDataSource;
  CommentRepositoryImpl({required this.commentApiDataSource});


  @override
  Future<void> createComment(String idUser, String idPublic, String text) async{
   return await commentApiDataSource.createComment(idUser, idPublic, text);
  }

  @override
  Future<void> deletecomment(String uuid) async{
    return await commentApiDataSource.deletecomment(uuid);
  }

  @override
  Future<List<Comment>> getCommentsByPublic(String uuid) async{
    return await commentApiDataSource.getCommentsByPublic(uuid);
  }

  @override
  Future<void> updateComment(String uuid, String text) async{
    return await commentApiDataSource.updateComment(uuid, text);
  }
  
}