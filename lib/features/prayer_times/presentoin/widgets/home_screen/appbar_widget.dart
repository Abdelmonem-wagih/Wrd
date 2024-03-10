// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/widget/no_internet_widget.dart';
import 'package:wrd/features/prayer_timing/data/timing.dart';
import 'package:wrd/features/setting/screens/setting.dart';
import 'package:wrd/main.dart';

class AppBarWidget extends StatelessWidget {
  AppBarWidget({super.key, this.prayerTime, this.isOffline = false});

  final Timing? prayerTime;
  final bool isOffline;

  final _today = HijriCalendar.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.size),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isOffline == true
              ? Text(
                  _today.toFormat(
                    "MMMM dd yyyy",
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Almarai",
                    fontStyle: FontStyle.normal,
                    fontSize: 17.0.fontSize,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${prayerTime!.data.date.hijri.day} '
                      '${prayerTime!.data.date.hijri.month.ar} ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Almarai",
                        fontStyle: FontStyle.normal,
                        fontSize: 17.0,
                      ),
                    ),
                    SizedBox(height: 3.height),
                    Text(
                      '${prayerTime!.data.date.hijri.year}${isArabic() ? ' هـ' : ''} ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Almarai",
                        fontStyle: FontStyle.normal,
                        fontSize: 17.0.fontSize,
                      ),
                    ),
                  ],
                ),
          Padding(
            padding: EdgeInsets.only(
              left: isArabic() ? 30.0.width : 0,
              right: isArabic() ? 0 : 70.0.width,
            ),
            child: SvgPicture.asset('assets/svg/icon_logo.svg'),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => isOffline
                    ? NoInternetWidget()
                    :
                         SettingScreen(
                          prayerTime: prayerTime!,

                      ),
              ),
            ),
            child: Icon(
              Icons.settings,
              color: Colors.white,
              size: 35.size,
            ),
          ),
        ],
      ),
    );
  }
}
/*
 Consumer(builder: (context, ref, _) {
          final state = ref.watch(NotificationsSubscriptionNotifier.provider);
          final notifier =
          ref.read(NotificationsSubscriptionNotifier.provider.notifier);
          return state.when(
            data: (isActive) {
              return IconButton(onPressed: () async {

                await notifier.toggle(widget.prayerTime);

              },
                  icon: Consumer(builder: (context, ref, _) {
                    return Icon(
                      isActive ? Icons.notifications : Icons.notification_add,
                      color: isActive ? Colors.amberAccent : null,
                    );
                  }));
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(D.sizeSmall),
            ),
            error: (e) => IconButton(
                onPressed: () async {
                  "Refresh the notification subscription fetching".log();
                  await ref
                      .read(NotificationsSubscriptionNotifier.provider.notifier)
                      .fetchData();
                },
                icon: Icon(
                  Icons.refresh,
                  size: D.size3XLarge,
                  color: context.colorScheme.error,
                )),
          );
        }),
**/
