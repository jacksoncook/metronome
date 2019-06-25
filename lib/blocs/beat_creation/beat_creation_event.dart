import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class BeatCreationEvent extends Equatable {
  BeatCreationEvent([List props = const []]) : super(props);
}

class BeatNameChanged extends BeatCreationEvent {
  final String beatName;

  BeatNameChanged({
    @required this.beatName,
  }) : super([beatName]);

  @override
  String toString() => 'BeatNameChanged { beatName :$beatName }';
}

class BpmChanged extends BeatCreationEvent {
  final int bpm;
  final int index;

  BpmChanged({
    @required this.bpm,
    @required this.index,
  }) : super([bpm, index]);

  @override
  String toString() => 'BpmChanged { bpm :$bpm }';
}

class MeasuresChanged extends BeatCreationEvent {
  final int measures;
  final int index;

  MeasuresChanged({
    @required this.measures,
    @required this.index,
  }) : super([measures, index]);

  @override
  String toString() => 'MeasuresChanged { measures :$measures }';
}

class TimeSignatureChanged extends BeatCreationEvent {
  final String timeSignature;
  final int index;

  TimeSignatureChanged({
    @required this.timeSignature,
    @required this.index,
  }) : super([timeSignature, index]);

  @override
  String toString() => 'TimeSignatureChanged { timeSignature :$timeSignature }';
}

class EndingTypeChanged extends BeatCreationEvent {
  final String endingType;
  final int index;

  EndingTypeChanged({
    @required this.endingType,
    @required this.index,
  }) : super([endingType, index]);

  @override
  String toString() => 'EndingTypeChanged { endingType :$endingType }';
}

class BeatFragmentAdded extends BeatCreationEvent {
  BeatFragmentAdded() : super([]);

  @override
  String toString() => 'BeatFragmentAdded';
}

class BeatFragmentDeleted extends BeatCreationEvent {
  final int index;

  BeatFragmentDeleted({
    @required this.index,
  }) : super([index]);

  @override
  String toString() => 'BeatFragmentDeleted';
}

class UndoBeatFragmentDelete extends BeatCreationEvent {
  UndoBeatFragmentDelete() : super([]);

  @override
  String toString() => 'UndoBeatFragmentDelete';
}

class UploadBeatPressed extends BeatCreationEvent {
  UploadBeatPressed() : super([]);

  @override
  String toString() => 'UploadBeatPressed';
}
