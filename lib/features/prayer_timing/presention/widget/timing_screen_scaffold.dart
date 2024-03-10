import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/features/prayer_timing/presention/widget/success_widget.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constance.dart';
import '../../../../core/widget/loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../main.dart';
import '../bloc/location/location_bloc.dart';
import '../bloc/timing/timing_bloc.dart';
import '../bloc/timing/timing_state.dart';
import 'failure_widget.dart';

class TimingScreenScaffold extends StatelessWidget {
  const TimingScreenScaffold({super.key, required this.location, });
 final String location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TimingBloc, TimingState>(
        builder: (context, state) {
          debugPrint('TimingBloc=>>>>>>>>>>>> $state');
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(10),
                height: 50,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Row(
                    children: [
                      Icon(
                        color: AppColors.primary,
                        size: 20.size,
                        textDirection: TextDirection.ltr,
                        isArabic()
                            ? Icons.arrow_forward_ios
                            : Icons.arrow_back_ios_new_sharp,
                      ),
                      SizedBox(width: 8.width),
                      Text(
                        S.of(context).prayerPage,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Almarai",
                          fontStyle: FontStyle.normal,
                          fontSize: 20.fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.height),
              Expanded(
                child: AnimatedSwitcher(
                  duration: kAnimationDuration,
                  reverseDuration: Duration.zero,
                  switchInCurve: kAnimationCurve,
                  child: (state is TimingLoading)
                      ? const LoadingWidget()
                      : (state is TimingLoaded)
                          ? SuccessWidget(
                              state.timing,
                              location: location,
                            )
                          : (state is TimingFailed)
                              ? SafeArea(
                                  child: FailureWidget(
                                    state.failure!,
                                    () {
                                      BlocProvider.of<LocationBloc>(context)
                                          .initLocation();
                                    },
                                    withAppbar: true,
                                  ),
                                )
                              : Container(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
