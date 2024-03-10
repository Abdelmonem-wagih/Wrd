
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'selected_azker_event.dart';
part 'selected_azker_state.dart';

class SelectedAzkerBloc extends Bloc<SelectedAzkerEvent, SelectedAzkerState> {
  SelectedAzkerBloc(dynamic azker) : super(SelectedAzkerState(azker, 0)) {
    on<SelectedAzkerEvent>((event, emit) async {
      if (event is AddCounter) {
        if (state.count < state.azker.count!) {
          emit(SelectedAzkerState(state.azker, state.count + 1));
        }
      } else if (event is ResetCounter) {
        emit(SelectedAzkerState(state.azker, 0));
      }
    });
  }
}
