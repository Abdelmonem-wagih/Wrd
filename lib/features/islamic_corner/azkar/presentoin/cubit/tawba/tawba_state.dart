part of 'tawba_cubit.dart';

abstract class TawbaState extends Equatable {
  const TawbaState();

  @override
  List<Object> get props => [];
}

class TawbaLoadingState extends TawbaState {}

class TawbaSuccessState extends TawbaState {
  final List<Tawba> tawba;

  const TawbaSuccessState({required this.tawba});
  @override
  List<Object> get props => [tawba];
}

class TawbaErorrState extends TawbaState {
  final String errorMessage;

  const TawbaErorrState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
