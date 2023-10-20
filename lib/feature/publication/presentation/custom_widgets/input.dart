import 'package:flutter/material.dart';


class MessageFieldBox extends StatelessWidget {
  const MessageFieldBox({super.key});

  @override
  Widget build(BuildContext context) {


    // final colors = Theme.of(context).colorScheme;

    final outlineInputBorder = UnderlineInputBorder(
      borderSide:  const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40));

      final inputTextDecoration = InputDecoration(
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        suffixIcon: IconButton(
          icon: Icon(Icons.search, color: Color.fromARGB(255, 160, 199, 227),),
          onPressed: () {
            print('valores');
          },
        )
      );

    return TextFormField(
      decoration:  inputTextDecoration,
      onFieldSubmitted: (value) {
        print("valor enviado: ${value}");
      },
      onChanged: (value) {
        print("valor: ${value}");
      },
    );
  }
}