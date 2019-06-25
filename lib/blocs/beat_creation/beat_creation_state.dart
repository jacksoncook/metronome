import 'package:metronome/models/beat.dart';
import 'package:metronome/models/beat_fragment.dart';
import 'package:meta/meta.dart';

@immutable
class BeatCreationState {
  final Beat beat;
  BeatFragment deletedFragment;
  int deletedFragmentIndex;

  BeatCreationState({
    @required this.beat,
    @required this.deletedFragment,
    @required this.deletedFragmentIndex,
  });

  factory BeatCreationState.initial() {
    List<BeatFragment> beatFragments = [];

    beatFragments.add(new BeatFragment(
      bpm: 70,
      measures: 40,
      timeSignature: "4/4",
      endingType: "END",
    ));

    return BeatCreationState(
      beat: Beat(
        beatName: "",
        beatFragments: beatFragments,
      ),
      deletedFragment: null,
      deletedFragmentIndex: 0,
    );
  }
}
