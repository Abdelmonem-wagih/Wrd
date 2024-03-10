import 'package:flutter/material.dart';

import '../services/location_helper.dart';

class LocationEnableDialog extends StatelessWidget {
  const LocationEnableDialog({Key? key, this.onEnable}) : super(key: key);
  final Function()? onEnable;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: const Text('Location Service'),
        content:
            const Text('This app requires location services to be enabled.'),
        actions: <Widget>[
          TextButton(
            child: const Text('Allow'),
            onPressed: () async {
              bool goToStartScreen = true;
              try {
                ///// request permission if app dose not have it
                if (await LocationHelper.hasLocationPermissionAndRequest()) {
                  goToStartScreen = false;
                  ///// check if this user has document or not
                  Navigator.pop(context);
                  if (onEnable != null) onEnable!();
                  return;
                }
              } catch (e) {
                debugPrint(e.toString());
              }
              if (goToStartScreen) {
                ///// if permission denied
                LocationHelper.openSettings();
              }
            },
          ),
        ],
      ),
    );
  }
}
