import 'package:actividad1c2/feature/user/domain/entities/user.dart';
import 'package:actividad1c2/feature/user/domain/repository/user_repository.dart';

class GetUserUseCase {
  UserRepository userRepository;
  GetUserUseCase(this.userRepository);

 Future<User> execute(String uuid) async {
    User user = await userRepository.getUser(uuid);
    return user;
  }


}