import 'package:actividad1c2/feature/publication/domain/publication.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:video_player/video_player.dart';


class Comment {
  final String username;
  final String userImageUrl;
  final String text;

  Comment({
    required this.username,
    required this.userImageUrl,
    required this.text,
  });
}


class PublicationWidget extends StatelessWidget {
  final Publication publication;

  const PublicationWidget({
    Key? key,
    required this.publication,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Puedes acceder a los campos de 'publication' y usarlos en tu interfaz de usuario.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        HeaderPublication(userName: publication.userName, userNickName: publication.userNickName),
        MainPublication(description: publication.description, urlFile: publication.urlFile, typeFile: publication.typeFile),
        _FooterPublication(), // Si _FooterPublication necesita datos, considera pasárselos como parámetros también.
      ],
    );
  }
}

class HeaderPublication extends StatelessWidget {
  final String userName;
  final String userNickName;

  const HeaderPublication({
    Key? key,
    required this.userName,
    required this.userNickName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, 
  
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration( // Quité const de aquí porque BoxDecoration no es constante.
          color: Color.fromARGB(255, 217, 217, 217),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      child: Row( // Quité const de aquí porque los hijos de este Row no son constantes.
        children: <Widget>[
          const CircleAvatar(
            // Suponiendo que obtienes una imagen de internet
            backgroundImage: NetworkImage(
                'https://yesno.wtf/assets/yes/10-271c872c91cd72c1e38e72d2f8eda676.gif'),
            radius: 25, // define el tamaño del CircleAvatar
          ),
          SizedBox(width: 10), // Para el espacio entre la imagen y los textos
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                userName, // Usamos la variable no constante aquí.
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16), // Hacer el texto más grande para el nombre de usuario
              ),
              Text(
                userNickName, // Usamos la variable no constante aquí.
                style: const TextStyle(
                    fontSize: 14), // Texto más pequeño para el nombre completo
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class MainPublication extends StatelessWidget {
  final String description;
  final String urlFile;
  final String typeFile;

  const MainPublication({
    Key? key,
    required this.description,
    required this.urlFile,
    required this.typeFile,
  }) : super(key: key);

  Widget _buildContentWidget(String type, String url) {
    // Aquí, en lugar de verificar todo el tipo de archivo, simplemente verificamos la categoría principal.
    if (type.contains('audio')) {
      // Si el tipo contiene la palabra 'audio', asumimos que es un archivo de audio.
      return _AudioBubble(audioUrl: url);
    } else if (type.contains('image')) {
      // Si el tipo contiene la palabra 'image', asumimos que es una imagen.
      return _ImageBubble(imageUrl: url);
    } else if (type.contains('video')) {
      // Si el tipo contiene la palabra 'video', asumimos que es un video.
      return _VideoBubble(videoUrl: url);
    } else {
      // Si no es ninguno de los tipos conocidos, puedes manejarlo adecuadamente, tal vez mostrando un mensaje de error o un contenedor vacío.
      return SizedBox.shrink(); // O puedes retornar un widget de error personalizado.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 217, 217, 217),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            description, // Utiliza la descripción proporcionada.
            style: TextStyle(
              // Añade tus estilos aquí
            ),
          ),
          const SizedBox(height: 10),
          // Usamos la función helper para construir el widget correcto basado en el tipo de archivo.
          _buildContentWidget(typeFile, urlFile),
        ],
      ),
    );
  }
}

class _FooterPublication extends StatelessWidget {
  const _FooterPublication({Key? key})
      : super(key: key);

  void _showCommentsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
           height: MediaQuery.of(context).size.height * 0.9,
           child: CommentsBottomSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          TextButton(
            onPressed: () => _showCommentsSheet(context), 
            child: const Text(
              'Comments',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageBubble extends StatelessWidget {
  final String imageUrl; // La variable que contendrá la URL pasada a este widget.

  // El constructor de tu widget, que pedirá la URL como un parámetro.
  const _ImageBubble({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Usamos MediaQuery para obtener el tamaño actual de la pantalla.
    final size = MediaQuery.of(context).size;

    return Container(
      // Aquí, queremos que el ancho sea el máximo disponible. 'double.infinity' hará que se ajuste al ancho del padre.
      width: double.infinity,
      // Puedes ajustar la altura según lo que consideres adecuado para tu diseño.
      height: size.width * 0.5625, // Esto es solo un ejemplo que mantiene una relación de aspecto de 16:9.
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          imageUrl,
          width: size.width * 0.9,
        height: 190,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Center(child: Text('No se pudo cargar la imagen.'));
          },
        ),
      ),
    );
  }
}


class _VideoBubble extends StatefulWidget {
  final String videoUrl;

  const _VideoBubble({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoBubbleState createState() => _VideoBubbleState();
}

class _VideoBubbleState extends State<_VideoBubble> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl); // Aquí ya no necesitas 'Uri.parse' porque 'network' toma una cadena.
    
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false, // No se reproducirá automáticamente el video al abrir
      looping: false, // El video no se repetirá automáticamente
      // Asegúrate de que el 'aspectRatio' esté correcto, puedes ajustarlo según tus necesidades
      aspectRatio: 16 / 9,
      // Otros parámetros pueden ser especificados aquí, como materialProgressColors, placeholder, etc.
    );

    _videoPlayerController.initialize().then((_) {
      // Cuando el video se inicialice, notifica a los widgets que necesitan reconstruirse.
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Usamos MediaQuery para obtener el tamaño actual de la pantalla.
    final size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: size.width * 0.9,  // Estableces el ancho que desees aquí
        height: 200,  // Y la altura aquí
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }
}


class _AudioBubble extends StatefulWidget {
  final String audioUrl;

  _AudioBubble({required this.audioUrl});

  @override
  _AudioBubbleState createState() => _AudioBubbleState();
}

class _AudioBubbleState extends State<_AudioBubble> {
  late FlutterSoundPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = FlutterSoundPlayer();

    // Es importante inicializar el reproductor de sonido.
    _audioPlayer.openPlayer().then((value) {
      setState(() {
        // Podemos comenzar a reproducir audios.
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.closePlayer();
    _audioPlayer.dispositionStream();
    super.dispose();
  }

  Future<void> _playPauseAudio() async {
    if (_isPlaying) {
      await _audioPlayer.stopPlayer();
    } else {
      await _audioPlayer.startPlayer(
          fromURI: widget.audioUrl,
          codec: Codec.aacADTS // Asegúrate de usar el códec correcto para tu archivo de audio.
      );
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Esto hace que el contenedor ocupe todo el ancho disponible.
      width: double.infinity,
      // Agrega los estilos que prefieras para tu contenedor aquí (por ejemplo, padding, color, bordes, etc.)
      decoration: BoxDecoration(
        color: Colors.grey[300], // Solo un color de ejemplo
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row( // Usamos Row para tener icono y algún texto o elemento visual adicional, si se desea.
        mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido en el contenedor.
        children: [
          IconButton(
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () async {
              await _playPauseAudio();
            },
          ),
          // Puedes agregar más elementos a tu diseño aquí. Por ejemplo, texto que indica el estado de reproducción.
        ],
      ),
    );
  }
 
}

class CommentsBottomSheet extends StatelessWidget {
  // Lista de comentarios con más detalles. Esto normalmente vendría de una base de datos.
  final List<Comment> comments = [
    Comment(username: 'Usuario1', userImageUrl: 'https://assetsio.reedpopcdn.com/halo-infinite-analisis-1638743381631.jpg?width=1920&height=1920&fit=bounds&quality=80&format=jpg&auto=webp', text: '¡Gran publicación!'),
    // ... otros comentarios ...
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comentarios',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return CommentCard(comment: comments[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final Comment comment;

  CommentCard({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Aquí podrías usar un widget como NetworkImage para obtener la imagen desde una URL.
                // Por ahora, solo usaremos un contenedor como marcador de posición.
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(comment.userImageUrl), // imagen desde URL
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(comment.username, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 10),
            Text(comment.text),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // Lógica para editar
                  },
                  child: Text('Editar'),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    // Lógica para eliminar
                  },
                  child: Text('Eliminar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

