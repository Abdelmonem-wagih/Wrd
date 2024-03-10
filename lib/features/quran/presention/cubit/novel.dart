import 'package:bloc/bloc.dart';

class NovelCubit extends Cubit<String> {
  NovelCubit() : super('');

  void setNovel(String value) {
    emit(value); // Emit the new value to update the state
  }
}
