
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/tasbih_array.dart';

part 'selected_tasbih_event.dart';
part 'selected_tasbih_state.dart';


class SelectedTasbihBloc
    extends Bloc<SelectedTasbihEvent, SelectedTasbihState> {
  SelectedTasbihBloc(TasbihArray tasbih)
      : super(SelectedTasbihState(tasbih, 0)) {
    on<SelectedTasbihEvent>((event, emit) async {
      if (event is AddCounter) {
        if (state.count < state.tasbih.count!) {
          emit(SelectedTasbihState(state.tasbih, state.count + 1));
        }
      } else if (event is ResetCounter) {
        emit(SelectedTasbihState(state.tasbih, 0));
      }
    });
  }
}
