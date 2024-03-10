import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnOffAzkerEveningCubit extends Cubit<bool> {
  OnOffAzkerEveningCubit() : super(false){
    _loadValue();
  }

  Future<void> _loadValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    emit(prefs.getBool('azkerEvening') ?? false);
  }

  Future<void> switchOnOffAzkerEvening() async {
    final newValue = !state;
    emit(newValue);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('azkerEvening', newValue);
  }
}
