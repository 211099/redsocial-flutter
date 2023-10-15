import 'package:actividad1c2/feature/user/domain/user.dart';
import 'package:actividad1c2/feature/user/domain/user_repository.dart';

class GetUserUseCase {
  UserRepository userRepository;
  GetUserUseCase(this.userRepository);

 Future<User> execute(String uuid) async {
    User user = await userRepository.getUser(uuid);
    return user;
  }


}