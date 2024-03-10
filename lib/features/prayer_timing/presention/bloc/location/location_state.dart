import 'package:equatable/equatable.dart';
import '../../controller/failuer.dart';

abstract class LocationState extends Equatable {
  final double latitude;
  final double longitude;
  final LocalFailure? failure;

  const LocationState(
      this.latitude,
      this.longitude, {
        this.failure,
      });

  @override
  List<Object?> get props => [latitude, longitude, failure];
}

class LocationInitial extends LocationState {
  const LocationInitial(double latitude, double longitude, LocalFailure failure)
      : super(latitude, longitude, failure: failure);

  @override
  List<Object?> get props => [latitude, longitude, failure];
}

class LocationLoading extends LocationState {
  const LocationLoading(double latitude, double longitude)
      : super(latitude, longitude);

  @override
  List<Object?> get props => [latitude, longitude];
}

class LocationSuccess extends LocationState {
  const LocationSuccess(double latitude, double longitude)
      : super(latitude, longitude);

  @override
  List<Object?> get props => [latitude, longitude];
}

class LocationFailed extends LocationState {
  const LocationFailed(double latitude, double longitude, LocalFailure failure)
      : super(latitude, longitude, failure: failure);

  @override
  List<Object?> get props => [latitude, longitude, failure];
}

class OfflineState extends LocationState {
  OfflineState(super.latitude, super.longitude);

  @override
  List<Object> get props => [];
}
