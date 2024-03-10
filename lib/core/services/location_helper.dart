import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<Position?> getCurrentLocation() async {
    //// permission
    await hasLocationPermissionAndRequest();
    Position? position = await Geolocator.getCurrentPosition();
    return position;
  }

  static Future<bool> get isAllow async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (!(permission == LocationPermission.always) &&
        !(permission == LocationPermission.whileInUse)) {
      return false;
    }

    if (!(await Geolocator.isLocationServiceEnabled())) {
      return false;
    }

    return true;
  }

  static Future<bool> hasLocationPermissionAndRequest() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      } else if (permission == LocationPermission.deniedForever) {
        throw LocationException(
          type: LocationExceptionType.permission,
          message: 'Location permissions are denied forever',
        );
      }
    }
    if (!(await isLocationServiceEnabled())) {
      return false;
    }
    return true;
  }

  static Future<bool> isLocationServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // await Geolocator.openLocationSettings();
      // if (!serviceEnabled) {
      //   throw LocationException('Location services are disabled.');
      // }
      throw LocationException(
        type: LocationExceptionType.locationService,
        message: 'Location services are disabled.',
      );
    }
    return true;
  }

  static Future<bool> openSettings() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (!(permission == LocationPermission.always) &&
        !(permission == LocationPermission.whileInUse)) {
      await Geolocator.openAppSettings();
    }
    if (!(await Geolocator.isLocationServiceEnabled())) {
      await Geolocator.openLocationSettings();
    }
    return false;
  }
}

class LocationException {
  LocationExceptionType type;
  LocationException(
      {this.type = LocationExceptionType.locationService, var message});
}

enum LocationExceptionType {
  permission,
  locationService,
}
