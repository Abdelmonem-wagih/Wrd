// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/vibration.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

import '../../../../../core/utils/appbar_widget.dart';
import '../../../../../core/utils/constance.dart';
import '../../../../../core/widget/circle_progress.dart';
import '../cubit/selected_azker/selected_azker_bloc.dart';
import '../widgets/group_widget.dart';

class AzkarScreen extends StatefulWidget {
  final azkarTest;

  const AzkarScreen({super.key, required this.azkarTest});

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  bool _changepage = false;
  int counter = 0;
  int length = 0;

  Future<void> triggerVibration() async {
    // Check if the device can vibrate
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator != null && hasVibrator) {
      // Vibrate with default duration
      Vibration.vibrate(duration: 300);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, appBarTitle: widget.azkarTest.category!),
      body: CarouselSlider.builder(
        scrollDirection: Axis.horizontal,
        autoSliderTransitionTime: Duration(milliseconds: 1),
        autoSliderDelay: Duration(milliseconds: 600),
        onSlideChanged: (voi) {
          setState(() {
            length = voi;
            _changepage = false;
            counter = 0;
          });
        },
        enableAutoSlider: _changepage &&
            widget.azkarTest.array!.length> 1 &&
            length < widget.azkarTest.array!.length- 1,
        initialPage: 0,
        itemCount: widget.azkarTest.array!.length,
        slideBuilder: (index) {
          final askarArray = widget.azkarTest.array![index];
          // final askarArray = widget.azkarTest.array![4];
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.size),
                      margin: EdgeInsets.all(10.size),
                      width: 320.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.radius),
                        ),
                        color: AppColors.primary,
                      ),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: '${askarArray.text}',
                            style: TextStyle(
                              height: 1.7.height,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Almarai",
                              fontStyle: FontStyle.normal,
                              fontSize: 20.0.fontSize,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 25.height),
                    GroupWidget(
                      widgetArray: askarArray,
                      len: widget.azkarTest.array!.length,
                    ),
                    SizedBox(height: 25.height),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.width),
                      child: Text(
                        '${askarArray.bless}',
                        style: TextStyle(
                          color: AppColors.darkTone,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Almarai",
                          fontStyle: FontStyle.normal,
                          fontSize: 17.0.fontSize,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                //counterWidget(listArray: askarArray, counter: counter),

                BlocProvider(
                  create: (context) => SelectedAzkerBloc(askarArray),
                  child: BlocBuilder<SelectedAzkerBloc, SelectedAzkerState>(
                    builder: (context, state) {
                      return counterWidget(context, state, askarArray);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  GestureDetector counterWidget(
      BuildContext context, SelectedAzkerState state, askarArray) {
    return GestureDetector(
      onTap: () {
        triggerVibration();
        counter = counter + 1;
        BlocProvider.of<SelectedAzkerBloc>(context).add(AddCounter());
        if (counter == state.azker.count) {
          setState(() {
            _changepage = true;
          });
        }
      },
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              left: 0.width,
              bottom: 0.height,
              width: 200.width,
              child: Image.asset('assets/image/helf_left_frame.png'),
            ),
            Image.asset(
              'assets/image/icon_count.png',
              height: 100.height,
              width: 100.width,
            ),
            Container(
              width: 360.width,
              height: 465.height,
              padding: kPagePadding,
              child: CustomPaint(
                foregroundPainter: CircleProgress(
                  radiusSize: 5.6.radius,
                  currentProgress: state.count / askarArray.count! * 100,
                  foregroundColor: AppColors.primary,
                  backgroundColor: AppColors.lightYellow,
                  strokeWidth: 8.width,
                ),
              ),
            ),
            Positioned(
              bottom: 130.height,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    state.count.toString(),
                    style: TextStyle(
                      color: AppColors.darkTone,
                      fontSize: 25.fontSize,
                    ),
                  ),
                  Text(
                    '/ ${state.azker.count}',
                    style: TextStyle(
                      color: AppColors.darkTone,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}