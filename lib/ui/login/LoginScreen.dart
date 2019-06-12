import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metronome/resources/auth.dart';
import 'package:metronome/blocs/login/login_bloc.dart';
import 'package:metronome/ui/login/LoginForm.dart';

class LoginScreen extends StatefulWidget {
  final Auth _auth;

  LoginScreen({Key key, @required Auth auth})
      : assert(auth != null),
        _auth = auth,
        super(key: key);

  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;

  Auth get _auth => widget._auth;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(
      auth: _auth,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Center(
            child: BlocProvider<LoginBloc>(
          bloc: _loginBloc,
          child: LoginForm(auth: _auth),
        )));
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
