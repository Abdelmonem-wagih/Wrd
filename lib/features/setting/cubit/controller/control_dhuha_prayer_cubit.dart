import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ControlDhuhaPrayerCubit extends Cubit<String> {
  final SharedPreferences prefs;

  ControlDhuhaPrayerCubit(String initialValue, this.prefs) : super(initialValue);

  void selectDhuhaPrayer(String dhuhaPrayer) {
    emit(dhuhaPrayer);
    _saveDhuhaPrayer(dhuhaPrayer);
  }

  String getSavedDhuhaPrayer() {
    return prefs.getString('dhuhaPrayer') ?? '';
  }

  Future<void> _saveDhuhaPrayer(String dhuhaPrayer) async {
    await prefs.setString('dhuhaPrayer', dhuhaPrayer);
  }

}
