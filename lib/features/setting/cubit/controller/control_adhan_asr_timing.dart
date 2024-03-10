import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlAdhanAsrTimingCubit extends Cubit<String> {
  final SharedPreferences prefs;

  ControlAdhanAsrTimingCubit(String initialValue, this.prefs)
      : super(initialValue);

  void selectSchoolOfAdhanAsrTiming(String school ) {
    emit(school);
    _saveSchoolOfAdhanAsrTiming(school);
  }

  String getSavedSchoolOfAdhanAsrTiming() {
    return prefs.getString('adhanAsr') ?? '';
  }

  Future<void> _saveSchoolOfAdhanAsrTiming(String school) async {
    await prefs.setString('adhanAsr', school);
  }
}
