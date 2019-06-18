import 'package:bloc/bloc.dart';
import 'package:metronome/blocs/authentication/authentication_event.dart';
import 'package:metronome/blocs/authentication/authentication_state.dart';
import 'package:metronome/resources/repository.dart';
import 'package:meta/meta.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Repository _repository;

  AuthenticationBloc({@required Repository repository})
      : assert(repository != null),
        _repository = repository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _repository.isSignedIn();
      if (isSignedIn) {
        yield Authenticated();
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated();
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _repository.signOut();
  }
}
