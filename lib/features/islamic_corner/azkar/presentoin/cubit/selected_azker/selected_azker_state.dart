part of 'selected_azker_bloc.dart';

class SelectedAzkerState extends Equatable {
  final dynamic azker;
  final int count;
  const SelectedAzkerState(
      this.azker,
      this.count,
      );

  @override
  List<Object> get props => [azker, count];
}

