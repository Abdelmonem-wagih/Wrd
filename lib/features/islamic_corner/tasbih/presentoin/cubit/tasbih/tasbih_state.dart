part of 'tasbih_cubit.dart';

abstract class TasbihState extends Equatable {
  const TasbihState();

  @override
  List<Object> get props => [];
}

class TasbihLoadingState extends TasbihState {}

class TasbihSuccessState extends TasbihState {
  final List<Tasbih> tasbih;

  const TasbihSuccessState({required this.tasbih});
  @override
  List<Object> get props => [tasbih];
}

class TasbihErorrState extends TasbihState {
  final String errorMessage;

  const TasbihErorrState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
