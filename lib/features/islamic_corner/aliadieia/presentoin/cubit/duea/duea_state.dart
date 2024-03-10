part of 'duea_cubit.dart';

abstract class DueaState extends Equatable {
  const DueaState();

  @override
  List<Object> get props => [];
}

class DueaLoadingState extends DueaState {}

class DueaSuccessState extends DueaState {
  final List<Duea> duea;

  const DueaSuccessState({required this.duea});
  @override
  List<Object> get props => [duea];
}

class DueaErorrState extends DueaState {
  final String errorMessage;

  const DueaErorrState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
