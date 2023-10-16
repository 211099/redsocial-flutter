import 'package:actividad1c2/feature/user/domain/user_repository.dart';

class DeleteUserUseCase {
  final UserRepository userRepository;
  DeleteUserUseCase(this.userRepository);

  Future<void> execute(String uuid) async {
    return await userRepository.deleteUser(uuid);
  }
}