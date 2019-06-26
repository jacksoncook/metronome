import 'package:metronome/models/beat.dart';
import 'package:metronome/models/beat_fragment.dart';
import 'package:meta/meta.dart';

class BeatCreationState {
  final Beat beat;
  BeatFragment deletedFragment;
  int deletedFragmentIndex;
  bool isUploading;
  bool uploadFailed;
  bool uploaded;

  BeatCreationState({
    @required this.beat,
    @required this.deletedFragment,
    @required this.deletedFragmentIndex,
    @required this.isUploading,
    @required this.uploadFailed,
    @required this.uploaded,
  });

  factory BeatCreationState.initial() {
    List<BeatFragment> beatFragments = [];

    beatFragments.add(new BeatFragment(
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

    return BeatCreationState(
      beat: Beat(
        beatName: "",
        beatFragments: beatFragments,
      ),
      deletedFragment: null,
      deletedFragmentIndex: 0,
      isUploading: false,
      uploadFailed: false,
      uploaded: false,
    );
  }

  BeatCreationState update({
    Beat beat,
    BeatFragment deletedFragment,
    int deletedFragmentIndex,
    bool isUploading,
    bool uploadFailed,
    bool uploaded,
  }) {
    return copyWith(
      beat: beat,
      deletedFragment: deletedFragment,
      deletedFragmentIndex: deletedFragmentIndex,
      isUploading: isUploading,
      uploadFailed: uploadFailed,
      uploaded: uploaded,
    );
  }

  BeatCreationState copyWith({
    Beat beat,
    BeatFragment deletedFragment,
    int deletedFragmentIndex,
    bool isUploading,
    bool uploadFailed,
    bool uploaded,
  }) {
    return BeatCreationState(
      beat: beat ?? this.beat,
      deletedFragment: deletedFragment ?? null,
      deletedFragmentIndex: deletedFragmentIndex ?? 0,
      isUploading: isUploading ?? false,
      uploadFailed: uploadFailed ?? false,
      uploaded: uploaded ?? false,
    );
  }
}
