

import 'package:actividad1c2/feature/user/domain/user.dart';

abstract class UserRepository {
  Future<void> registerUser(User user);
  Future<void> logIn({required String email, required String password});
  Future<void> deleteUser(String uuid);
  Future<void> updateUser({
    required String uuid,
    required String name,
    required String lastName,
    required String phoneNumber,
    required String email,
  });
  Future<User> getUser(String uuid);
  Future<List<User>> listUsers();
}