import 'package:flutter/material.dart';
import 'package:actividad1c2/feature/user/presentation/pages/login.dart';
import 'package:actividad1c2/feature/user/presentation/pages/register.dart';
import 'package:actividad1c2/feature/user/presentation/pages/restore_pasword.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/user/presentation/blocks/register/register_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => RegisterBloc(), // Crea una instancia del Bloc de registro
        child: Login(), // Página de inicio de sesión
      ),
    );
  }
}
