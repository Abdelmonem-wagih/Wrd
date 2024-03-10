import 'package:equatable/equatable.dart';
import 'moshaf.dart';

// ignore: must_be_immutable
class QuranAudio extends Equatable {
  int? id;
  String? readersName;
  String? letter;
  List<Moshaf?> moshafs;

  QuranAudio({
    required this.id,
    required this.readersName,
    required this.letter,
    required this.moshafs,
  });

  @override
  List<Object?> get props => [id, readersName, letter,moshafs];
}
