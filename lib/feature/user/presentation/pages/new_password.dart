import 'package:flutter/material.dart';

class NewPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Esto centra el título en la barra de la aplicación
        title: Text('New Password'),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(13.0),
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
                        labelText: 'Password',
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
                        labelText: 'Confirm Password',
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        alignLabelWithHint: true,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 50),
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
                            'Send',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
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
