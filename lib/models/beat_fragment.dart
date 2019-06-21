import 'package:equatable/equatable.dart';

class BeatFragment extends Equatable {
  int bpm;
  int measures;
  String timeSignature;
  String endingType;

  BeatFragment({
    this.bpm,
    this.measures,
    this.timeSignature,
    this.endingType,
  }) : super([
          bpm,
          measures,
          timeSignature,
          endingType,
        ]);

  BeatFragment.fromMap(Map<String, dynamic> data)
      : this(
          bpm: data['bpm'],
          measures: data['measures'],
          timeSignature: data['timeSignature'],
          endingType: data['endingType'],
        );

  Map<String, dynamic> toMap() => {
        'bpm': bpm,
        'measures': measures,
        'timeSignature': timeSignature,
        'endingType': endingType,
      };
}
