import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnOffDhuhaCubit extends Cubit<bool> {
  OnOffDhuhaCubit() : super(false){
    _loadValue();
  }

  Future<void> _loadValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    emit(prefs.getBool('dhuha') ?? false);
  }

  Future<void> switchOnOffDhuha() async {
    final newValue = !state;
    emit(newValue);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('dhuha', newValue);
  }
}
