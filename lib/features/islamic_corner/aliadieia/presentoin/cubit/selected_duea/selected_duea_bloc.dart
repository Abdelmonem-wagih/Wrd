
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wrd/features/islamic_corner/aliadieia/domain/entities/duea_array.dart';

part 'selected_duea_event.dart';
part 'selected_duea_state.dart';

class SelectedDueaBloc extends Bloc<SelectedDueaEvent, SelectedDueaState> {
  SelectedDueaBloc(final duea) : super(SelectedDueaState(duea, 0)) {
    on<SelectedDueaEvent>((event, emit) async {
      if (event is AddCounter) {
        if (state.count < state.duea.count!) {
          emit(SelectedDueaState(state.duea, state.count + 1));
        }
      } else if (event is ResetCounter) {
        emit(SelectedDueaState(state.duea, 0));
      }
    });
  }
}
