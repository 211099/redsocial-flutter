

import 'package:actividad1c2/feature/comment/model/comment.dart';

abstract class CommentRepository {
  Future<List<Comment>> getCommentsByPublic(String uuid);
  Future<void> createComment(String idUser, String idPublic, String text);
  Future<void> updateComment(String uuid, String text); 
  Future<void> deletecomment(String uuid);
}