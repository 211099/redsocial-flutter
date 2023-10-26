import 'package:flutter/material.dart';

class TextInputEditPublication extends StatefulWidget {
  const TextInputEditPublication({Key? key,}) : super(key: key);

  @override
  _TextInputEditPublicationState createState() => _TextInputEditPublicationState();
}

class _TextInputEditPublicationState extends State<TextInputEditPublication> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _sendText() {
    // Aquí puedes manejar el texto ingresado, por ejemplo, enviarlo a alguna API o algo similar.
    Navigator.of(context).pop(_textEditingController.text); // Cierra el diálogo y devuelve el texto.
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Publicación'),
      content: TextField(
        controller: _textEditingController,
        autofocus: true, // para que el teclado aparezca automáticamente
        decoration: InputDecoration(hintText: "Ingrese su texto aquí..."),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Cierra el diálogo sin enviar datos.
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: _sendText, // Llamada al método que maneja el envío de datos.
          child: Text('Enviar'),
        ),
      ],
    );
  }
}


class TextInputAddComment extends StatefulWidget {
  const TextInputAddComment({Key? key,}) : super(key: key);

  @override
  _TextInputAddCommentState createState() => _TextInputAddCommentState();
}

class _TextInputAddCommentState extends State<TextInputAddComment> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _sendText() {
    // Aquí puedes manejar el texto ingresado, por ejemplo, enviarlo a alguna API o algo similar.
    Navigator.of(context).pop(_textEditingController.text); // Cierra el diálogo y devuelve el texto.
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agrega comentario'),
      content: TextField(
        controller: _textEditingController,
        autofocus: true, // para que el teclado aparezca automáticamente
        decoration: const InputDecoration(hintText: "Ingrese su texto aquí..."),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Cierra el diálogo sin enviar datos.
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: _sendText, // Llamada al método que maneja el envío de datos.
          child: const Text('Enviar'),
        ),
      ],
    );
  }
}


class TextInputEditComment extends StatefulWidget {
  const TextInputEditComment({Key? key,}) : super(key: key);

  @override
  _TextInputEditCommentState createState() => _TextInputEditCommentState();
}

class _TextInputEditCommentState extends State<TextInputEditComment> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _sendText() {
    // Aquí puedes manejar el texto ingresado, por ejemplo, enviarlo a alguna API o algo similar.
    Navigator.of(context).pop(_textEditingController.text); // Cierra el diálogo y devuelve el texto.
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar comentario'),
      content: TextField(
        controller: _textEditingController,
        autofocus: true, // para que el teclado aparezca automáticamente
        decoration: const InputDecoration(hintText: "Ingrese su texto aquí..."),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Cierra el diálogo sin enviar datos.
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: _sendText, // Llamada al método que maneja el envío de datos.
          child: const Text('Enviar'),
        ),
      ],
    );
  }
}
