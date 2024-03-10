import 'package:flutter/material.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/widget/no_internet_widget.dart';

import '../../core/utils/app_colors.dart';
import '../../test_screen/home_prayer_time_widget.dart';
import '../prayer_times/presentoin/widgets/home_screen/almushaf_widget.dart';
import '../prayer_times/presentoin/widgets/home_screen/appbar_widget.dart';
import '../prayer_times/presentoin/widgets/home_screen/islamic_corner_widget.dart';
import '../prayer_times/presentoin/widgets/prayer_times_content/text_widget.dart';
import '../quran_db/presention/pages/quran_chapter.dart';

class OffLineHomeWidget extends StatelessWidget {
  const OffLineHomeWidget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/icon_asr.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarWidget(
                isOffline: true,
              ),
              Center(
                  child: HomePrayerTimeWidget(
                isOffline: true,
                //location: 'gogo',
              )),
              Padding(
                padding: EdgeInsets.only(right: 16.0.width, top: 10.height),
                child: const TextWidget(
                  text: 'المصحف',
                  color: AppColors.baseWhite,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.height, bottom: 10.height),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QuranChapterScreen(),
                          )),
                      child: const AlmushafWidget(
                        name: 'المصحف المكتوب',
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NoInternetWidget()),
                      ),
                      child: const AlmushafWidget(
                        name: 'المصحف الصوتي',
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  right: 16.0,
                ),
                child: Text(
                  "الركن الإسلامي",
                  style: TextStyle(
                    color: AppColors.baseWhite,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Almarai",
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0,
                  ),

                ),
              ),
              const Flexible(
                child: IslamicCornerWidget(
                  location: 'No InterNet Connect',
                  isOffline: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
