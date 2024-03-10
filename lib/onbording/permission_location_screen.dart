import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/main.dart';
import '../core/services/location_helper.dart';
import '../core/utils/app_colors.dart';

class PermissionLocationScreen extends StatelessWidget {
  const PermissionLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Image.asset(
              'assets/image/helf_down_frame.png',
              height: 180.height,
              width: 360.width,
            ),
          ),
          Center(
            child: WillPopScope(
              onWillPop: () async => false,
              child: Container(
                width: 330.width,
                height: 500.height,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x0d634a2d),
                        offset: Offset(0, 4),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                        'assets/onbording/permission_location.svg'),
                    Text("إذن الوصول الي الموقع الخاص بك",
                        style: TextStyle(
                          color: AppColors.darkTone,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Almarai",
                          fontStyle: FontStyle.normal,
                          fontSize: 20.0.fontSize,
                        ),
                        textAlign: TextAlign.right),

                    // نحتاج منك السماح لنا للوصول الي موقعك الجغرافي لكي نتمكن من ضبط مواقيت الصلاة الخاصة بالموقع الخاص ب
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "نحتاج منك السماح لنا للوصول الي موقعك الجغرافي لكي نتمكن من ضبط مواقيت الصلاة الخاصة بالموقع الخاص بك.",
                        style: TextStyle(
                            height: 1.4.height,
                            color: AppColors.darkTone,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Almarai",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.0.fontSize),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              5.0.radius,
                            ), // Adjust the radius as needed
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primary),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.width),
                        child: Text(
                          "أوافق",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Almarai",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.0.fontSize,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('isFirstTime', false);
                        bool goToStartScreen = true;
                        try {
                          ///// request permission if app dose not have it
                          if (await LocationHelper
                              .hasLocationPermissionAndRequest()) {
                            goToStartScreen = false;
                            ///// check if this user has document or not
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const MyApp(isFirstTime: false)),
                            );
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
