import 'package:bloc/bloc.dart';

import '../../controller/muezzin_preferences.dart';

class ControlAdhanCubit extends Cubit<String> {
  ControlAdhanCubit() : super('') {
    _loadInitialValue();
  }
  Future<void> _loadInitialValue() async {
    final muezzinName = await MuezzinPreferences.getMuezzin();
    emit(muezzinName ?? 'adhan_alharam_almakiyi');
  }

  void selectMuezzin(String muezzinName) => emit(muezzinName);
}
