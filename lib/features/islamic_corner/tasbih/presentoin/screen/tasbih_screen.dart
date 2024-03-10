// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibration/vibration.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';

import '../../../../../core/bloc/true_false/boolCubit.dart';
import '../../../../../core/utils/appbar_widget.dart';
import '../../../../../core/utils/constance.dart';
import '../../../../../core/widget/circle_progress.dart';
import '../../../azkar/presentoin/widgets/group_widget.dart';
import '../../domain/entities/tasbih.dart';
import '../cubit/selected_tasbih/selected_tasbih_bloc.dart';

class TasbihScreen extends StatelessWidget {
  final Tasbih tasbihTest;
  TasbihScreen({super.key, required this.tasbihTest});

  int counter = 0;
  int length = 0;

  Future<void> triggerVibration() async {
    // Check if the device can vibrate
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator != null && hasVibrator) {
      // Vibrate with default duration
      Vibration.vibrate(duration: 500);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, appBarTitle: 'التسبيحات'),
      body: BlocProvider(
        create: (context) => BoolCubit(),
        child: BlocBuilder<BoolCubit, bool>(
          builder: (context, state) {
            return CarouselSlider.builder(
                scrollDirection: Axis.horizontal,
                autoSliderTransitionTime: Duration(milliseconds: 1),
                autoSliderDelay: Duration(milliseconds: 600),
                onSlideChanged: (voi) {
                  length = voi;
                  context.read<BoolCubit>().setFalse();

                  counter = 0;
                },
                enableAutoSlider: state &&
                    tasbihTest.array.length > 1 &&
                    length < tasbihTest.array.length - 1,
                initialPage: 0,
                itemCount: tasbihTest.array.length,
                slideBuilder: (index) {
                  final tasbihArray = tasbihTest.array[index];

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              width: 330.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.radius),
                                ),
                                color: AppColors.primary,
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: RichText(
                                      text: TextSpan(
                                        text: '${tasbihArray!.text}',
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
                                ],
                              ),
                            ),
                            SizedBox(height: 10.height),
                            GroupWidget(
                              len: tasbihTest.array.length,
                              widgetArray: tasbihArray,
                            ),
                          ],
                        ),
                        BlocProvider(
                          create: (context) => SelectedTasbihBloc(tasbihArray),
                          child: BlocBuilder<SelectedTasbihBloc,
                              SelectedTasbihState>(
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: () {
                                  triggerVibration();
                                  counter = counter + 1;

                                  BlocProvider.of<SelectedTasbihBloc>(context)
                                      .add(AddCounter());
                                  if (counter == state.tasbih.count) {
                                    context.read<BoolCubit>().setTrue();
                                  }
                                },
                                child: Container(
                                  width: 1.sw,
                                  height: 0.6.sh,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Image.asset(
                                        'assets/image/frame.png',
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                      Image.asset(
                                        'assets/image/icon_count.png',
                                        height: 100,
                                        width: 100,
                                      ),
                                      Container(
                                        width: 1.sw,
                                        height: 0.6.sh,
                                        padding: kPagePadding,
                                        child: CustomPaint(
                                          foregroundPainter: CircleProgress(
                                            radiusSize: 5.55,
                                            currentProgress: state.count /
                                                tasbihArray.count! *
                                                100,
                                            foregroundColor: AppColors.primary,
                                            backgroundColor:
                                                AppColors.lightYellow,
                                            strokeWidth: 8.sp,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.14,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              state.count.toString(),
                                              style: TextStyle(
                                                color: AppColors.darkTone,
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              '/ ${state.tasbih.count}',
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
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
