import 'package:actividad1c2/feature/user/domain/user.dart';
import 'package:actividad1c2/feature/user/domain/user_repository.dart';

class RegisterUserUseCase {
  final UserRepository userRepository;
  RegisterUserUseCase(this.userRepository);

  Future<void> execute(User user) async {
     return await userRepository.registerUser(user);
  }

}