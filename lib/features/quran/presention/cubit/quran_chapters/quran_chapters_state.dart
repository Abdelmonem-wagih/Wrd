part of 'quran_chapters_cubit.dart';

abstract class QuranChaptersState extends Equatable {
  const QuranChaptersState();

  @override
  List<Object> get props => [];
}

class QuranChaptersLoadingState extends QuranChaptersState {}

class QuranChaptersSuccessState extends QuranChaptersState {
  final List<QuranChapters> quranChapters;

  const QuranChaptersSuccessState({required this.quranChapters});
  @override
  List<Object> get props => [quranChapters];
}

class QuranChaptersErorrState extends QuranChaptersState {
  final String errorMessage;

  const QuranChaptersErorrState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
