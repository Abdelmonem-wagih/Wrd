// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/vibration.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';
import '../../../../../core/utils/appbar_widget.dart';
import '../../../../../core/utils/constance.dart';
import '../../../../../core/widget/circle_progress.dart';
import '../../domain/entities/tasbih_array.dart';
import '../cubit/selected_tasbih/selected_tasbih_bloc.dart';

class SpecificTasbih extends StatelessWidget {
  final TasbihArray tasbihTest;
  const SpecificTasbih({super.key, required this.tasbihTest});

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
      appBar: appBarWidget(context, appBarTitle: 'المسبحه'),
      body: SingleChildScrollView(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.height),
              padding: EdgeInsets.all(15),
              width: 300.width,
              decoration: BoxDecoration(
                color: Color(0x80e5ba73),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.radius),
                ),
              ),
              child: Center(
                child: Text(
                  tasbihTest.text!,
                  style: TextStyle(
                    height: 1.7.height,
                    color: AppColors.darkTone,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Almarai",
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0.fontSize,
                  ),
                ),
              ),
            ),
            SizedBox(height: 150.height),
            BlocProvider(
              create: (context) => SelectedTasbihBloc(tasbihTest),
              child: BlocBuilder<SelectedTasbihBloc, SelectedTasbihState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      triggerVibration();
                      BlocProvider.of<SelectedTasbihBloc>(context)
                          .add(AddCounter());
                    },
                    child: Container(
                      width: 450.width,
                      height: 450.height,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image.asset(
                            'assets/image/frame.png',
                            height: 400.height,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Image.asset(
                            'assets/image/icon_count.png',
                            height: 100.height,
                            width: 100.width,
                          ),
                          Container(
                            width: 450.width,
                            height: 450.height,
                            padding: kPagePadding,
                            child: CustomPaint(
                              foregroundPainter: CircleProgress(
                                radiusSize: 5.55.radius,
                                currentProgress:
                                    state.count / tasbihTest.count! * 100,
                                foregroundColor: AppColors.primary,
                                backgroundColor: AppColors.lightYellow,
                                strokeWidth: 8.width,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 100.height,
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
      ),
    );
  }
}
