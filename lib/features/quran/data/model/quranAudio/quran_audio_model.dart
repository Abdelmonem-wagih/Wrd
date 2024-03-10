// ignore_for_file: must_be_immutable
import '../../../domain/entities/quranAudio/moshaf.dart';
import '../../../domain/entities/quranAudio/quran_audio.dart';
import 'moshaf_model.dart';

class QuranAudioModel extends QuranAudio {
  QuranAudioModel({
    required super.id,
    required super.readersName,
    required super.moshafs, required super.letter,
  });

  factory QuranAudioModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> moshafJson = json['moshaf'];
    List<Moshaf?> moshaf =
    moshafJson.map((ayahJson) => MoshafModel.fromJson(ayahJson)).toList();


    return QuranAudioModel(
      id: json['id'],
      readersName: json['name'].toString(),
      letter: json['letter'],
      moshafs: moshaf,
    );
  }
}
