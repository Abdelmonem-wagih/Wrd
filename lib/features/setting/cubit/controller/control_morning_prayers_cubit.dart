import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ControlMorningPrayersCubit extends Cubit<String> {
  final SharedPreferences prefs;

  ControlMorningPrayersCubit(String initialValue, this.prefs) : super(initialValue);

  void selectMorningPrayers(String morningPrayers) {
    emit(morningPrayers);
    _saveMorningPrayers(morningPrayers);
  }

  String getSavedMorningPrayers() {
    return prefs.getString('morningPrayers') ?? '';
  }

  Future<void> _saveMorningPrayers(String morningPrayers) async {
    await prefs.setString('morningPrayers', morningPrayers);
  }
}
