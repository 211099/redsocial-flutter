import 'package:actividad1c2/feature/user/presentation/pages/register.dart';
import 'package:actividad1c2/feature/user/presentation/pages/restore_pasword.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login in')),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 60,
                  left: 137,
                  child: Opacity(
                    opacity: 0.4,
                    child: Image(
                      width: 114,
                      height: 115,
                      image: AssetImage('assets/spafill0wght400grad0opsz24-1-GuG.png'),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        alignLabelWithHint: true,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Aquí puedes agregar la lógica para manejar el inicio de sesión
                      },
                      child: Container(
                        width: 310,
                        height: 40,
                        margin: EdgeInsets.only(top: 2, left: 4),
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()), // Reemplaza 'RegisterView' con el nombre de tu vista de registro
                        );
                      },
                      child: Container(
                        width: 310,
                        height: 40,
                        margin: EdgeInsets.only(top: 2, left: 4),
                        child: Center(
                          child: Text(
                            'register',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RestorePassword()), // Reemplaza 'ResetPasswordPage' con el nombre de tu vista de restablecimiento de contraseña
                        );
                      },
                      child: Text(
                        'Restore Password',
                        style: TextStyle(
                          color: Colors.blue, // Puedes personalizar el color del texto
                          decoration: TextDecoration.underline, // Agrega un subrayado al texto
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
