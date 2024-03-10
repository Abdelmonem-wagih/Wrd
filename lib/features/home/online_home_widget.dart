import 'package:flutter/material.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/test_screen/aya_of_day.dart';
import '../../core/utils/app_colors.dart';
import '../../test_screen/home_prayer_time_widget.dart';
import '../prayer_times/presentoin/widgets/home_screen/almushaf_widget.dart';
import '../prayer_times/presentoin/widgets/home_screen/appbar_widget.dart';
import '../prayer_times/presentoin/widgets/home_screen/islamic_corner_widget.dart';
import '../prayer_times/presentoin/widgets/prayer_times_content/text_widget.dart';
import '../prayer_timing/data/timing.dart';
import '../prayer_timing/presention/controller/success_widget_controller.dart';
import '../quran/presention/pages/quranAudio/quran_audio_chapters_screen.dart';
import '../quran_db/presention/pages/quran_chapter.dart';

class OnlineHomeWidget extends StatelessWidget {
  const OnlineHomeWidget({
    super.key,
    required this.controller,
    required this.timing,
    required this.ayaNumber,
    required this.locationLite,
    required this.locationLong, required this.locationDetails,
  });

  final double locationLite;
  final double locationLong;
  final SuccessWidgetController controller;
  final Timing? timing;
  final int ayaNumber;
  final String locationDetails;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              controller.setBackgroundImage(),
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarWidget(prayerTime: timing!),
                Center(
                  child: HomePrayerTimeWidget(
                  //  location: location,
                    latitude: locationLite,
                    longitude: locationLong,
                    locationDetails: locationDetails,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16.0.width, top: 30.height),
                  child: TextWidget(
                    text: 'المصحف',
                    color: AppColors.baseWhite,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0.fontSize,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.height,
                    bottom: 30.height,
                  ),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuranChapterScreen(),
                            ),
                          ),
                          child: const AlmushafWidget(
                            name: 'المصحف المكتوب',
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const QuranAudioChaptersScreen(),
                            ),
                          ),
                          child: const AlmushafWidget(
                            name: 'المصحف الصوتي',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 16.0.width,
                  ),
                  child: Text(
                    "الركن الإسلامي",
                    style: TextStyle(
                      color: AppColors.baseWhite,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Almarai",
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0.fontSize,
                    ),
                  ),
                ),
                IslamicCornerWidget(
                  location: locationDetails,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 16.0.width,
                    top: 30.height,
                  ),
                  child: Text(
                    'التذكير اليومي',
                    style: TextStyle(
                      color: AppColors.baseWhite,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Almarai",
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0.fontSize,
                    ),
                  ),
                ),
                Center(
                  child: AyaOfDay(
                    ayaNumber: ayaNumber,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
