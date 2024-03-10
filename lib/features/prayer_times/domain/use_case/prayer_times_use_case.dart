// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/core/usecases/usecase.dart';
import 'package:wrd/features/prayer_times/domain/entities/prayer_times/prayer_times.dart';
import 'package:wrd/features/prayer_times/domain/repository/basr_prayer_times_repository.dart';

class PrayerTimesUseCase extends UseCase<List<PrayerTime>, NoParams> {
  final BasePrayerTimeRepository basePrayerTimeRepository;
  PrayerTimesUseCase({
    required this.basePrayerTimeRepository,
  });
  @override
  Future<Either<Failure, List<PrayerTime>>> call(NoParams params) async {
    return await basePrayerTimeRepository.getPrayerTimes();
  }
}
