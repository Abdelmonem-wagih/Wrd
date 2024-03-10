import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnOffAzkerMorningCubit extends Cubit<bool> {
  OnOffAzkerMorningCubit() : super(false){
    _loadValue();
  }

  Future<void> _loadValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    emit(prefs.getBool('azkerMorning') ?? false);
  }

  Future<void> switchOnOffAzkerMorning() async {
    final newValue = !state;
    emit(newValue);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('azkerMorning', newValue);
  }
}
