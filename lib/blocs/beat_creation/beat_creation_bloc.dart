import 'package:meta/meta.dart';
import 'package:metronome/blocs/beat_creation/beat_creation_event.dart';
import 'package:metronome/blocs/beat_creation/beat_creation_state.dart';
import 'package:bloc/bloc.dart';
import 'package:metronome/models/models.dart';
import 'package:metronome/resources/repository.dart';

class BeatCreationBloc extends Bloc<BeatCreationEvent, BeatCreationState> {
  Repository _repository;

  BeatCreationBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;
  @override
  BeatCreationState get initialState => BeatCreationState.initial();

  @override
  Stream<BeatCreationState> mapEventToState(
    BeatCreationEvent event,
  ) async* {
    if (event is BeatNameChanged) {
      yield* _mapBeatNameChangedToState(
        event.beatName,
      );
    } else if (event is UploadBeatPressed) {
      yield* _mapUploadBeatPressedToState();
    } else if (event is BeatFragmentAdded) {
      yield* _mapBeatFragmentAddedToState();
    } else if (event is BpmChanged) {
      yield* _mapBpmChangedToState(
        event.bpm,
        event.index,
      );
    } else if (event is MeasuresChanged) {
      yield* _mapMeasuresChangedToState(
        event.measures,
        event.index,
      );
    } else if (event is TimeSignatureChanged) {
      yield* _mapTimeSignatureChangedToState(
        event.timeSignature,
        event.index,
      );
    } else if (event is EndingTypeChanged) {
      yield* _mapEndingTypeChangedToState(
        event.endingType,
        event.index,
      );
    } else if (event is BeatFragmentDeleted) {
      yield* _mapBeatFragmentDeletedToState(
        event.index,
      );
    } else if (event is UndoBeatFragmentDelete) {
      yield* _mapUndoBeatFragmentDeleteToState();
    } else if (event is SubdivisionVolumeChanged) {
      yield* _mapSubdivisionVolumeChangedToState(
        event.volume,
        event.subdivision,
        event.index,
      );
    }
  }

  Stream<BeatCreationState> _mapBeatNameChangedToState(
    String beatName,
  ) async* {
    Beat newBeat = currentState.beat;
    newBeat.beatName = beatName;
    yield currentState.update(
      beat: newBeat,
    );
  }

  Stream<BeatCreationState> _mapBpmChangedToState(
    int bpm,
    int index,
  ) async* {
    List<BeatFragment> newBeatFragments = currentState.beat.beatFragments;
    newBeatFragments[index].bpm = bpm;
    yield currentState.update(
      beat: Beat(
        beatName: currentState.beat.beatName,
        beatFragments: newBeatFragments,
      ),
    );
  }

  Stream<BeatCreationState> _mapBeatFragmentAddedToState() async* {
    List<BeatFragment> newBeatFragments = currentState.beat.beatFragments;
    newBeatFragments.add(BeatFragment(
      bpm: 70,
      measures: 40,
      timeSignature: "4/4",
      endingType: "END",
      accentVolume: 0.70,
      quarterNoteVolume: 0.0,
      eighthNoteVolume: 0.0,
      sixteenthNoteVolume: 0.0,
      tripletVolume: 0.0,
    ));
    yield currentState.update(
        beat: Beat(
      beatName: currentState.beat.beatName,
      beatFragments: newBeatFragments,
    ));
  }

  Stream<BeatCreationState> _mapMeasuresChangedToState(
    int measures,
    int index,
  ) async* {
    List<BeatFragment> newBeatFragments = currentState.beat.beatFragments;
    newBeatFragments[index].measures = measures;
    yield currentState.update(
        beat: Beat(
      beatName: currentState.beat.beatName,
      beatFragments: newBeatFragments,
    ));
  }

  Stream<BeatCreationState> _mapTimeSignatureChangedToState(
    String timeSignature,
    int index,
  ) async* {
    List<BeatFragment> newBeatFragments = currentState.beat.beatFragments;
    newBeatFragments[index].timeSignature = timeSignature;
    yield currentState.update(
        beat: Beat(
      beatName: currentState.beat.beatName,
      beatFragments: newBeatFragments,
    ));
  }

  Stream<BeatCreationState> _mapEndingTypeChangedToState(
    String endingType,
    int index,
  ) async* {
    List<BeatFragment> newBeatFragments = currentState.beat.beatFragments;
    newBeatFragments[index].endingType = endingType;
    yield currentState.update(
        beat: Beat(
      beatName: currentState.beat.beatName,
      beatFragments: newBeatFragments,
    ));
  }

  Stream<BeatCreationState> _mapUploadBeatPressedToState() async* {
    yield currentState.update(
      isUploading: true,
    );
    try {
      await _repository.writeBeat(currentState.beat);
      yield currentState.update(
        uploaded: true,
      );
    } catch (_) {
      yield currentState.update(
        uploadFailed: true,
      );
    }
  }

  Stream<BeatCreationState> _mapBeatFragmentDeletedToState(
    int deletedFragmentIndex,
  ) async* {
    List<BeatFragment> newBeatFragments = currentState.beat.beatFragments;
    BeatFragment deletedFragment =
        newBeatFragments.removeAt(deletedFragmentIndex);
    yield currentState.update(
      beat: Beat(
        beatName: currentState.beat.beatName,
        beatFragments: newBeatFragments,
      ),
      deletedFragment: deletedFragment,
      deletedFragmentIndex: deletedFragmentIndex,
    );
  }

  Stream<BeatCreationState> _mapUndoBeatFragmentDeleteToState() async* {
    List<BeatFragment> newBeatFragments = currentState.beat.beatFragments;
    newBeatFragments.insert(
      currentState.deletedFragmentIndex,
      currentState.deletedFragment,
    );
    yield currentState.update(
      beat: Beat(
        beatName: currentState.beat.beatName,
        beatFragments: newBeatFragments,
      ),
    );
  }

  Stream<BeatCreationState> _mapSubdivisionVolumeChangedToState(
    double volume,
    Subdivision subdivision,
    int index,
  ) async* {
    List<BeatFragment> newBeatFragments = currentState.beat.beatFragments;
    newBeatFragments[index].setVolume(
      subdivision,
      volume,
    );
    yield currentState.update(
      beat: Beat(
        beatName: currentState.beat.beatName,
        beatFragments: newBeatFragments,
      ),
    );
  }
}
