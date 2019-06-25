import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metronome/blocs/beat_creation/beat_creation_bloc.dart';
import 'package:metronome/blocs/beat_creation/beat_creation_event.dart';
import 'package:metronome/blocs/beat_creation/beat_creation_state.dart';
import 'package:metronome/models/models.dart';
import 'package:metronome/ui/beat_creation/BeatCreationForm.dart';
import 'package:metronome/ui/beat_creation/BeatCreationButton.dart';

class BeatCreationFormContainer extends StatefulWidget {
  final String _beatName;

  BeatCreationFormContainer({
    Key key,
    @required String beatName,
  })  : assert(beatName != null),
        _beatName = beatName,
        super(key: key);

  State<BeatCreationFormContainer> createState() =>
      _BeatCreationFormContainerState();
}

class _BeatCreationFormContainerState extends State<BeatCreationFormContainer> {
  TextEditingController _beatNameController;

  BeatCreationBloc _beatCreationBloc;

  String get _beatName => widget._beatName;

  @override
  void initState() {
    super.initState();
    _beatCreationBloc = BlocProvider.of<BeatCreationBloc>(context);
    _beatNameController = TextEditingController(text: _beatName);
    _beatNameController.addListener(_onBeatNameChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _beatCreationBloc,
        builder: (BuildContext context, BeatCreationState state) {
          return Container(
              child: BlocProvider<BeatCreationBloc>(
            bloc: _beatCreationBloc,
            child: ListView(shrinkWrap: true, children: <Widget>[
              TextFormField(
                  controller: _beatNameController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Beat Name',
                  )),
              ListView.builder(
                  shrinkWrap: true,
                  physics: PageScrollPhysics(),
                  itemCount: state.beat.beatFragments.length,
                  itemBuilder: (BuildContext context, int index) {
                    final BeatFragment beatFragment =
                        state.beat.beatFragments[index];
                    return beatFragment != null
                        ? Dismissible(
                            key: ObjectKey(beatFragment),
                            onDismissed: (direction) {
                              _onDeleteBeat(index);
                            },
                            child: BeatCreationForm(
                              beatFragment: state.beat.beatFragments[index],
                              index: index,
                            ),
                            background: Container(color: Colors.red),
                          )
                        : null;
                  }),
              BeatCreationButton(
                onPressed: _onUploadBeat,
              ),
            ]),
          ));
        },
      ),
    );
  }

  @override
  void dispose() {
    _beatNameController.dispose();
    super.dispose();
  }

  void _onUploadBeat() {
    _beatCreationBloc.dispatch(
      UploadBeatPressed(),
    );
  }

  void _onDeleteBeat(int index) {
    _beatCreationBloc.dispatch(
      BeatFragmentDeleted(
        index: index,
      ),
    );
  }

  void _onBeatNameChanged() {
    _beatCreationBloc.dispatch(
      BeatNameChanged(
        beatName: _beatNameController.text,
      ),
    );
  }
}
