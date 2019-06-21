import 'package:equatable/equatable.dart';
import 'package:metronome/models/beat_fragment.dart';

class Beat extends Equatable {
  String beatName;
  List<BeatFragment> beatFragments;

  Beat({
    this.beatName,
    this.beatFragments,
  }) : super([
          beatName,
          beatFragments,
        ]);
}
