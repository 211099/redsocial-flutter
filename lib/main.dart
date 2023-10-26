import 'package:actividad1c2/feature/publication/presentation/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:actividad1c2/feature/user/presentation/blocks/login/login_bloc.dart';
import 'package:actividad1c2/feature/user/presentation/blocks/register/register_user_bloc.dart'; // Asegúrate de importar el RegisterUserBloc
import 'feature/user/presentation/pages/login.dart';
import 'feature/user/presentation/pages/new_password.dart';
import 'feature/user/presentation/pages/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(context: context),
        ),
        BlocProvider<RegisterUserBloc>(
          create: (context) => RegisterUserBloc(context: context),
        ),
        // Otros Blocs
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {
          // ------------------Controla todo -------------------------------
          '/login': (context) => BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(context: context),
                child: Login(),
              ),
          // ------------------- Controla todo------------------------------
          '/register': (context) => Register(),
          //'/NewPassword': (context) => NewPassword(),
          '/new_password': (context) => NewPassword(),
          '/Home': (context) => Home(),
        },
      ),
    );
  }
}
