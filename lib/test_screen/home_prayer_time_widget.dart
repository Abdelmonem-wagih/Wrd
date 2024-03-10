// ignore_for_file: must_be_immutable

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';

import '../core/bloc/timer/timer_bloc.dart';
import '../core/controller/count_down_timer.dart';
import '../core/controller/prayer.dart';
import '../core/function_helper/remove_range_string.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/constance.dart';
import '../features/prayer_times/presentoin/widgets/prayer_times_content/text_widget.dart';
import '../features/prayer_timing/presention/bloc/timing/timing_bloc.dart';
import '../features/prayer_timing/presention/bloc/timing/timing_state.dart';
import '../features/prayer_timing/presention/controller/timing_controller.dart';
import '../features/prayer_timing/presention/page/prayer_timing_screen.dart';
import '../frosted_glass.dart';

class HomePrayerTimeWidget extends StatelessWidget {
  HomePrayerTimeWidget({
    Key? key,
    this.isOffline = false,
    this.longitude,
    this.latitude,
    this.locationDetails,
    //required this.location,
  }) : super(key: key);
  final bool isOffline;
  bool showPrayerText = false;
  String currentPrayerTime = '';
  //final String location;
  final double? longitude;
  final double? latitude;
  final String? locationDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PrayerTimingScreen(
            location: locationDetails,
            isOffline: isOffline,
          ),
        ),
      ),
      child: FrostedGlassBox(
        theWidth: 350.width,
        theHeight: 170.height,
        theBoraderRight: 10,
        theBoraderLeft: 10,
        theChild: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 10.0.height,
                right: 5.width,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showPrayerText == true
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: 'حان الآن',
                              fontSize: 20.0.fontSize,
                              color: AppColors.baseWhite,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(height: 10.height),
                            Row(
                              children: [
                                TextWidget(
                                  text: 'أذان',
                                  fontSize: 25.0.fontSize,
                                  color: AppColors.baseWhite,
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(width: 5.width),
                                AnimatedTextKit(
                                  totalRepeatCount: 40,
                                  animatedTexts: [
                                    FadeAnimatedText(
                                      currentPrayerTime,
                                      textStyle: TextStyle(
                                        color: AppColors.baseWhite,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Almarai",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 20.0.fontSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'لا تنس فلسطين من',
                              style: TextStyle(
                                color: AppColors.baseWhite,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Almarai",
                                fontStyle: FontStyle.normal,
                                fontSize: 22.0.fontSize,
                              ),
                            ),
                            Text(
                              'دعائك(غزة العزة)',
                              style: TextStyle(
                                height: 1.6,
                                color: AppColors.baseWhite,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Almarai",
                                fontStyle: FontStyle.normal,
                                fontSize: 22.0.fontSize,
                              ),
                            ),
                          ],
                        ),
                  SizedBox(height: 15.height),
                  Center(
                    child: TextWidget(
                      text: "الصلاة القادمة",
                      fontSize: 16.0.fontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Prayers(
                    color: AppColors.white,
                  ),
                  SizedBox(height: 5.height),
                  BlocBuilder<TimingBloc, TimingState>(
                    builder: (context, state) {
                      TimingController? controller;
                      if (state is PrayerLoadedState) {
                        showPrayerText = state.showPrayerText;
                        currentPrayerTime = state.currentPrayerTime;
                      }
                      if (state is TimingLoaded) {
                        controller =
                            TimingController(state.timing.data.timings);
                      }
                      return AnimatedSwitcher(
                        duration: kAnimationDuration,
                        reverseDuration: Duration.zero,
                        switchInCurve: kAnimationCurve,
                        child: state is! TimingLoaded
                            ? Container()
                            : BlocProvider.value(
                                value: TimerBloc(controller!.time),
                                child: CountDownTimer(
                                  controller,
                                  color: AppColors.white,
                                ),
                              ),
                      );
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 25.0.height,
              ),
              child: Stack(
                children: [
                  ShaderMask(
                    blendMode: BlendMode.dst,
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment(
                            -0.4942967744470053, -0.10356863528293359),
                        end:
                            Alignment(1.4673303320213116, -0.10356863528293359),
                        colors: [
                          Color(0xff151515),
                          AppColors.baseWhite,
                          Color(0xfff2f6fa),
                        ],
                        // Use your desired gradient colors
                      ).createShader(bounds);
                    },
                    child: Image.asset(
                      'assets/image/vector.png',
                      width: 150.width,
                      height: 320.height,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 80.0.height, right: 10.width),
                    child: Container(
                      margin: const EdgeInsets.all(1),
                      width: 110.width,
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'يرفع الاذان في \n',
                                style: TextStyle(
                                    color: const Color(0xfffff5e0),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Almarai",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.0.fontSize),
                              ),
                              isOffline == true
                                  ? TextSpan(
                                      text: 'No Internet connection',
                                      style: TextStyle(
                                        height: 1.5.height,
                                        color: Colors.white,
                                        fontFamily: "Almarai",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10.0.fontSize,
                                      ),
                                    )
                                  : TextSpan(
                                      text: extractDesiredString(
                                        locationDetails!,
                                      ),
                                      style: TextStyle(
                                        height: 1.5.height,
                                        color: const Color(0xfffff5e0),
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Almarai",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10.0.fontSize,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
