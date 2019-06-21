import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metronome/resources/repository.dart';
import 'package:metronome/blocs/authentication/authentication_bloc.dart';
import 'package:metronome/blocs/authentication/authentication_event.dart';
import 'package:metronome/blocs/authentication/authentication_state.dart';
import 'package:metronome/ui/MyHomePage.dart';
import 'package:metronome/ui/WelcomeScreen.dart';
import 'package:metronome/ui/beat_creation/BeatCreationScreen.dart';
import 'package:metronome/ui/login/LoginScreen.dart';

class Metronome extends StatefulWidget {
  State<Metronome> createState() => _AppState();
}

class _AppState extends State<Metronome> {
  final Repository _repository = Repository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(repository: _repository);
    _authenticationBloc.dispatch(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _authenticationBloc,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            print(state);
            if (state is Uninitialized) {
              return WelcomeScreen();
            }
            if (state is Unauthenticated) {
              return LoginScreen(repository: _repository);
            }
            if (state is Authenticated) {
              return BeatCreationScreen(repository: _repository);
            }
            // Default to login screen if they not in something
            return LoginScreen(repository: _repository);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }
}
