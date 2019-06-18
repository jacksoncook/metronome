import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}

class NameChanged extends RegisterEvent {
  final String name;

  NameChanged({@required this.name}) : super([name]);

  @override
  String toString() => 'NameChanged { name:$name }';
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;
  final String retypePassword;

  PasswordChanged({
    @required this.password,
    @required this.retypePassword,
  }) : super([
          password,
          retypePassword,
        ]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class RetypePasswordChanged extends RegisterEvent {
  final String password;
  final String retypePassword;

  RetypePasswordChanged({
    @required this.password,
    @required this.retypePassword,
  }) : super([
          password,
          retypePassword,
        ]);

  @override
  String toString() => 'PasswordChanged { password: $retypePassword }';
}

class Submitted extends RegisterEvent {
  final String name;
  final String email;
  final String password;

  Submitted({
    @required this.name,
    @required this.email,
    @required this.password,
  }) : super([
          email,
          password,
        ]);

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }
}
