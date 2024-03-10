
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoolCubit extends Cubit<bool> {
  BoolCubit() : super(false);

  void toggleValue() {
    emit(!state);
  }

  void setTrue() {
    emit(true);
  }

  void setFalse() {
    emit(false);
  }
}

class SwitchPrayerCubit extends Cubit<Map<int, bool>> {
  SwitchPrayerCubit() : super({}) {
    _loadSwitchState();
  }






  Future<void> _loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<int, bool> currentState = {};
    prefs.getKeys().forEach((key) {
      if (key.endsWith('SprayerTime')) {
        currentState[int.parse(key.replaceAll('SprayerTime', ''))] =
            prefs.getBool(key) ?? false;
        print('key=>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $key');
      }
    });
    emit(currentState);
  }

  void turnOn(int id, bool value) async {
    final Map<int, bool> currentState = Map.from(state);
    currentState[id] = value;
    emit(currentState);
    _saveSwitchState(id, currentState[id]!);
  }

  Future<void> _saveSwitchState(int id, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('$id SprayerTime', value);
  }
}
