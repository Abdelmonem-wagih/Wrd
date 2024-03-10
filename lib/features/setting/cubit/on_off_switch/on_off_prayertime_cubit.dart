import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnOffPrayerTimeCubit extends Cubit<bool> {

  OnOffPrayerTimeCubit() : super(true) {
    _loadValue();
  }


  Future<void> _loadValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    emit(prefs.getBool('boolValues') ?? true);
  }

  Future<void> switchOnOffPrayerTime() async {
    final newValue = !state;
    emit(newValue);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValues', newValue);
  }
}
