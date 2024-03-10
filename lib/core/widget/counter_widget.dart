import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/vibration.dart';
import 'package:wrd/core/services/screen_size_helper.dart';

import '../../features/islamic_corner/aliadieia/presentoin/cubit/selected_duea/selected_duea_bloc.dart';
import '../bloc/true_false/boolCubit.dart';
import '../utils/app_colors.dart';
import '../utils/constance.dart';
import 'circle_progress.dart';



BlocProvider<SelectedDueaBloc> counterWidget({required final listArray, required int counter}) {
  Future<void> triggerVibration() async {
    // Check if the device can vibrate
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator != null && hasVibrator) {
      // Vibrate with default duration
      Vibration.vibrate(duration: 300);
    }
  }
  return BlocProvider(
    create: (context) => SelectedDueaBloc(listArray),
    child: BlocBuilder<SelectedDueaBloc, SelectedDueaState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            triggerVibration();
            counter = counter + 1;
            BlocProvider.of<SelectedDueaBloc>(context).add(AddCounter());
            if (counter == state.duea.count) {
              context.read<BoolCubit>().setTrue();
            }
          },
          child: Container(
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
                      currentProgress: state.count / listArray.count! * 100,
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
                        '/ ${state.duea.count}',
                        style: const TextStyle(
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
  );
}
