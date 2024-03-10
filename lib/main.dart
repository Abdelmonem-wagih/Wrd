// ignore_for_file: unnecessary_new, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wrd/core/services/alarm_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/features/location/presention/cubit/location/location_cubit.dart';
import 'package:wrd/features/quran/presention/cubit/rewaya_cubit/rewaya_cubit.dart';
import 'package:wrd/features/setting/cubit/controller/control_adhan_fajr_cubit.dart';
import 'package:wrd/generated/l10n.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'features/quran/presention/cubit/novel.dart';
import 'features/setting/controller/muezzin_preferences.dart';
import 'features/setting/cubit/controller/control_adhan_asr_timing.dart';
import 'features/setting/cubit/controller/control_adhan_cubit.dart';
import 'features/setting/cubit/controller/control_dhuha_prayer_cubit.dart';
import 'features/setting/cubit/controller/control_evening_prayers_cubit.dart';
import 'features/setting/cubit/controller/control_morning_prayers_cubit.dart';
import 'features/setting/cubit/on_off_switch/on_off_azker_evening_cubit.dart';
import 'features/setting/cubit/on_off_switch/on_off_azker_morning_cubit.dart';
import 'features/setting/cubit/on_off_switch/on_off_dhuha_cubit.dart';
import 'features/setting/cubit/on_off_switch/on_off_prayertime_cubit.dart';
import 'core/services/services_locator.dart' as di;
import 'core/widget/splash_screen.dart';
import 'features/islamic_corner/aliadieia/presentoin/cubit/duea/duea_cubit.dart';
import 'features/islamic_corner/azkar/presentoin/cubit/azkar/azkar_cubit.dart';
import 'features/islamic_corner/azkar/presentoin/cubit/haju/haju_cubit.dart';
import 'features/islamic_corner/azkar/presentoin/cubit/says/says_cubit.dart';
import 'features/islamic_corner/azkar/presentoin/cubit/tashahhud/tashahhud_cubit.dart';
import 'features/islamic_corner/azkar/presentoin/cubit/tawba/tawba_cubit.dart';
import 'features/islamic_corner/azkar/presentoin/cubit/zkar/zkar_cubit.dart';
import 'features/islamic_corner/tasbih/presentoin/cubit/tasbih/tasbih_cubit.dart';
import 'features/prayer_times/presentoin/cubit/prayer_time/prayer_times_cubit.dart';
import 'features/prayer_timing/presention/bloc/location/location_bloc.dart';
import 'features/prayer_timing/presention/bloc/timing/timing_bloc.dart';
import 'features/quran/presention/cubit/cubit/play_audio_cubit.dart';
import 'features/quran/presention/cubit/quran_audio/quran_audio_cubit.dart';
import 'features/quran/presention/cubit/quran_chapters/quran_chapters_cubit.dart';
import 'features/quran_db/presention/cubit/quran_chapter_cubit.dart';

import 'features/setting/cubit/on_off_switch/switch_prayer_time.dart';
import 'features/setting/widgets/PrayerTimeAlarmsWidget/switch_icon.dart';
import 'onbording/onbording_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  AlarmHelper.createGazaAlarm();
  tz.initializeTimeZones();
  // HydratedBloc.storage = await HydratedStorage.build(
  //   storageDirectory: await getApplicationDocumentsDirectory(),
  // );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
debugPrint('MuezzinPreferences=>>>>>>>>>>>>>>>>  ${await MuezzinPreferences.getMuezzin()}');
  await di.init();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(MyApp(isFirstTime: isFirstTime));

  runApp(
    MyApp(isFirstTime: isFirstTime),
  );
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<PrayerTimesCubit>(
          create: (context) => di.sl<PrayerTimesCubit>()..getPrayerTimes(),
        ),
        BlocProvider<LocationCubit>(
          create: (context) => di.sl<LocationCubit>(),
        ),
        BlocProvider<QuranChaptersCubit>(
          create: (context) => di.sl<QuranChaptersCubit>()..getQuranChapters(),
        ),
        BlocProvider<QuranChapterCubit>(
          create: (context) => di.sl<QuranChapterCubit>()..fetchQuranChapters(),
        ),
        BlocProvider<TimingBloc>(
          create: (context) => di.sl<TimingBloc>(),
        ),
        BlocProvider<QuranAudioCubit>(
          create: (context) => di.sl<QuranAudioCubit>()..getQuranAudio(),
        ),
        BlocProvider<RewayaCubit>(
          create: (context) => di.sl<RewayaCubit>()..getRewayat(),
        ),
        BlocProvider<AzkarCubit>(
          create: (context) => di.sl<AzkarCubit>()..getAllAzkar(),
        ),
        BlocProvider<ZkarCubit>(
          create: (context) => di.sl<ZkarCubit>()..getAllZkar(),
        ),
        BlocProvider<TawbaCubit>(
          create: (context) => di.sl<TawbaCubit>()..getAllTawba(),
        ),
        BlocProvider<HajuCubit>(
          create: (context) => di.sl<HajuCubit>()..getAllHaju(),
        ),
        BlocProvider<SaysCubit>(
          create: (context) => di.sl<SaysCubit>()..getAllSays(),
        ),
        BlocProvider<TashahhudCubit>(
          create: (context) => di.sl<TashahhudCubit>()..getAllTashahhud(),
        ),
        BlocProvider<DueaCubit>(
          create: (context) => di.sl<DueaCubit>()..getAllAliadieia(),
        ),
        BlocProvider<TasbihCubit>(
          create: (context) => di.sl<TasbihCubit>()..getAllTasbih(),
        ),
        BlocProvider<AudioPlayerCubit>(
          create: (context) => di.sl<AudioPlayerCubit>(),
        ),
        BlocProvider<OnOffPrayerTimeCubit>(
          create: (context) => di.sl<OnOffPrayerTimeCubit>(),
        ),
        BlocProvider<OnOffDhuhaCubit>(
          create: (context) => di.sl<OnOffDhuhaCubit>(),
        ),
        BlocProvider<OnOffAzkerMorningCubit>(
          create: (context) => di.sl<OnOffAzkerMorningCubit>(),
        ),
        BlocProvider<OnOffAzkerEveningCubit>(
          create: (context) => di.sl<OnOffAzkerEveningCubit>(),
        ),
        BlocProvider<ControlAdhanAsrTimingCubit>(
          create: (context) => di.sl<ControlAdhanAsrTimingCubit>(),
        ),
        BlocProvider<ControlAdhanCubit>(
          create: (context) => di.sl<ControlAdhanCubit>(),
        ),
        BlocProvider<ControlAdhanFajrCubit>(
          create: (context) => di.sl<ControlAdhanFajrCubit>(),
        ),
        BlocProvider<ControlDhuhaPrayerCubit>(
          create: (context) => di.sl<ControlDhuhaPrayerCubit>(),
        ),
        BlocProvider<ControlEveningPrayersCubit>(
          create: (context) => di.sl<ControlEveningPrayersCubit>(),
        ),
        BlocProvider<ControlMorningPrayersCubit>(
          create: (context) => di.sl<ControlMorningPrayersCubit>(),
        ),
        BlocProvider<LocationBloc>(
          create: (context) => di.sl<LocationBloc>(),
        ),

        BlocProvider<NovelCubit>(
          create: (context) => di.sl<NovelCubit>(),
        ),
        BlocProvider<SwitchPrayerTimesCubit>(
          create: (context) => di.sl<SwitchPrayerTimesCubit>(),
        ),
        BlocProvider<NumberCubit>(
          create: (context) => di.sl<NumberCubit>(),
        ),

      ],
      child: ScreenUtilInit(
        designSize: Size(414, 896),
        builder: (context, child) {
          debugPrint('<<<<<<<<<<<<=== inSide Main ===>>>>>>>>>>>>>');
          return MaterialApp(
            theme: ThemeData(
              scrollbarTheme: ScrollbarThemeData(
                radius: Radius.circular(8.0),
                thickness: MaterialStateProperty.all<double>(8.0),
                thumbColor: MaterialStateProperty.all<Color>(
                    AppColors.primary), // Set the thumb color
              ),
            ),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: Locale('ar'),
            title: 'وِرْد',
            debugShowCheckedModeBanner: false,
            color: Colors.white,
            home:
            //LocationScreenTest(),
            isFirstTime ? OnboardingScreen() : SplashScreen(),
          );
        },
      ),
    );
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
