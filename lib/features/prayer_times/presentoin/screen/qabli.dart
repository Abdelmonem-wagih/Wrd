import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vibration/vibration.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/main.dart';

import '../../../../core/function_helper/remove_range_string.dart';

class QiblahScreen extends StatefulWidget {
  const QiblahScreen({
    super.key, required this.location,
  });
  final String location;

  @override
  State<QiblahScreen> createState() => _QiblahScreenState();
}

Animation<double>? animation;
AnimationController? _animationController;
double begin = 0.0;

class _QiblahScreenState extends State<QiblahScreen>
    with SingleTickerProviderStateMixin {
  Future<void> triggerVibration() async {
    // Check if the device can vibrate
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator != null && hasVibrator) {
      // Vibrate with default duration
      Vibration.vibrate();
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
    super.initState();
  }

  String currentImage = 'icon_qibla.svg'; // Initial image

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List<String> locationParts = widget.location.split('،');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              isArabic()
                  ? Icons.arrow_back_ios_sharp
                  : Icons.arrow_back_ios_new_sharp,
            ),
          ),
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: AppColors.primary,
            size: 20,
          ),
          title: const Text(
            'إتجاه القبلة',
            style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontFamily: "Almarai",
                fontStyle: FontStyle.normal,
                fontSize: 20.0),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.lightYellow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'إتجاه القبلة:  ',
                      style: TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Almarai",
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0.fontSize,
                      ),
                    ),
                    TextSpan(
                      text: extractLastWord(widget.location),
                      //locationParts[2],
                      style: TextStyle(
                        color: AppColors.darkTone,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Almarai",
                        fontStyle: FontStyle.normal,
                        fontSize: 16.0.fontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder(
                stream: FlutterQiblah.qiblahStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    );
                  }

                  final qiblahDirection = snapshot.data;
                  animation = Tween(
                    begin: begin,
                    end: (qiblahDirection!.qiblah * (pi / 180) * -1),
                  ).animate(_animationController!);
                  begin = (qiblahDirection.qiblah * (pi / 180) * -1);
                  _animationController!.forward(from: 0);

                  if (snapshot.data!.direction >= snapshot.data!.offset - 2 &&
                      snapshot.data!.direction <= snapshot.data!.offset + 2) {
                    currentImage = 'icon_qibla_withColor.svg';
                    triggerVibration();
                  } else {
                    currentImage = 'icon_qibla.svg';
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/$currentImage',
                              ),
                              Image.asset('assets/image/frame.png'),
                              AnimatedBuilder(
                                animation: animation!,
                                builder: (context, child) => Transform.rotate(
                                  angle: animation!.value,
                                  child: Image.asset(
                                    'assets/image/icon_circel.png',
                                    height: MediaQuery.of(context).size.height *
                                        0.45,
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //latitude=30.1316123&longitude=31.7295788
                    ],
                  );
                }),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.lightYellow,
                borderRadius: BorderRadius.circular(10),
              ),
              child:  Text(
                removeWordBeforeLast(widget.location),
                // widget.location,
                style: const TextStyle(
                    color: AppColors.darkTone,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Almarai",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: AppColors.primary,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    builder: (context) => Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min, // Use min to wrap content

                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Divider(
                              color: Colors.white,
                              thickness: 6,
                              endIndent: 155,
                              indent: 155,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Icon(
                            Icons.help,
                            textDirection: TextDirection.ltr,
                            color: AppColors.baseWhite,
                            size: 50,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "طريقة الإستخدام",
                            style: TextStyle(
                              color: AppColors.lightYellow,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Almarai",
                              fontStyle: FontStyle.normal,
                              fontSize: 20.0,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "يشير السهم إلي إتجاه القبلة في مكانك الحالي, للحصول علي نتجية دقيقة, امسك الهاتف بيدك و حركه يمينا و يسارا عندما تري السهم تحول للوان الاصفر وهاتفك يهتز ف انت علي الإتجاه الصحيح للقبلة.",
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Almarai",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.help,
                      textDirection: TextDirection.ltr,
                      color: AppColors.darkTone,
                    ),
                    Text(
                      "طريقة الإستخدام",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor:
                              Colors.grey, // Optional: Change the line color
                          decorationThickness: 2.0,
                          color: AppColors.darkTone,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Almarai",
                          fontStyle: FontStyle.normal,
                          fontSize: 13.0),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
