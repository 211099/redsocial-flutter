import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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


class publication extends StatelessWidget {
  const publication({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        HeaderPublication(),
        // Post body (Row 2)
        MainPublication(),
        // Reactions and comments (Row 3)
        _FooterPublication(),
      ],
    );
  }
}

class HeaderPublication extends StatelessWidget {
  const HeaderPublication({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, // or another height that fits well
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 217, 217, 217),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      child: const Row(
        children: <Widget>[
          CircleAvatar(
            // Assuming you're getting an image from the internet
            backgroundImage: NetworkImage(
                'https://yesno.wtf/assets/yes/10-271c872c91cd72c1e38e72d2f8eda676.gif'),
            radius: 25, // defines the size of the CircleAvatar
          ),
          SizedBox(width: 10), // For spacing between the image and the texts
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'UserNickname',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16), // Make text bigger for the nickname
              ),
              Text(
                'User Full Name',
                style:
                    TextStyle(fontSize: 14), // Smaller text for the full name
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MainPublication extends StatelessWidget {
    const MainPublication({
    Key? key,
    // required this.mediaUrl,
    // required this.type,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final String? mediaUrl; // URL para la imagen o el audio, dependiendo del tipo.
    final int type;

    return Container(
        color: const Color.fromARGB(255, 217, 217, 217),
        // No specified height - it will expand with content
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'This is the body of the post. It might have text, images, or even GIFs. The size of this container changes dynamically based on the content.asdasdasdasdaskldalskjdlkajsdklajsldkjalksdjlaksjdlkjaslkdjlkajsdlkjalskjdlkajsdlkjaslkdjlaksjdlkasjlkdjlaksjdlkajkdlal',
            ),
            const SizedBox(height: 10),
            _imageBuble()
          ],
        ));
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


class CommentsBottomSheet extends StatelessWidget {
  // Lista de comentarios con más detalles. Esto normalmente vendría de una base de datos.
  final List<Comment> comments = [
    // Agrega tus comentarios aquí con el modelo Comment
    Comment(username: 'Usuario1', userImageUrl: 'https://assetsio.reedpopcdn.com/halo-infinite-analisis-1638743381631.jpg?width=1920&height=1920&fit=bounds&quality=80&format=jpg&auto=webp', text: '¡Gran publicación! ljkdnfalksjdfkjlahsdfjkhasjkdhfkhsadkjfhaksjdhfkjlashdkfjhaskljdhfkljashdfkjlhsakdjfhkjsahdfkljahsdkjlfhaskljdhfkljsadhfkljshdakljfhaskljfhasjkl'),
    Comment(username: 'Usuario1', userImageUrl: 'https://assetsio.reedpopcdn.com/halo-infinite-analisis-1638743381631.jpg?width=1920&height=1920&fit=bounds&quality=80&format=jpg&auto=webp', text: '¡Gran publicación!'),
    Comment(username: 'Usuario1', userImageUrl: 'https://assetsio.reedpopcdn.com/halo-infinite-analisis-1638743381631.jpg?width=1920&height=1920&fit=bounds&quality=80&format=jpg&auto=webp', text: '¡Gran publicación!'),
    Comment(username: 'Usuario1', userImageUrl: 'https://assetsio.reedpopcdn.com/halo-infinite-analisis-1638743381631.jpg?width=1920&height=1920&fit=bounds&quality=80&format=jpg&auto=webp', text: '¡Gran publicación!'),
    Comment(username: 'Usuario1', userImageUrl: 'https://assetsio.reedpopcdn.com/halo-infinite-analisis-1638743381631.jpg?width=1920&height=1920&fit=bounds&quality=80&format=jpg&auto=webp', text: '¡Gran publicación!'),
    Comment(username: 'Usuario1', userImageUrl: 'https://assetsio.reedpopcdn.com/halo-infinite-analisis-1638743381631.jpg?width=1920&height=1920&fit=bounds&quality=80&format=jpg&auto=webp', text: '¡Gran publicación!'),
    Comment(username: 'Usuario1', userImageUrl: 'https://assetsio.reedpopcdn.com/halo-infinite-analisis-1638743381631.jpg?width=1920&height=1920&fit=bounds&quality=80&format=jpg&auto=webp', text: '¡Gran publicación!'),
    Comment(username: 'Usuario1', userImageUrl: 'https://assetsio.reedpopcdn.com/halo-infinite-analisis-1638743381631.jpg?width=1920&height=1920&fit=bounds&quality=80&format=jpg&auto=webp', text: '¡Gran publicación!'),
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



class _imageBuble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          "https://yesno.wtf/assets/yes/10-271c872c91cd72c1e38e72d2f8eda676.gif",
          width: size.width * 0.9,
          height: 190,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Container(
              width: size.width * 0.7,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: const Text("cargando imagen..."),
            );
          },
        ));
  }
}
