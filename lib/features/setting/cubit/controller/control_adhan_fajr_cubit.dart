import 'package:bloc/bloc.dart';
import 'package:wrd/features/setting/controller/muezzin_preferences.dart';

class ControlAdhanFajrCubit extends Cubit<String> {
  ControlAdhanFajrCubit() : super('') {
    _loadInitialValue();
  }

  Future<void> _loadInitialValue() async {
    final muezzinName = await MuezzinPreferencesFajr.getMuezzin();
    emit(muezzinName ?? 'adhan_mishari_bin_rashid_alafasy');
  }

  void selectMuezzin(String muezzinName) => emit(muezzinName);
}
