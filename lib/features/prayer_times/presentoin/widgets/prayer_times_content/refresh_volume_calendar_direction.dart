// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/features/prayer_times/presentoin/screen/calendar_hegri.dart';

import '../../screen/qabli.dart';

class RefreshVolumeCalendarDirection extends StatelessWidget {
  const RefreshVolumeCalendarDirection(
      {super.key, this.isOffline = false, required this.location,});
  final bool isOffline;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 50.height),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QiblahScreen(location: location),
                )),
            child: SizedBox(
              width: 35.width,
              height: 35.height,
              child: SvgPicture.asset('assets/svg/icon_direction_45_1.svg'),
            ),
          ),
          SizedBox(width: 30.width),
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CalendarHegri(isOffline: isOffline),
                )),
            child: SizedBox(
              width: 35.width,
              height: 35.height,
              child: SvgPicture.asset(
                  'assets/svg/icon_calendar_svgrepo_com_1.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
