part of 'azkar_cubit.dart';

abstract class AzkarState extends Equatable {
  const AzkarState();

  @override
  List<Object> get props => [];
}

class AzkarLoadingState extends AzkarState {}

class AzkarSuccessState extends AzkarState {
  final List<Azkar> azkar;

  const AzkarSuccessState({required this.azkar});
  @override
  List<Object> get props => [azkar];
}

class AzkarErorrState extends AzkarState {
  final String errorMessage;

  const AzkarErorrState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
