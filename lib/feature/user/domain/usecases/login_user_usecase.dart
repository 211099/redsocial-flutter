import 'package:actividad1c2/feature/user/domain/user_repository.dart';

class LogInUserUseCase {
  final UserRepository userRepository;
  LogInUserUseCase(this.userRepository);

  Future<void> execute(String email, String password) async{
    return await userRepository.logIn(email: email, password: password);
  }
}