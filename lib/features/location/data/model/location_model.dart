// ignore_for_file: must_be_immutable
import 'package:wrd/features/location/domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel({required super.displayName});

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    displayName: json['display_name'],
      );
}
