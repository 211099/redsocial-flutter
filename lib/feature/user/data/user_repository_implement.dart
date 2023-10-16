import 'package:actividad1c2/feature/user/data/user_api_data_source.dart';
import 'package:actividad1c2/feature/user/domain/user.dart';
import 'package:actividad1c2/feature/user/domain/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  final UserApiDataSource userApiDataSource;

  UserRepositoryImp({required this.userApiDataSource});

  @override
  Future<void> deleteUser(String uuid) async{
    return await userApiDataSource.deleteUser(uuid);
  }

  @override
  Future<User> getUser(String uuid) async{
     return await userApiDataSource.getUser(uuid);
  }

  @override
  Future<List<User>> listUsers() async{
     return await userApiDataSource.listUsers();
  }

  @override
  Future<void> logIn({required String email, required String password}) async{
     return await userApiDataSource.logIn(email: email, password: password);
  }

  @override
  Future<void> registerUser(User user) async{
     return await userApiDataSource.registerUser(user);
  }
  
  @override
  Future<void> updateUser({required String uuid, required String name, required String lastName, required String phoneNumber, required String email}) async{
   return await userApiDataSource.updateUser(uuid: uuid, name: name, lastName: lastName, phoneNumber: phoneNumber, email: email);
  }
  
}