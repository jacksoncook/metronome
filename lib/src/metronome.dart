import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metronome/resources/auth.dart';
import 'package:metronome/blocs/authentication/authentication_bloc.dart';
import 'package:metronome/blocs/authentication/authentication_event.dart';
import 'package:metronome/blocs/authentication/authentication_state.dart';
import 'package:metronome/ui/MyHomePage.dart';
import 'package:metronome/ui/WelcomeScreen.dart';
import 'package:metronome/ui/login/LoginScreen.dart';

class Metronome extends StatefulWidget {
  State<Metronome> createState() => _AppState();
}

class _AppState extends State<Metronome> {
  final Auth _auth = Auth();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(auth: _auth);
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
              return LoginScreen(auth: _auth);
            }
            if (state is Authenticated) {
              return MyHomePage(title: 'Flutter Demo Home Page');
            }
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
