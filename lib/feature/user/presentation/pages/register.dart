import 'package:actividad1c2/feature/user/presentation/pages/restore_pasword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../blocks/register/register_user_bloc.dart';
import 'login.dart';

class Register extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Registro de Usuario'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/personfill0wght400grad0opsz24-1.png',
                  width: width * 0.4,
                  height: width * 0.4,
                ),
                _buildVerticalSpace(20),
                _buildRoundedTextField('Name', controller: nameController),
                _buildVerticalSpace(10),
                _buildRoundedTextField('Last Name', controller: lastNameController),
                _buildVerticalSpace(10),
                _buildRoundedTextField('Phone Number', controller: phoneNumberController),
                _buildVerticalSpace(10),
                _buildRoundedTextField('Nik Name', controller: nickNameController),
                _buildVerticalSpace(10),
                _buildRoundedTextField('Email', isPassword: false, controller: emailController),
                _buildVerticalSpace(10),
                _buildRoundedTextField('Password', isPassword: true, controller: passwordController),
                _buildVerticalSpace(40),
                BlocConsumer<RegisterUserBloc, RegisterUserState>(
                  listener: (context, state) {
                    if (state is RedirectToRegistrationPage) {
                      print("entreaaaaaaaaaaaaaaaaaaa");
                      Navigator.pushReplacementNamed(context, '/login');
                    } else if (state is RegisterSuccessState) {
                      Navigator.pushReplacementNamed(context, '/login');
                    } else if (state is RegisterFailureState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  builder: (context, state) {
                    return _buildElevatedButton(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalSpace(double height) {
    return SizedBox(height: height);
  }

  Widget _buildRoundedTextField(String labelText, {bool isPassword = false, TextEditingController? controller}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        color: Color(0xFFD9D9D9),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildElevatedButton(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      primary: Color(0xFF000000),
      padding: EdgeInsets.symmetric(horizontal: 20),
      minimumSize: Size(MediaQuery.of(context).size.width, 50),
    );

    return ElevatedButton(
      onPressed: () {
        String name = nameController.text;
        String lastName = lastNameController.text;
        String phoneNumber = phoneNumberController.text;
        String nickName = nickNameController.text;
        String email = emailController.text;
        String password = passwordController.text;

        BlocProvider.of<RegisterUserBloc>(context).add(RegisterUserSubmitEvent(
          name: name,
          last_name: lastName,
          phone_number: phoneNumber,
          nick_name: nickName,
          email: email,
          password: password,
        ));
      },
      style: buttonStyle,
      child: Text(
        'Send',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}
