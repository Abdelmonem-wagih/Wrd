part of 'selected_azker_bloc.dart';

@immutable
abstract class SelectedAzkerEvent extends Equatable {
  const SelectedAzkerEvent();
  @override
  List<Object> get props => [];
}

class AddCounter extends SelectedAzkerEvent {}

class ResetCounter extends SelectedAzkerEvent {}
