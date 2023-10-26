import 'package:actividad1c2/feature/publication/presentation/publication.dart';
import 'package:flutter/material.dart';
import 'package:actividad1c2/feature/publication/data/publication_api_data_source.dart';
import 'package:actividad1c2/feature/publication/domain/publication.dart';
import 'package:actividad1c2/feature/publication/presentation/custom_widgets/card_publication.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'custom_widgets/input.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Publication>> futurePublications;

  @override
  void initState() {
    super.initState();
    futurePublications = PublicationApiDataSourceImp().listPublication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff222222),
        title: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Center(child: MessageFieldBox()),
        ),
      ),
      body: ChatView(),
    );
  }
}

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late Future<List<Publication>> futurePublications;

  @override
  void initState() {
    super.initState();
    futurePublications = PublicationApiDataSourceImp().listPublication();
  }

  @override
  Widget build(BuildContext context) {
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
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text(
                      'No hay publicaciones disponibles.',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ));
                  } else {
                    List<Publication> publications = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        itemCount: publications.length,
                        itemBuilder: (context, index) {
                          Publication publication = publications[index];
                          return PublicationWidget(publication: publication);
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            Navbar(),
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
      height: 60,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 34, 34, 34),
      ),
      child: GNav(
        iconSize: 32,
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
        ],
        onTabChange: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PublicationScreen()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
              break;
          }
        },
      ),
    );
  }
}
