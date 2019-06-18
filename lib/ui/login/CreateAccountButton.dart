import 'package:flutter/material.dart';
import 'package:metronome/resources/repository.dart';
import 'package:metronome/ui/register/RegisterScreen.dart';

class CreateAccountButton extends StatelessWidget {
  final Repository _repository;

  CreateAccountButton({
    Key key,
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Create an Account',
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterScreen(
              repository: _repository,
            );
          }),
        );
      },
    );
  }
}
