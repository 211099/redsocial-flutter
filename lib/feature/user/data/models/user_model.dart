
import 'package:actividad1c2/feature/user/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String uuid,
    required String name,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String password,
    required bool status,
  }) : super(
          uuid: uuid,
          name: name,
          lastName: lastName,
          phoneNumber: phoneNumber,
          email: email,
          password: password,
          status: status,
        );

  factory UserModel.fromJson(Map<String,dynamic> json) {
    return UserModel(
      uuid: json['uuid'],
      name: json['name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      password: json['password'],
      status: json['status']
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      uuid: user.uuid,
      name: user.name,
      lastName: user.lastName,
      phoneNumber: user.phoneNumber,
      email: user.password,
      password: user.password,
      status: user.status
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'password': password,
      'status': status
    };
  }
  
}
