part of 'haju_cubit.dart';

abstract class HajuState extends Equatable {
  const HajuState();

  @override
  List<Object> get props => [];
}

class HajuLoadingState extends HajuState {}

class HajuSuccessState extends HajuState {
  final List<Haju> haju;

  const HajuSuccessState({required this.haju});
  @override
  List<Object> get props => [haju];
}

class HajuErorrState extends HajuState {
  final String errorMessage;

  const HajuErorrState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
