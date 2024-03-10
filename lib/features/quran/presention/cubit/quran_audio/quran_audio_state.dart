part of 'quran_audio_cubit.dart';

abstract class QuranAudioState extends Equatable {
  const QuranAudioState();

  @override
  List<Object> get props => [];
}

class QuranAudioLoadingState extends QuranAudioState {}

class QuranAudioSuccessState extends QuranAudioState {
  final List<QuranAudio> quranAudio;

  const QuranAudioSuccessState({
    required this.quranAudio,
  });
  @override
  List<Object> get props => [quranAudio];
}

class QuranAudioErorrState extends QuranAudioState {
  final String errorMessage;

  const QuranAudioErorrState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
