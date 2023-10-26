import 'package:actividad1c2/feature/user/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String name,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String nickName,
    required String password,
 }) : super(

    name: name,
    lastName: lastName,
    phoneNumber: phoneNumber,
    email: email,
    nickName: nickName,
    password: password,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      nickName: json['nick_name'],
      password: json['password'],
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      name: user.name,
      lastName: user.lastName,
      phoneNumber: user.phoneNumber,
      email: user.email,
      nickName: user.nickName,
      password: user.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'nick_name': nickName,
      'password': password,
    };
  }
}
