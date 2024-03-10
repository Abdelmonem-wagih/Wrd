part of 'tashahhud_cubit.dart';

abstract class TashahhudState extends Equatable {
  const TashahhudState();

  @override
  List<Object> get props => [];
}

class TashahhudLoadingState extends TashahhudState {}

class TashahhudSuccessState extends TashahhudState {
  final List<Tashahhud> tashahhud;

  const TashahhudSuccessState({required this.tashahhud});
  @override
  List<Object> get props => [tashahhud];
}

class TashahhudErorrState extends TashahhudState {
  final String errorMessage;

  const TashahhudErorrState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
