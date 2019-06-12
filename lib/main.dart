import 'package:flutter/material.dart';
import 'package:metronome/resources/my_bloc_delegate.dart';
import 'package:metronome/src/metronome.dart';
import 'package:bloc/bloc.dart';

void main() {
  BlocSupervisor.delegate = MyBlocDelegate();
  runApp(Metronome());
}
