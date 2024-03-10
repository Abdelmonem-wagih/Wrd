part of 'says_cubit.dart';

abstract class SaysState extends Equatable {
  const SaysState();

  @override
  List<Object> get props => [];
}

class SaysLoadingState extends SaysState {}

class SaysSuccessState extends SaysState {
  final List<Says> says;

  const SaysSuccessState({required this.says});
  @override
  List<Object> get props => [says];
}

class SaysErorrState extends SaysState {
  final String errorMessage;

  const SaysErorrState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
