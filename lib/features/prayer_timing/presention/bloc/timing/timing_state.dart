import 'package:equatable/equatable.dart';
import '../../../data/timing.dart';
import '../../controller/failuer.dart';

abstract class TimingState extends Equatable {
  const TimingState();
}

class TimingInitial extends TimingState {
  @override
  List<Object> get props => [];
}

class PrayerLoadedState extends TimingState {
  final bool showPrayerText;
  final String currentPrayerTime;

  const PrayerLoadedState({
    required this.showPrayerText,
    required this.currentPrayerTime,
  });

  @override
  List<Object> get props => [showPrayerText, currentPrayerTime];
}

class TimingLoading extends TimingState {
  @override
  List<Object> get props => [];
}

class OfflineData extends TimingState {
  @override
  List<Object> get props => [];
}

class TimingLoaded extends TimingState {
  final Timing timing;
  final int randomNumber;

  const TimingLoaded(this.timing, this.randomNumber);

  @override
  List<Object> get props => [timing, randomNumber];
}

class TimingFailed extends TimingState {
  final Failure? failure;

  const TimingFailed(this.failure);

  @override
  List<Object> get props => [failure!];
}
