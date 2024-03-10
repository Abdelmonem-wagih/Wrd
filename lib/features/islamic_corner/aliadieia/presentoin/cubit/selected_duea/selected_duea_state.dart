part of 'selected_duea_bloc.dart';

class SelectedDueaState extends Equatable {
  final DueaArray duea;
  final int count;
  const SelectedDueaState(
      this.duea,
      this.count,
      );

  @override
  List<Object> get props => [duea, count];
}

