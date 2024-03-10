import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ControlEveningPrayersCubit extends Cubit<String> {
  final SharedPreferences prefs;

  ControlEveningPrayersCubit(String initialValue, this.prefs) : super(initialValue);

  void selectEveningPrayers(String eveningPrayers) {
    emit(eveningPrayers);
    _saveEveningPrayers(eveningPrayers);
  }

  String getSavedEveningPrayers() {
    return prefs.getString('eveningPrayers') ?? '';
  }

  Future<void> _saveEveningPrayers(String eveningPrayers) async {
    await prefs.setString('eveningPrayers', eveningPrayers);
  }
}
