part of 'prayer_times_cubit.dart';

abstract class PrayerTimesState extends Equatable {
  const PrayerTimesState();

  @override
  List<Object> get props => [];
}

class PrayerTimesLoadingState extends PrayerTimesState {}

class PrayerTimesSuccessState extends PrayerTimesState {
  final List<PrayerTime> prayerTimes;

  const PrayerTimesSuccessState({required this.prayerTimes});
  @override
  List<Object> get props => [prayerTimes];
}

class PrayerTimesErorrState extends PrayerTimesState {
  final String errorMessage;

  const PrayerTimesErorrState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
