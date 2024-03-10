import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wrd/features/location/data/data_source/loaction_remote_data_source.dart';
import 'package:wrd/features/location/data/repository/location_repository.dart';
import 'package:wrd/features/location/domain/repository/base_Location_repo.dart';
import 'package:wrd/features/location/domain/usecase/location_usecase.dart';
import 'package:wrd/features/location/presention/cubit/location/location_cubit.dart';
import 'package:wrd/features/quran/data/data_source/rewayat_remote_data.dart';
import 'package:wrd/features/quran/data/repository/rewaya_repository.dart';
import 'package:wrd/features/quran/domain/repository/base_rewaya_repository.dart';
import 'package:wrd/features/quran/domain/use_case/rewayat_usecase.dart';
import 'package:wrd/features/quran/presention/cubit/rewaya_cubit/rewaya_cubit.dart';

import '../../features/islamic_corner/aliadieia/data/data_source/duea_romte_data.dart';
import '../../features/islamic_corner/aliadieia/data/repository/duea_repository.dart';
import '../../features/islamic_corner/aliadieia/domain/repository/base_duea_repository.dart';
import '../../features/islamic_corner/aliadieia/domain/use_case/azkar_usecase.dart';
import '../../features/islamic_corner/aliadieia/presentoin/cubit/duea/duea_cubit.dart';
import '../../features/islamic_corner/azkar/data/data_source/azkar_data_source/azkar_romte_data.dart';
import '../../features/islamic_corner/azkar/data/data_source/haju_data_source/haju_romte_data.dart';
import '../../features/islamic_corner/azkar/data/data_source/says_data_source/says_romte_data.dart';
import '../../features/islamic_corner/azkar/data/data_source/tashahhud_data_source/tashahhud_romte_data.dart';
import '../../features/islamic_corner/azkar/data/data_source/tawba_data_source/tawba_romte_data.dart';
import '../../features/islamic_corner/azkar/data/data_source/zkar_data_source/zkar_romte_data.dart';
import '../../features/islamic_corner/azkar/data/repository/azkar_repository/azkar_repository.dart';
import '../../features/islamic_corner/azkar/data/repository/haju_repository/haju_repository.dart';
import '../../features/islamic_corner/azkar/data/repository/says_repository/says_repository.dart';
import '../../features/islamic_corner/azkar/data/repository/tashahhud_repository/tashahhud_repository.dart';
import '../../features/islamic_corner/azkar/data/repository/tawba_repository/tawba_repository.dart';
import '../../features/islamic_corner/azkar/data/repository/zkar_repository/zkar_repository.dart';
import '../../features/islamic_corner/azkar/domain/repository/base_azkar_repository.dart';
import '../../features/islamic_corner/azkar/domain/use_case/azkar_usecase.dart';
import '../../features/islamic_corner/azkar/presentoin/cubit/azkar/azkar_cubit.dart';
import '../../features/islamic_corner/azkar/presentoin/cubit/haju/haju_cubit.dart';
import '../../features/islamic_corner/azkar/presentoin/cubit/says/says_cubit.dart';
import '../../features/islamic_corner/azkar/presentoin/cubit/tashahhud/tashahhud_cubit.dart';
import '../../features/islamic_corner/azkar/presentoin/cubit/tawba/tawba_cubit.dart';
import '../../features/islamic_corner/azkar/presentoin/cubit/zkar/zkar_cubit.dart';
import '../../features/islamic_corner/tasbih/data/data_source/tasbih_romte_data.dart';
import '../../features/islamic_corner/tasbih/data/repository/duea_repository.dart';
import '../../features/islamic_corner/tasbih/domain/repository/base_tasbih_repository.dart';
import '../../features/islamic_corner/tasbih/domain/use_case/tasbih_usecase.dart';
import '../../features/islamic_corner/tasbih/presentoin/cubit/tasbih/tasbih_cubit.dart';
import '../../features/prayer_times/data/data_source/prayer_times_local_data_source.dart';
import '../../features/prayer_times/data/data_source/prayer_times_remote_data.dart';
import '../../features/prayer_times/data/repository/prayer_times_reposotiry.dart';
import '../../features/prayer_times/domain/repository/basr_prayer_times_repository.dart';
import '../../features/prayer_times/domain/use_case/prayer_times_use_case.dart';
import '../../features/prayer_times/presentoin/cubit/prayer_time/prayer_times_cubit.dart';
import '../../features/prayer_timing/presention/bloc/location/location_bloc.dart';
import '../../features/prayer_timing/presention/bloc/timing/timing_bloc.dart';
import '../../features/quran/data/data_source/quran_audio_remote_data.dart';
import '../../features/quran/data/data_source/quran_chapters_remote_data.dart';
import '../../features/quran/data/repository/quran_audio_repository.dart';
import '../../features/quran/data/repository/quran_chapters_repository.dart';
import '../../features/quran/domain/repository/base_quran_audio_repository.dart';
import '../../features/quran/domain/repository/base_quran_chapters_repository.dart';
import '../../features/quran/domain/use_case/quran_audio_usecase.dart';
import '../../features/quran/domain/use_case/quran_chapters_usecase.dart';
import '../../features/quran/presention/cubit/cubit/play_audio_cubit.dart';
import '../../features/quran/presention/cubit/novel.dart';
import '../../features/quran/presention/cubit/quran_audio/quran_audio_cubit.dart';
import '../../features/quran/presention/cubit/quran_chapters/quran_chapters_cubit.dart';
import '../../features/quran_db/data/data_source/quran_chapter_remote_data.dart';
import '../../features/quran_db/data/repository/quran_chapter_repo.dart';
import '../../features/quran_db/domain/repository/base_quran_chapter_repo.dart';
import '../../features/quran_db/domain/usecase/quran_chapter_usecase.dart';
import '../../features/quran_db/presention/cubit/quran_chapter_cubit.dart';
import '../../features/setting/cubit/controller/control_adhan_asr_timing.dart';
import '../../features/setting/cubit/controller/control_adhan_cubit.dart';
import '../../features/setting/cubit/controller/control_adhan_fajr_cubit.dart';
import '../../features/setting/cubit/controller/control_dhuha_prayer_cubit.dart';
import '../../features/setting/cubit/controller/control_evening_prayers_cubit.dart';
import '../../features/setting/cubit/controller/control_morning_prayers_cubit.dart';
import '../../features/setting/cubit/on_off_switch/switch_prayer_time.dart';
import '../../features/setting/widgets/PrayerTimeAlarmsWidget/switch_icon.dart';
import '../../features/setting/cubit/on_off_switch/on_off_azker_evening_cubit.dart';
import '../../features/setting/cubit/on_off_switch/on_off_azker_morning_cubit.dart';
import '../../features/setting/cubit/on_off_switch/on_off_dhuha_cubit.dart';
import '../../features/setting/cubit/on_off_switch/on_off_prayertime_cubit.dart';
import '../bloc/true_false/boolCubit.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(
    () => sharedPreferences,
  );

  //*********************************** Bloc ***********************************//

  sl.registerLazySingleton(() => PrayerTimesCubit(prayerTimesUseCase: sl()));
  sl.registerLazySingleton(() => LocationCubit(locationUseCase: sl()));
  sl.registerLazySingleton(
      () => QuranChaptersCubit(quranChaptersUseCase: sl()));
  sl.registerLazySingleton(() => QuranAudioCubit(quranAudioUseCase: sl()));
  sl.registerLazySingleton(() => RewayaCubit(rewayaUseCase: sl()));
  sl.registerLazySingleton(() => QuranChapterCubit(quranChapterUseCase: sl()));
  sl.registerLazySingleton(() => AzkarCubit(azkarUseCase: sl()));
  sl.registerLazySingleton(() => ZkarCubit(zkarUseCase: sl()));
  sl.registerLazySingleton(() => TawbaCubit(tawbaUseCase: sl()));
  sl.registerLazySingleton(() => HajuCubit(hajuUseCase: sl()));
  sl.registerLazySingleton(() => SaysCubit(saysUseCase: sl()));
  sl.registerLazySingleton(() => TashahhudCubit(tashahhudUseCase: sl()));
  sl.registerLazySingleton(() => DueaCubit(dueaUseCase: sl()));
  sl.registerLazySingleton(() => TasbihCubit(tasbihUseCase: sl()));
  sl.registerLazySingleton(() => AudioPlayerCubit());
  sl.registerLazySingleton(() => OnOffPrayerTimeCubit());
  sl.registerLazySingleton(() => OnOffDhuhaCubit());
  sl.registerLazySingleton(() => OnOffAzkerMorningCubit());
  sl.registerLazySingleton(() => OnOffAzkerEveningCubit());
  sl.registerLazySingleton(() => TimingBloc());
  sl.registerLazySingleton(() => LocationBloc());
  sl.registerLazySingleton(() => NovelCubit());
  sl.registerLazySingleton(() => BoolCubit());
  sl.registerLazySingleton(() => SwitchPrayerCubit());
  sl.registerLazySingleton(() => NumberCubit());

  sl.registerLazySingleton(() => SwitchPrayerTimesCubit());

  sl.registerLazySingleton(
    () => ControlAdhanAsrTimingCubit(
      sharedPreferences.getString('adhanAsr') ?? 'شافعي - مالكي - حنبلي',
      sl<SharedPreferences>(),
    ),
  );
  sl.registerLazySingleton(() => ControlAdhanCubit());
  sl.registerLazySingleton(() => ControlAdhanFajrCubit());

  sl.registerLazySingleton(
    () => ControlDhuhaPrayerCubit(
      sharedPreferences.getString('dhuhaPrayer') ?? '',
      sl<SharedPreferences>(),
    ),
  );
  sl.registerLazySingleton(
    () => ControlEveningPrayersCubit(
      sharedPreferences.getString('eveningPrayers') ?? '',
      sl<SharedPreferences>(),
    ),
  );
  sl.registerLazySingleton(
    () => ControlMorningPrayersCubit(
      sharedPreferences.getString('morningPrayers') ?? '',
      sl<SharedPreferences>(),
    ),
  );

  //*********************************** Use case ***********************************//

  sl.registerLazySingleton(
      () => QuranChapterUseCase(baseQuranChapterRepository: sl()));
  sl.registerLazySingleton(() => LocationUseCase(baseLocationRepository: sl()));
  sl.registerLazySingleton(
      () => PrayerTimesUseCase(basePrayerTimeRepository: sl()));
  sl.registerLazySingleton(
      () => QuranChaptersUseCase(baseQuranChaptersRepository: sl()));
  sl.registerLazySingleton(
      () => QuranAudioUseCase(baseQuranAudioRepository: sl()));
  sl.registerLazySingleton(() => RewayaUseCase(baseRewayaRepository: sl()));
  sl.registerLazySingleton(() => AzkarUseCase(baseAzkerRepository: sl()));
  sl.registerLazySingleton(() => ZkarUseCase(baseZkerRepository: sl()));
  sl.registerLazySingleton(() => TawbaUseCase(baseTawbaRepository: sl()));
  sl.registerLazySingleton(() => HajuUseCase(baseHajuRepository: sl()));
  sl.registerLazySingleton(() => SaysUseCase(baseSaysRepository: sl()));
  sl.registerLazySingleton(
      () => TashahhudUseCase(baseTashahhudRepository: sl()));
  sl.registerLazySingleton(() => DueaUseCase(baseDueaRepository: sl()));
  sl.registerLazySingleton(() => TasbihUseCase(baseTasbihRepository: sl()));

  //*********************************** Repository ***********************************//

  sl.registerLazySingleton<BaseQuranChapterRepository>(
    () => QuranChapterRepository(
      baseQuranChapterRemoteData: sl(),
    ),
  );
  sl.registerLazySingleton<BaseLocationRepository>(
    () => LocationRepository(
      locationRemoteDataDio: sl(),
    ),
  );
  sl.registerLazySingleton<BasePrayerTimeRepository>(
    () => PrayerTimesRepository(
      baseprayerTimesRemoteData: sl(),
    ),
  );
  sl.registerLazySingleton<BaseQuranChaptersRepository>(
    () => QuranChaptersRepository(
      baseQuranChaptersRemoteData: sl(),
    ),
  );

  sl.registerLazySingleton<BaseQuranAudioRepository>(
    () => QuranAudioRepository(
      baseQuranAudioRemoteData: sl(),
    ),
  );
  sl.registerLazySingleton<BaseRewayaRepository>(
    () => RewayatRepository(
      baseRewayatRemoteData: sl(),
    ),
  );
  sl.registerLazySingleton<BaseAzkerRepository>(
    () => AzkarRepository(
      baseAzkarRemoteData: sl(),
    ),
  );
  sl.registerLazySingleton<BaseZkerRepository>(
    () => ZkarRepository(
      baseZkarRemoteData: sl(),
    ),
  );
  sl.registerLazySingleton<BaseTawbaRepository>(
    () => TawbaRepository(
      baseTawbaRemoteData: sl(),
    ),
  );
  sl.registerLazySingleton<BaseHajuRepository>(
    () => HajuRepository(
      baseHajuRemoteData: sl(),
    ),
  );
  sl.registerLazySingleton<BaseSaysRepository>(
    () => SaysRepository(
      baseSaysRemoteData: sl(),
    ),
  );
  sl.registerLazySingleton<BaseTashahhudRepository>(
    () => TashahhudRepository(
      baseTashahhudRemoteData: sl(),
    ),
  );
  sl.registerLazySingleton<BaseDueaRepository>(
    () => DueaRepository(
      baseDueaRemoteDataJson: sl(),
    ),
  );
  sl.registerLazySingleton<BaseTasbihRepository>(
    () => TasbihRepository(
      baseTasbihRemoteDataJson: sl(),
    ),
  );

  //*********************************** DataSource ***********************************//

  sl.registerLazySingleton<BaseQuranChapterRemoteData>(
    () => QuranChapterJsonRemoteDataDio(),
  );
  sl.registerLazySingleton<BaseLocationRemoteData>(
    () => LocationRemoteDataDio(),
  );
  sl.registerLazySingleton<BasePrayerTimesLocalDataSource>(
    () => PrayerTimesLocalDataSource(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<BasePrayerTimesRemoteData>(
    () => PrayerTimesRemoteDataDio(),
  );
  sl.registerLazySingleton<BaseQuranChaptersRemoteData>(
    () => QuranChaptersRemoteDataDio(),
  );

  sl.registerLazySingleton<BaseQuranAudioRemoteData>(
    () => QuranAudioRemoteDataDio(),
  );
  sl.registerLazySingleton<BaseRewayatRemoteData>(
    () => RewayatRemoteDataDio(),
  );
  sl.registerLazySingleton<BaseAzkarRemoteDataJson>(
    () => AzkarRemoteDataJson(),
  );
  sl.registerLazySingleton<BaseZkarRemoteDataJson>(
    () => ZkarRemoteDataJson(),
  );
  sl.registerLazySingleton<BaseTawbaRemoteDataJson>(
    () => TawbaRemoteDataJson(),
  );
  sl.registerLazySingleton<BaseHajuRemoteDataJson>(
    () => HajuRemoteDataJson(),
  );
  sl.registerLazySingleton<BaseSaysRemoteDataJson>(
    () => SaysRemoteDataJson(),
  );
  sl.registerLazySingleton<BaseTashahhudRemoteDataJson>(
    () => TashahhudRemoteDataJson(),
  );
  sl.registerLazySingleton<BaseDueaRemoteDataJson>(
    () => DueaRemoteDataJson(),
  );
  sl.registerLazySingleton<BaseTasbihRemoteDataJson>(
    () => TasbihRemoteDataJson(),
  );

  //Network
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
