import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:metronome/blocs/login/login_event.dart';
import 'package:metronome/blocs/login/login_state.dart';
import 'package:metronome/resources/repository.dart';
import 'package:metronome/resources/form_validators.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Repository _repository;

  LoginBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginPressed) {
      yield* _mapLoginPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapEmailChangedToState(
    String email,
  ) async* {
    yield currentState.update(
      isEmailValid: FormValidators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(
    String password,
  ) async* {
    yield currentState.update(
      isPasswordValid: FormValidators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    try {
      await _repository.signIn(
        email,
        password,
      );
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
