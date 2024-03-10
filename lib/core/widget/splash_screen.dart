import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:wrd/core/services/location_helper.dart';
import 'package:wrd/core/services/notification_helper.dart';

import '../../main.dart';
import '../../test_screen/tab_screen.dart';
import '../services/screen_size_helper.dart';
import 'location_enable_dialog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // late Timer _timer;
  goNext() => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => TabScreen(),
      ),
      (route) => false);
  startDely() {
    // _timer =
    Timer(const Duration(seconds: 5), () async {
      // goNext();
      _checkLocationService();
    });
  }

  @override
  void initState() {
    NotificationHelper.init();
    super.initState();
    startDely();
    // _checkLocationService();
  }

  Future<void> _checkLocationService() async {
    if (!(await LocationHelper.isAllow)) {
      // Location service is not enabled, show dialog
      _showLocationDialog();
    } else {
      goNext();
    }
  }

  void _showLocationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LocationEnableDialog(
          onEnable: () {
            // context.read<LocationCubit>().getLocation();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MyApp(isFirstTime: false,)),
              (route) => false,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeHelper.init(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500.w),
            child: LottieBuilder.asset(
              'assets/json/splash.json',
            ),
          ),
        ),
      ),
    );
  }
}
