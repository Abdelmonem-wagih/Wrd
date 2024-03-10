import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/onbording/permission_location_screen.dart';

import '../core/services/clipper_helper.dart';

class CustomShapeContainer extends StatelessWidget {
  const CustomShapeContainer({
    super.key,
    required this.pageController,
    required this.image,
    required this.title,
    required this.bodyText,
    required this.logoColor,
    required this.backgroundColor,
    required this.clipperColor,
    required this.space,
    required this.lastPage,
  });
  final PageController pageController;
  final String image;
  final String title;
  final String bodyText;
  final Color logoColor;
  final Color backgroundColor;
  final Color clipperColor;
  final double space;
  final bool lastPage;
  @override
  Widget build(BuildContext context) {
    ScreenSizeHelper.init(context);

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 30.0.width),
          child: Container(
            color: backgroundColor,
            child: Padding(
              padding: EdgeInsets.only(top: 30.0.height),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.width),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // تخطي
                        lastPage
                            ? const Text('')
                            : GestureDetector(
                                onTap: () {
                                  pageController.jumpToPage(2);
                                },
                                child: Text(
                                  "تخطي",
                                  style: TextStyle(
                                    color: const Color(0xff333333),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Almarai",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.0.fontSize,
                                  ),
                                ),
                              ),
                        SvgPicture.asset(
                          'assets/svg/icon_logo.svg',
                          color: logoColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.height),
                  SvgPicture.asset(image),
                  SizedBox(height: space.height),
                  Padding(
                    padding: EdgeInsets.only(right: 60.0.height),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: AppColors.darkTone,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Almarai",
                        fontStyle: FontStyle.normal,
                        fontSize: 19.fontSize,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.height),
                  Padding(
                    padding: EdgeInsets.only(right: 60.0.height),
                    child: Text(
                      bodyText,
                      style: TextStyle(
                        height: 1.4.height,
                        color: const Color(0xff131212),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Almarai",
                        fontStyle: FontStyle.normal,
                        fontSize: 13.0.fontSize,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            color: clipperColor,
          ),
        ),
        Positioned(
          right: 10,
          bottom: 250.height,
          child: GestureDetector(
            onTap: () {
              lastPage
                  ? Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PermissionLocationScreen(),
                      ),
                      (route) => false)
                  : pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
            },
            child: Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: AppColors.darkTone,
                  width: 2,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColors.darkTone,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
