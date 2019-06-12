import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState {}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Unitialized';
}

class Authenticated extends AuthenticationState {
  @override
  String toString() => 'Authenticated';
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}
