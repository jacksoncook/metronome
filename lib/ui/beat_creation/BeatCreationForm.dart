import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metronome/blocs/beat_creation/beat_creation_bloc.dart';
import 'package:metronome/blocs/beat_creation/beat_creation_event.dart';
import 'package:metronome/blocs/beat_creation/beat_creation_state.dart';
import 'package:metronome/models/models.dart';

class BeatCreationForm extends StatefulWidget {
  final BeatFragment _beatFragment;
  final int _index;

  BeatCreationForm({
    Key key,
    @required BeatFragment beatFragment,
    @required int index,
  })  : assert(beatFragment != null),
        _beatFragment = beatFragment,
        _index = index,
        super(key: key);

  State<BeatCreationForm> createState() => _BeatCreationFormState();
}

class _BeatCreationFormState extends State<BeatCreationForm> {
  TextEditingController _bpmController;
  TextEditingController _measuresController;
  TextEditingController _timeSignatureController;
  TextEditingController _endingTypeController;
  Subdivision _selectedSubdivision;
  double _currentVolume;

  BeatCreationBloc _beatCreationBloc;

  BeatFragment get _beatFragment => widget._beatFragment;
  int get _index => widget._index;

  @override
  void initState() {
    super.initState();
    _selectedSubdivision = Subdivision.Accent;
    _currentVolume = _beatFragment.getVolume(_selectedSubdivision);
    _beatCreationBloc = BlocProvider.of<BeatCreationBloc>(context);
    _bpmController = TextEditingController(text: _beatFragment.bpm.toString());
    _bpmController.addListener(_onBpmChanged);
    _measuresController =
        TextEditingController(text: _beatFragment.measures.toString());
    _measuresController.addListener(_onMeasuresChanged);
    _timeSignatureController =
        TextEditingController(text: _beatFragment.timeSignature);
    _timeSignatureController.addListener(_onTimeSignatureChanged);
    _endingTypeController =
        TextEditingController(text: _beatFragment.endingType);
    _endingTypeController.addListener(_onEndingTypeChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _beatCreationBloc,
      builder: (BuildContext context, BeatCreationState state) {
        return Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                TextFormField(
                  controller: _bpmController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'BPM',
                  ),
                  keyboardType: TextInputType.number,
                  autovalidate: true,
                  autocorrect: false,
                ),
                TextFormField(
                  controller: _measuresController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Measures',
                  ),
                  keyboardType: TextInputType.number,
                  autovalidate: true,
                  autocorrect: false,
                ),
                TextFormField(
                  controller: _timeSignatureController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Time Signature',
                  ),
                  autovalidate: true,
                  autocorrect: false,
                ),
                TextFormField(
                  controller: _endingTypeController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Ending Type',
                  ),
                  autovalidate: true,
                  autocorrect: false,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: Subdivision.Accent,
                      groupValue: _selectedSubdivision,
                      onChanged: _onSubdivisionChanged,
                    ),
                    Radio(
                      value: Subdivision.Quarter,
                      groupValue: _selectedSubdivision,
                      onChanged: _onSubdivisionChanged,
                    ),
                    Radio(
                      value: Subdivision.Eighth,
                      groupValue: _selectedSubdivision,
                      onChanged: _onSubdivisionChanged,
                    ),
                    Radio(
                      value: Subdivision.Sixteenth,
                      groupValue: _selectedSubdivision,
                      onChanged: _onSubdivisionChanged,
                    ),
                    Radio(
                      value: Subdivision.Triplet,
                      groupValue: _selectedSubdivision,
                      onChanged: _onSubdivisionChanged,
                    ),
                  ],
                ),
                Slider(
                  min: 0.0,
                  max: 1.0,
                  activeColor: Colors.purple,
                  inactiveColor: Colors.purple.withOpacity(0.6),
                  label: "Volume",
                  value: _currentVolume,
                  onChanged: _onSubdivisionVolumeChange,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _bpmController.dispose();
    _measuresController.dispose();
    _timeSignatureController.dispose();
    _endingTypeController.dispose();
    super.dispose();
  }

  void _onSubdivisionChanged(Subdivision subdivision) {
    setState(() {
      _selectedSubdivision = subdivision;
      _currentVolume = _beatFragment.getVolume(_selectedSubdivision);
    });
  }

  void _onSubdivisionVolumeChange(double newValue) {
    _currentVolume = newValue;
    _beatCreationBloc.dispatch(
      SubdivisionVolumeChanged(
        volume: _currentVolume,
        subdivision: _selectedSubdivision,
        index: _index,
      ),
    );
  }

  void _onBpmChanged() {
    _beatCreationBloc.dispatch(
      BpmChanged(
        bpm: int.parse(_bpmController.text),
        index: _index,
      ),
    );
  }

  void _onMeasuresChanged() {
    _beatCreationBloc.dispatch(
      MeasuresChanged(
        measures: int.parse(_measuresController.text),
        index: _index,
      ),
    );
  }

  void _onTimeSignatureChanged() {
    _beatCreationBloc.dispatch(
      TimeSignatureChanged(
        timeSignature: _timeSignatureController.text,
        index: _index,
      ),
    );
  }

  void _onEndingTypeChanged() {
    _beatCreationBloc.dispatch(
      EndingTypeChanged(
        endingType: _endingTypeController.text,
        index: _index,
      ),
    );
  }
}
