import 'package:actividad1c2/feature/user/domain/user.dart';
import 'package:actividad1c2/feature/user/domain/user_repository.dart';

class ListUserUseCase {
  final UserRepository userRepository;
  ListUserUseCase(this.userRepository);
  Future<List<User>> execute() async {
    return await userRepository.listUsers();
  }
}