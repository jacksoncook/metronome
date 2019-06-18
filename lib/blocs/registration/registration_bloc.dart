import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:metronome/resources/repository.dart';
import 'package:metronome/blocs/registration/registration_event.dart';
import 'package:metronome/blocs/registration/registration_state.dart';
import 'package:metronome/resources/form_validators.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final Repository _repository;

  RegisterBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(
      isEmailValid: FormValidators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid: FormValidators.isValidPassword(password),
    );
  }

  // Performs registration action
  // TODO: Currently, if registration with FirebaseAuth works
  // but the load to Cloud Firestore fails, this method introduces
  // a situation where a user would be registered with FirebaseAuth
  // but does not have a user account in Cloud Firestore
  Stream<RegisterState> _mapFormSubmittedToState(
    String email,
    String password,
  ) async* {
    yield RegisterState.loading();
    try {
      await _repository.register(
        email,
        password,
      );
      // await _repository.createUser(
      //   email,
      //   'Steve',
      // );
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
