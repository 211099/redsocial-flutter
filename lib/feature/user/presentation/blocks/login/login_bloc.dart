import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/login_user_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final BuildContext context;
  final LogInUserUseCase logInUserUseCase;


  Future<bool> login(String email, String password) async{
    try{
      print("entre");
      await(logInUserUseCase.execute(email, password));
      return true;
    }catch(e){
      emit(LoginError(error: e.toString()));
      return false;
    }
  }
  LoginBloc({required this.context, required this.logInUserUseCase}): super(IniciarSesionInitial()) {
    on<LoginEvent>((event, emit) async {
      if(event is onIniciar){

      }
    });
  }
}

