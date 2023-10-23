import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';



class PublicationScreen extends StatelessWidget {
  const PublicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 53, 53, 53), // Color de fondo del body
      appBar: AppBar(
        backgroundColor: Color(0xff222222),
      ),
      body: SafeArea(
        child: Center(
          child: CustomCard(),
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}

class CustomCard extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CardHeader(),
            _CardBody(controller: _controller),
            CardFooter(controller: _controller),
          ],
        ),
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 217, 217, 217),
        child: Icon(Icons.person, color: Colors.grey[700]),
      ),
      title: Text('Coffe'),
      subtitle: Text('Luis Antonio Martinez Marroquin'),
    );
  }
}

class _CardBody extends StatelessWidget {
  final TextEditingController controller;

  _CardBody({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: 'Escribe tu mensaje aquí...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}


class CardFooter extends StatefulWidget {
  final TextEditingController controller;

  CardFooter({required this.controller});

  @override
  _CardFooterState createState() => _CardFooterState();
}

class _CardFooterState extends State<CardFooter> {
  File? selectedFile; // Este puede ser tu archivo de imagen, video o audio.
  int? typeFile = null; // 0 para imagen, 1 para video, 2 para audio, null si no hay archivo.

  // Los métodos _pickImage y _pickVideo se mantienen igual.
  // Método para procesar la selección de imagen.
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedFile = File(pickedFile.path);
      typeFile = 0; // Definir como una imagen.
    } else {
      print('No se seleccionó ninguna imagen.');
      selectedFile = null;
      typeFile = null;
    }
     setState(() {
    if (pickedFile != null) {
      selectedFile = File(pickedFile.path);
      typeFile = 0; // Imagen seleccionada.
    } else {
      selectedFile = null;
      typeFile = null; // Ningún archivo seleccionado.
    }
  });
  }

  // Método para procesar la selección de video.
  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedFile = File(pickedFile.path);
      typeFile = 1; // Definir como un video.
    } else {
      print('No se seleccionó ningún video.');
      selectedFile = null;
      typeFile = null;
    }
      setState(() {
    if (pickedFile != null) {
      selectedFile = File(pickedFile.path);
      typeFile = 1; // Video seleccionado.
    } else {
      selectedFile = null;
      typeFile = null; // Ningún archivo seleccionado.
    }
  });
  }

  void _handleRecordedAudio(String filePath) {
    setState(() {
      selectedFile = File(filePath); // Establecer el archivo de audio.
      typeFile = 2; // Definir como un audio.
    });
  }

  void _sendInformation() {
    // El mismo método para enviar o procesar la información.
    print(widget.controller.text);
    if (selectedFile != null && typeFile != null) {
      // Se imprime la información correspondiente según el tipo de archivo.
      print('Archivo seleccionado: ${selectedFile!.path}, Tipo de archivo: ${typeFile == 0 ? 'Imagen' : typeFile == 1 ? 'Video' : 'Audio'}');
    } else {
      print('No hay un archivo seleccionado.');
    }
  }

 @override
Widget build(BuildContext context) {
  Color getColor(int fileType) {
    if (typeFile == fileType) {
      return Colors.green; // El color para indicar que el tipo de archivo ha sido seleccionado.
    } else {
      return Colors.black; // El color predeterminado.
    }
  }

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(Icons.image, size: 28),
          onPressed: _pickImage, // Tu función existente.
          color: getColor(0), // Color basado en el estado.
        ),
        RecordButton(
          onSaved: _handleRecordedAudio, // Tu función existente.
          color: getColor(2), // Añade color aquí, pero necesitarás modificar la clase RecordButton para aceptar el valor de color también.
        ),
        IconButton(
          icon: const Icon(Icons.videocam, size: 28),
          onPressed: _pickVideo, // Tu función existente.
          color: getColor(1), // Color basado en el estado.
        ),
        IconButton(
          icon: const Icon(Icons.send, size: 28),
          onPressed: _sendInformation, // Tu función existente.
          color: Colors.black, // Este podría permanecer igual ya que no cambia.
        ),
      ],
    ),
  );
}

}

class RecordButton extends StatefulWidget {
  final ValueChanged<String> onSaved; // Callback que recibe la ruta del archivo grabado.
  final Color color; // Nuevo: un parámetro para el color del ícono.

  // Modifica el constructor para que requiera este nuevo parámetro.
  RecordButton({
    required this.onSaved, 
    this.color = Colors.black, // Puedes dar un color predeterminado.
  });

  @override
  _RecordButtonState createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  bool isRecording = false; // Estado de la grabación.
  FlutterSoundRecorder? _recorder; // El grabador.
  String? _recordedFilePath; // Ruta del archivo grabado.

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    try {
      await _recorder!.openRecorder(); // Abre la sesión del grabador.
    } catch (e) {
      print("Hubo un error al inicializar el grabador: $e");
    }
  }

  void _startRecording() async {
    var status = await Permission.microphone.request();

    if (status.isGranted) {
      try {
        final dir = await getApplicationDocumentsDirectory();
        _recordedFilePath = '${dir.path}/myRecording.aac';

        await _recorder!.startRecorder(
          toFile: _recordedFilePath,
          codec: Codec.aacADTS,
        );

        setState(() {
          isRecording = true;
        });

      } catch (e) {
        print("No se pudo iniciar la grabación: $e");
      }
    } else {
      print("Permiso de micrófono denegado.");
    }
  }

  void _stopRecording() async {
    try {
      await _recorder!.stopRecorder(); // Detiene la grabación.
      setState(() {
        isRecording = false;
      });

      if (_recordedFilePath != null) {
        widget.onSaved(_recordedFilePath!); // Notifica al widget padre mediante el callback.
      }
    } catch (e) {
      print("No se pudo detener la grabación: $e");
    }
  }

  @override
  void dispose() {
    // No olvides deshacerte de los recursos cuando ya no sean necesarios.
    _recorder?.closeRecorder();
    _recorder = null;
    super.dispose();
  }

 @override
Widget build(BuildContext context) {
  // Usando el color pasado al widget RecordButton para el ícono.
  return IconButton(
    icon: Icon(isRecording ? Icons.stop : Icons.mic, color: widget.color),
    onPressed: () {
      if (isRecording) {
        _stopRecording();
      } else {
        _startRecording();
      }
    },
  );
}
}




class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 34, 34, 34)),
      child: const GNav(
        iconSize: 24,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        duration: Duration(milliseconds: 800),
        tabs: [
          GButton(
            icon: Icons.publish,
            iconColor: Colors.white,
            iconSize: 32,
          ),
          GButton(
            icon: Icons.home,
            iconColor: Colors.white,
            iconSize: 32,
          ),
          GButton(
            icon: Icons.person,
            iconColor: Colors.white,
            iconSize: 32,
          ),
        ],
      ),
    );
  }
}

