import 'package:actividad1c2/feature/publication/data/publication_api_data_source.dart';
import 'package:actividad1c2/feature/publication/domain/publication.dart';
import 'package:actividad1c2/feature/publication/presentation/custom_widgets/card_publication.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'custom_widgets/input.dart'; // Make sure the path is correct

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff222222),
        title: const PreferredSize(
          preferredSize: Size.fromHeight(60), // Define a height
          child: Center(child: MessageFieldBox()), // Center your input field
        ),
      ),
      body: ChatView(),
      // ... rest of your Scaffold
    );
  }
}

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late Future<List<Publication>> futurePublications; // Asume que `Publication` es la clase de tus publicaciones.

  @override
  void initState() {
    super.initState();
    futurePublications = PublicationApiDataSourceImp()
        .listPublication(); // Llama a tu método aquí.
  }

  @override
  Widget build(BuildContext context) {
    print("hola como ando");
    print(futurePublications);
    return SafeArea(
      child: Container(
        color: Color(0xff222222),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Publication>>(
                future: futurePublications,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(
                          color:
                              Colors.white, 
                        ),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No hay publicaciones disponibles.',
                        style: TextStyle(
                          color:
                              Colors.white,
                      ),
                    ));
                  } else {
                    // Your existing code for handling the case where there is valid data

                    // Accede a la lista de publicaciones
                    List<Publication> publications = snapshot.data!;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        itemCount: publications.length, // La cantidad de publicaciones.
                        itemBuilder: (context, index) {
                         
                          Publication publication = publications[index]; // La publicación actual.

                          // Aquí es donde pasas la 'publication' completa al widget.
                          return PublicationWidget(
                              publication:
                                  publication); // Se ha corregido para pasar el objeto completo.
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            Navbar(), // Asegúrate de que Navbar se está implementando correctamente en otro lugar en tu código.
          ],
        ),
      ),
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
      height: 60, // Ajusta esto según sea necesario para tu diseño
      decoration: BoxDecoration(
          color: Color.fromARGB(
              255, 34, 34, 34)), // Opcional: para darle color de fondo
      child: const GNav(
        // gap: 8,  // Espaciado entre icono y texto, si tienes texto
        // colorActive: Colors.purple,  // Color de ícono activo
        // textStyle: TextStyle(fontSize: 16, color: Colors.purple), // Estilo de texto, si tienes texto
        iconSize: 24, // Aquí aumentamos el tamaño del icono
        padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5), // Ajustando el relleno alrededor de los botones
        duration: Duration(milliseconds: 800), // Duración de la animación
        tabs: [
          GButton(
            icon: Icons.publish,
            // text: 'Publish',  // Si tienes texto para mostrar
            iconColor: Colors.white, // Color del icono
            iconSize: 32, // Ajusta el tamaño del icono más grande aquí
            // backgroundColor: Colors.purple,  // Color de fondo cuando está seleccionado, si se necesita
          ),
          GButton(
            icon: Icons.home,
            // text: 'Home',
            iconColor: Colors.white,
            iconSize: 32, // Aumenta el tamaño como prefieras
          ),
          GButton(
            icon: Icons.person,
            // text: 'Profile',
            iconColor: Colors.white,
            iconSize: 32, // Aumenta el tamaño como prefieras
          ),
        ],
        // onTabChange: (index) {  // Callback para responder a cambios de pestaña
        //   // código para manejar el cambio de pestaña
        // }
      ),
    );
  }
}
