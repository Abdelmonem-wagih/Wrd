part of 'selected_duea_bloc.dart';

@immutable
abstract class SelectedDueaEvent extends Equatable{
  const SelectedDueaEvent();
  @override
  List<Object> get props => [];
}


class AddCounter extends SelectedDueaEvent {}

class ResetCounter extends SelectedDueaEvent {}