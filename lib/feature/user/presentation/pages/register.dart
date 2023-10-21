import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.4,
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * 0.4,
                ),
                SizedBox(height: 20),
                _buildRoundedTextField('Name'),
                SizedBox(height: 10),
                _buildRoundedTextField('Last Name'),
                SizedBox(height: 10),
                _buildRoundedTextField('Phone Number'),
                SizedBox(height: 10),
                _buildRoundedTextField('Nik Name'),
                SizedBox(height: 10),
                _buildRoundedTextField('Email', isPassword: false),
                SizedBox(height: 10),
                _buildRoundedTextField('Password', isPassword: true),
                SizedBox(height: 40),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return ElevatedButton(
                      onPressed: () {
                        // Manejar el evento de registro aquí
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF000000),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        minimumSize: Size(constraints.maxWidth, 50),
                      ),
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedTextField(String labelText, {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        color: Color(0xFFD9D9D9), // Color de fondo (#D9D9D9)
      ),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          border: InputBorder.none,
        ),
      ),
    );
  }

}

