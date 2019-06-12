import 'package:flutter/material.dart';
import 'package:metronome/resources/auth.dart';
import 'package:metronome/ui/register/RegisterScreen.dart';

class CreateAccountButton extends StatelessWidget {
  final Auth _auth;

  CreateAccountButton({Key key, @required Auth auth})
      : assert(auth != null),
        _auth = auth,
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
            return RegisterScreen(auth: _auth);
          }),
        );
      },
    );
  }
}
