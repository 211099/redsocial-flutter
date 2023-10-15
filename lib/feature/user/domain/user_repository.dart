

import 'package:actividad1c2/feature/user/domain/user.dart';

abstract class UserRepository {
  Future<void> registerUser(User user);
  Future<void> logIn({required String email, required String password});
  Future<void> deleteUser(String uuid);
  Future<User> getUser(String uuid);
  Future<List<User>> listUsers();
}