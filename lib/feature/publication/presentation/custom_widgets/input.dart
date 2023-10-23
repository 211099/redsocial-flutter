import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  const MessageFieldBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define el estilo de borde que deseas usar para el TextFormField
    final outlineInputBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    // Define la decoración del campo de texto
    final inputTextDecoration = InputDecoration(
      contentPadding: const EdgeInsets.symmetric(
          vertical: 10.0, horizontal: 20.0), // Reduce el padding vertical
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      fillColor: const Color(0xFF353535),
      suffixIcon: IconButton(
        icon: const Icon(Icons.search, color: Color.fromARGB(255, 160, 199, 227)),
        onPressed: () {
          print('valores');
        },
      ),
    );

    // Retorna el TextFormField con la decoración definida
    return TextFormField(
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: inputTextDecoration,
      onFieldSubmitted: (value) {
        print("valor enviado: $value");
      },
      onChanged: (value) {
        print("valor: $value");
      },
    );
  }
}
