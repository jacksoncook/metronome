import 'package:equatable/equatable.dart';

class BeatFragment extends Equatable {
  int bpm;
  int measures;
  String timeSignature;
  String endingType;
  double accentVolume;
  double quarterNoteVolume;
  double eighthNoteVolume;
  double sixteenthNoteVolume;
  double tripletVolume;

  BeatFragment({
    this.bpm,
    this.measures,
    this.timeSignature,
    this.endingType,
    this.accentVolume,
    this.quarterNoteVolume,
    this.eighthNoteVolume,
    this.sixteenthNoteVolume,
    this.tripletVolume,
  }) : super([
          bpm,
          measures,
          timeSignature,
          endingType,
          accentVolume,
          quarterNoteVolume,
          eighthNoteVolume,
          sixteenthNoteVolume,
          tripletVolume,
        ]);

  BeatFragment.fromMap(Map<String, dynamic> data)
      : this(
          bpm: data['bpm'],
          measures: data['measures'],
          timeSignature: data['timeSignature'],
          endingType: data['endingType'],
          accentVolume: data['accentVolume'],
          quarterNoteVolume: data['quarterNoteVolume'],
          eighthNoteVolume: data['eighthNoteVolume'],
          sixteenthNoteVolume: data['sixteenthNoteVolume'],
          tripletVolume: data['tripletVolume'],
        );

  Map<String, dynamic> toMap() => {
        'bpm': bpm,
        'measures': measures,
        'timeSignature': timeSignature,
        'endingType': endingType,
        'accentVolume': accentVolume,
        'quarterNoteVolume': quarterNoteVolume,
        'eighthNoteVolume': eighthNoteVolume,
        'sixteenthNoteVolume': sixteenthNoteVolume,
        'tripletVolume': tripletVolume,
      };

  double getVolume(Subdivision subdivision) {
    switch (subdivision) {
      case Subdivision.Accent:
        {
          return accentVolume;
        }
        break;
      case Subdivision.Quarter:
        {
          return quarterNoteVolume;
        }
        break;
      case Subdivision.Eighth:
        {
          return eighthNoteVolume;
        }
        break;
      case Subdivision.Sixteenth:
        {
          return sixteenthNoteVolume;
        }
        break;
      case Subdivision.Triplet:
        {
          return tripletVolume;
        }
        break;
      default:
        {
          return 0;
        }
        break;
    }
  }

  void setVolume(Subdivision subdivision, double newVolume) {
    switch (subdivision) {
      case Subdivision.Accent:
        {
          this.accentVolume = (newVolume * 100).round() / 100;
        }
        break;
      case Subdivision.Quarter:
        {
          quarterNoteVolume = (newVolume * 100).round() / 100;
        }
        break;
      case Subdivision.Eighth:
        {
          eighthNoteVolume = (newVolume * 100).round() / 100;
        }
        break;
      case Subdivision.Sixteenth:
        {
          sixteenthNoteVolume = (newVolume * 100).round() / 100;
        }
        break;
      case Subdivision.Triplet:
        {
          tripletVolume = (newVolume * 100).round() / 100;
        }
        break;
    }
  }
}

enum Subdivision { Accent, Quarter, Eighth, Sixteenth, Triplet }
