
import 'package:actividad1c2/feature/publication/presentation/home.dart';
import 'package:actividad1c2/feature/publication/presentation/publication.dart';
import 'package:flutter/material.dart';





void main() => runApp(const MyApp());




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Home()
    );
  }
}
