import 'package:flutter/material.dart';

import 'new_password.dart';

class RestorePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restore Password'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width < 600
              ? MediaQuery.of(context).size.width
              : 600,
          child: SingleChildScrollView( // Agregar SingleChildScrollView
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FractionallySizedBox(
                  widthFactor: 0.3,
                  child: Image.asset('assets/spafill0wght400grad0opsz24-1-GuG.png'),
                ),
                SizedBox(height: 100),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    // Personaliza el borde del campo de entrada de texto
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0), // Radio del borde
                      borderSide: BorderSide(
                        width: 2.0, // Grosor del borde
                        color: Colors.black, // Color del borde
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 80),
                ElevatedButton(
                  onPressed: () {
                    // Navega a la página de restablecimiento de contraseña cuando se presiona el botón
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewPassword()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    minimumSize: MaterialStateProperty.all(Size(330, 58)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),  // Cambia el color del texto aquí
                  ),
                  child: Text('Send'),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
