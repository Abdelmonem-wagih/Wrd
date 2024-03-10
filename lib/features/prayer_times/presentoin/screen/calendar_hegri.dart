// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/core/utils/app_string.dart';
import 'package:wrd/core/widget/no_internet_widget.dart';
import 'package:wrd/features/prayer_times/presentoin/widgets/calender/build_calender_hegri.dart';
import 'package:wrd/frosted_glass_audio.dart';
import 'package:wrd/main.dart';
import '../../../../core/utils/remove_am_pm.dart';
import '../cubit/prayer_time/prayer_times_cubit.dart';
import '../widgets/calender/menu_calender_hijir.dart';

DateTime now = DateTime.now();
String actualDay = DateFormat('dd-MM-yyyy', 'en').format(now);

class CalendarHegri extends StatefulWidget {
  const CalendarHegri({super.key, this.isOffline = false});
  final bool isOffline;
  @override
  State<CalendarHegri> createState() => _CalendarHegriState();
}

class _CalendarHegriState extends State<CalendarHegri> {
  bool _isContainerVisible = false;
  final ScrollController _scrollController = ScrollController();

  void toggleContainerVisibility() {
    setState(() {
      _isContainerVisible = !_isContainerVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isOffline == true
        ? NoInternetWidget()
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: InkWell(
                onTap: () {
                  CalanderContcetWiget.numberMonthr = 0;
                  context.read<PrayerTimesCubit>().getPrayerTimes();
                  Navigator.of(context).pop();
                },
                child: Icon(
                  isArabic()
                      ? Icons.arrow_back_ios_sharp
                      : Icons.arrow_back_ios_new_sharp,
                ),
              ),
              backgroundColor: AppColors.white,
              iconTheme: IconThemeData(
                color: AppColors.primary,
                size: 20.size,
              ),
              title: Text(
                'التقويم الهجري',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Almarai",
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0.fontSize,
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0.width),
                  child: InkWell(
                      onTap: toggleContainerVisibility,
                      child: SvgPicture.asset(
                          'assets/svg/icon_menu_svgrepo_com_1.svg')),
                ),
              ],
            ),
            body: BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
              builder: (context, state) {
                if (state is PrayerTimesLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PrayerTimesSuccessState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    // حساب الموضع العمودي للعنصر المطلوب
                    int index = state.prayerTimes.indexWhere((prayerTime) =>
                        prayerTime.date!.gregorian!.date == actualDay);
                    double offset =
                        index * 150.0.height; // افترض ارتفاع العنصر 150
                    // التمرير إلى الموضع المناسب باستخدام الـ ScrollController
                    _scrollController.animateTo(
                      offset,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  });
                  return SafeArea(
                    child: Stack(
                      children: [
                        ListView.builder(
                          controller: _scrollController,
                          itemCount: state.prayerTimes.length,
                          itemBuilder: (context, index) {
                            final prayerTime = state.prayerTimes[index];
                            debugPrint('Index => $index');

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0.width, vertical: 15.height),
                              child: Container(
                                width: 363.width,
                                height: 120.height,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.radius),
                                  ),
                                  color: prayerTime.date!.gregorian!.date! ==
                                          actualDay
                                      ? AppColors.second
                                      : Color(0xffecd8bf),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      color:
                                          prayerTime.date!.gregorian!.date! ==
                                                  actualDay
                                              ? AppColors.primary
                                              : Color(0xffd8b080),
                                      height: 41.height,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            prayerTime
                                                .date!.hijri!.weekday!.ar!,
                                            style: TextStyle(
                                              color: AppColors.baseWhite,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Almarai",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16.0.fontSize,
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: AppColors.white,
                                            thickness: 1,
                                            endIndent: 8,
                                            indent: 8,
                                          ),
                                          Text(
                                            '${prayerTime.date!.hijri!.date!} هـ ',
                                            style: TextStyle(
                                                color: AppColors.baseWhite,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Almarai",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16.0.fontSize),
                                          ),
                                          VerticalDivider(
                                            color: AppColors.white,
                                            thickness: 1,
                                            endIndent: 8,
                                            indent: 8,
                                          ),
                                          Text(
                                            '${prayerTime.date!.gregorian!.date!} م',
                                            style: TextStyle(
                                                color: AppColors.baseWhite,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Almarai",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16.0.fontSize),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 10.0.height),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          BuildCalenderHegri(
                                            prayerTime: prayerTime,
                                            prayerTimeName: AppString.Fajr,
                                            prayerTimeTime: removeAmPm(
                                                prayerTime.timings!.fajr!),
                                          ),
                                          BuildCalenderHegri(
                                            prayerTime: prayerTime,
                                            prayerTimeName: AppString.Sunrise,
                                            prayerTimeTime: removeAmPm(
                                                prayerTime.timings!.sunrise!),
                                          ),
                                          BuildCalenderHegri(
                                            prayerTime: prayerTime,
                                            prayerTimeName: AppString.Dhuhr,
                                            prayerTimeTime: removeAmPm(
                                                prayerTime.timings!.dhuhr!),
                                          ),
                                          BuildCalenderHegri(
                                            prayerTime: prayerTime,
                                            prayerTimeName: AppString.Asr,
                                            prayerTimeTime: removeAmPm(
                                                prayerTime.timings!.asr!),
                                          ),
                                          BuildCalenderHegri(
                                            prayerTime: prayerTime,
                                            prayerTimeName: AppString.Maghrib,
                                            prayerTimeTime: removeAmPm(
                                                prayerTime.timings!.maghrib!),
                                          ),
                                          BuildCalenderHegri(
                                            prayerTime: prayerTime,
                                            prayerTimeName: AppString.Isha,
                                            prayerTimeTime: removeAmPm(
                                                prayerTime.timings!.isha!),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Visibility(
                          visible: _isContainerVisible,
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: 120.0.width, top: 20.height),
                            child: FrostedGlassAudio(
                              theHeight: 500.height,
                              theChild: MenuCalenderHijir(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is PrayerTimesErorrState) {
                  return Center(
                    child: Text(
                        'Error loading prayer times: ${state.errorMessage}'),
                  );
                } else {
                  return Container();
                }
              },
            ),
          );
  }
}
