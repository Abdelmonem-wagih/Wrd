part of 'rewaya_cubit.dart';

abstract class RewayaState extends Equatable {
  const RewayaState();

  @override
  List<Object> get props => [];
}

class RewayaLoadingState extends RewayaState {}

class RewayaSuccessState extends RewayaState {
  final List<Rewaya> rewayat;

  const RewayaSuccessState({
    required this.rewayat,
  });
  @override
  List<Object> get props => [rewayat];
}

class RewayaErorrState extends RewayaState {
  final String errorMessage;

  const RewayaErorrState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
