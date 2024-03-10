part of 'quran_chapter_cubit.dart';

@immutable
abstract class QuranChapterState extends Equatable {
  const QuranChapterState();
  @override
  List<Object> get props => [];
}

class QuranChapterLoadingState extends QuranChapterState {}

class QuranChapterSuccessState extends QuranChapterState {
  final List<QuranChapter> quranChapter;

  const QuranChapterSuccessState({required this.quranChapter});
  @override
  List<Object> get props => [quranChapter];
}

class QuranChapterErorrState extends QuranChapterState {
  final String errorMessage;

  const QuranChapterErorrState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
