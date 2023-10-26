import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'restore_password_event.dart';
part 'restore_password_state.dart';

class RestorePasswordBloc extends Bloc<RestorePasswordEvent, RestorePasswordState> {
  RestorePasswordBloc() : super(RestorePasswordInitial()) {
    on<RestorePasswordEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
