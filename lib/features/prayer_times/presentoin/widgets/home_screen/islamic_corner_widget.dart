import 'package:flutter/material.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/features/prayer_times/presentoin/screen/qabli.dart';
import 'package:wrd/frosted_glass.dart';

import '../../../../../core/widget/no_internet_widget.dart';
import '../../../../islamic_corner/aliadieia/presentoin/screen/all_of_aliadieia_screen.dart';
import '../../../../islamic_corner/azkar/presentoin/screen/azkar_almuslim.dart';
import '../../../../islamic_corner/tasbih/presentoin/screen/all_of_tasbih_screen.dart';
import '../../../../tafser_bot/page/splash_bot_screen.dart';
import '../../screen/calendar_hegri.dart';

class IslamicCornerWidget extends StatelessWidget {
  const IslamicCornerWidget({
    super.key,

     this.isOffline = false, required this.location,
  });
  final String location;
  final bool isOffline;


  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> gridItems = [
      {
        'text': 'ورد بوت',
        'route': isOffline? const NoInternetWidget() : const SplashBotScreen(),
      },
      {
        'text': 'المسبحة',
        'route': const AllOfTasbihiScreen(),
      },
      {
        'text': 'جميع الاذكار',
        'route': AzkarAlmuslim(),
      },
      {
        'text': 'التقويم الهجري',
        'route': isOffline? const NoInternetWidget() : const CalendarHegri(),
      },
      {
        'text': 'القبلة',
        'route':isOffline? const NoInternetWidget() : QiblahScreen(location: location),
      },
      {
        'text': 'الأدعية',
        'route': const AllOfAliadieiaScreen(),
      },
    ];
    return Padding(
      padding:  EdgeInsets.only(
        left: 10.0.width,
        right: 10.0.width,
        top: 10.0.height,
      ),
      child: SizedBox(
        height:220.height,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          // Disables GridView's scroll

          itemCount: gridItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            mainAxisExtent: 100,
          ),
          itemBuilder: (BuildContext context, int index) {
            final item = gridItems[index];

            return InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => item['route'],
              )),
              child: FrostedGlassBox(
                theHeight:11.height,
                theWidth:25.width,
                theBoraderLeft: 10,
                theBoraderRight: 10,
                theChild: Text(
                  item['text'],
                  style:  TextStyle(
                      color: AppColors.baseWhite,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Almarai",
                      fontStyle: FontStyle.normal,
                      fontSize: 17.0.fontSize,),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
