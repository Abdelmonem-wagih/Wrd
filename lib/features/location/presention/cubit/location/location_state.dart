part of 'location_cubit.dart';


abstract class LocationServiceState extends Equatable {
  const LocationServiceState();

  @override
  List<Object> get props => [];
}

class LocationLoadingState extends LocationServiceState {}

class LocationSuccessState extends LocationServiceState {
  final List<Location> location;

  const LocationSuccessState({required this.location});
  @override
  List<Object> get props => [location];
}

class LocationErorrState extends LocationServiceState {
  final String errorMessage;

  const LocationErorrState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class OfflineLocation extends LocationServiceState {
  @override
  List<Object> get props => [];
}
