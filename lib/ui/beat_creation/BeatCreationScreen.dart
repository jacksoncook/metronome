import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metronome/resources/repository.dart';
import 'package:metronome/blocs/beat_creation/beat_creation_bloc.dart';
import 'package:metronome/blocs/beat_creation/beat_creation_state.dart';
import 'package:metronome/blocs/beat_creation/beat_creation_event.dart';
import 'package:metronome/blocs/authentication/authentication_event.dart';
import 'package:metronome/blocs/authentication/authentication_bloc.dart';

import 'BeatCreationFormContainer.dart';

class BeatCreationScreen extends StatefulWidget {
  final Repository _repository;

  BeatCreationScreen({
    Key key,
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository,
        super(key: key);

  State<BeatCreationScreen> createState() => _BeatCreationScreenState();
}

class _BeatCreationScreenState extends State<BeatCreationScreen> {
  BeatCreationBloc _beatCreationBloc;

  Repository get _repository => widget._repository;

  @override
  void initState() {
    super.initState();
    _beatCreationBloc = BeatCreationBloc(
      repository: _repository,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('metri.beat'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).dispatch(
                LoggedOut(),
              );
            },
          )
        ],
      ),
      body: BlocBuilder(
          bloc: _beatCreationBloc,
          builder: (BuildContext context, BeatCreationState state) {
            return Container(
                child: BlocProvider<BeatCreationBloc>(
              bloc: _beatCreationBloc,
              child: BeatCreationFormContainer(beatName: state.beat.beatName),
            ));
          }),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _beatCreationBloc.dispatch(BeatFragmentAdded());
      }),
    );
  }

  @override
  void dispose() {
    _beatCreationBloc.dispose();
    super.dispose();
  }
}
