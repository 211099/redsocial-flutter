import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        color: Color.fromARGB(255, 217, 217, 217),
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
      : super(
            key:
                key); // Corregido aquí para pasar correctamente la clave al super

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
            onPressed: () {},
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
