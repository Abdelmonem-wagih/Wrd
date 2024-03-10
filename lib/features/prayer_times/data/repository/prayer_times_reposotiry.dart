// ignore_for_file: public_member_api_docs, sort_constructors_first;
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/features/prayer_times/data/data_source/prayer_times_remote_data.dart';
import 'package:wrd/features/prayer_times/domain/entities/prayer_times/prayer_times.dart';
import 'package:wrd/features/prayer_times/domain/repository/basr_prayer_times_repository.dart';

class PrayerTimesRepository extends BasePrayerTimeRepository {
  //final NetworkInof networkInof;
  final BasePrayerTimesRemoteData baseprayerTimesRemoteData;
  //final BasePrayerTimesLocalDataSource baseprayerTimesLocalDataSource;
  PrayerTimesRepository({
    required this.baseprayerTimesRemoteData,
  });

  @override
  Future<Either<Failure, List<PrayerTime>>> getPrayerTimes() async {
    // if (await networkInof.isConnected) {

    // baseprayerTimesLocalDataSource.cachePrayerTimes(resultRemotData);
    try {
      final resultRemotData = await baseprayerTimesRemoteData.getPrayerTimes();
      return Right(resultRemotData);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.errorMessageModel.message),
      );
    }
    /* } else {
      final resultLocalData = await baseprayerTimesLocalDataSource.getLastPrayerTimes();
      try {
        return Right(resultLocalData);
      } on LocalDatabaseException catch (failure) {
        return Left(ServerFailure(failure.message));
      }
    }*/
  }
}
