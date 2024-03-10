part of 'zkar_cubit.dart';

abstract class ZkarState extends Equatable {
  const ZkarState();

  @override
  List<Object> get props => [];
}

class ZkarLoadingState extends ZkarState {}

class ZkarSuccessState extends ZkarState {
  final List<Zkar> zkar;

  const ZkarSuccessState({required this.zkar});
  @override
  List<Object> get props => [zkar];
}

class ZkarErorrState extends ZkarState {
  final String errorMessage;

  const ZkarErorrState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
