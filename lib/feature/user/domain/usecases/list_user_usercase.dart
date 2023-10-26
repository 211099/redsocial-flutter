import 'package:actividad1c2/feature/user/domain/entities/user.dart';
import 'package:actividad1c2/feature/user/domain/repository/user_repository.dart';

class ListUserUseCase {
  final UserRepository userRepository;
  ListUserUseCase(this.userRepository);
  Future<List<User>> execute() async {
    return await userRepository.listUsers();
  }
}