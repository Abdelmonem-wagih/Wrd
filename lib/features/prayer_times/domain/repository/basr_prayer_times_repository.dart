import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/failure.dart';

import '../entities/prayer_times/prayer_times.dart';

abstract  class  BasePrayerTimeRepository{
   Future<Either<Failure,List<PrayerTime>>> getPrayerTimes();
}