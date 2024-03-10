import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SwitchIconState { switchedOn, switchedOff }

class SwitchPrayerTimesCubit extends Cubit<SwitchIconState> {
  SwitchPrayerTimesCubit() : super(SwitchIconState.switchedOff);
  void switchOn(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('$id-prayerTime', true);
    emit(SwitchIconState.switchedOn);
  }

  void switchOff(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('$id-prayerTime', false);
    emit(SwitchIconState.switchedOff);
  }

  void loadSwitchState(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool switchValue = prefs.getBool('$id-prayerTime') ?? false;
    if (switchValue) {
      emit(SwitchIconState.switchedOn);
    } else {
      emit(SwitchIconState.switchedOff);
    }
  }
}
