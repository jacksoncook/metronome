import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metronome/resources/repository.dart';
import 'package:metronome/blocs/login/login_bloc.dart';
import 'package:metronome/ui/login/LoginForm.dart';

class LoginScreen extends StatefulWidget {
  final Repository _repository;

  LoginScreen({
    Key key,
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository,
        super(key: key);

  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;

  Repository get _repository => widget._repository;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(
      repository: _repository,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Center(
            child: BlocProvider<LoginBloc>(
          bloc: _loginBloc,
          child: LoginForm(repository: _repository),
        )));
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
