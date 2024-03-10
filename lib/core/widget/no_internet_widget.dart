import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 500.w,
              ),
              child: ClipOval(
                child: LottieBuilder.asset(
                  'assets/json/lost-connection.json',
                ),
              ),
            ),
            SizedBox(
              height: 16.height,
            ),
            // خطاء في الاتصال بالانترنت
            Text("خطاء في الاتصال بالانترنت",
                style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Almarai",
                    fontStyle: FontStyle.normal,
                    fontSize: 24.0.fontSize),
                textAlign: TextAlign.left),

            // هذه الصفحة غير موجودة يجب عليك الاتصال، بالانترنت اذا كنت تريد استخدام هذه الصفحة.
            Padding(
              padding:  EdgeInsets.symmetric(vertical:20.0.height , horizontal: 29.width),
              child: Text(
                'هذه الصفحة غير موجودة يجب عليك الاتصال ، '
                'بالانترنت اذا كنت تريد استخدام هذه الصفحة.',
                style: TextStyle(
                  height: 1.5.height,
                    color: AppColors.darkTone,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Almarai",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0.fontSize),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.height),

            TextButton(

              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.primary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0.width , vertical: 7.height),
                child: Text(
                  "الصفحة الرئيسية",
                  style: TextStyle(
                    color: AppColors.baseWhite,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Almarai",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.0.fontSize,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(height: 20.height),
            Image.asset('assets/image/helf_down_frame.png')
          ],
        ),
      ),
    );
  }
}
