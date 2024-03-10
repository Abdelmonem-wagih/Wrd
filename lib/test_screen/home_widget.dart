import 'package:flutter/material.dart';
import 'package:wrd/features/home/offLine_home_widget.dart';
import '../features/home/online_home_widget.dart';
import '../features/prayer_timing/data/timing.dart';
import '../features/prayer_timing/presention/controller/success_widget_controller.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    Key? key,
    this.timing,
    this.isOffline = false,
    this.ayaNumber,
    this.locationLong,
    this.locationLait,
    this.locationDetails,
  }) : super(key: key);
  final Timing? timing;
  final bool isOffline;
  final double? locationLong;
  final double? locationLait;
  final int? ayaNumber;
  final String? locationDetails;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (!isOffline && timing != null) {
      final SuccessWidgetController controller =
          SuccessWidgetController(timing!.data.timings, context);
      return OnlineHomeWidget(
        ayaNumber: ayaNumber!,
        locationLong: locationLong!,
        locationLite: locationLait!,
        controller: controller,
        timing: timing,
        locationDetails: locationDetails!,
      );
    } else {
      return OffLineHomeWidget(
        width: width,
      );
    }
  }
}
