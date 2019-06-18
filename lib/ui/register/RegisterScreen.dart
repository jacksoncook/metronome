import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metronome/resources/repository.dart';
import 'package:metronome/blocs/registration/registration_bloc.dart';
import 'package:metronome/ui/register/RegisterForm.dart';

class RegisterScreen extends StatefulWidget {
  final Repository _repository;

  RegisterScreen({
    Key key,
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository,
        super(key: key);

  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc(
      repository: widget._repository,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          bloc: _registerBloc,
          child: RegisterForm(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _registerBloc.dispose();
    super.dispose();
  }
}
