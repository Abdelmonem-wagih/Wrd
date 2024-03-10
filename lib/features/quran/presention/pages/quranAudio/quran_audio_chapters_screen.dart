// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/core/widget/loading_widget.dart';
import 'package:wrd/features/quran/presention/cubit/quran_audio/quran_audio_cubit.dart';
import 'package:wrd/features/quran/presention/cubit/quran_chapters/quran_chapters_cubit.dart';
import 'package:wrd/main.dart';
import '../../controller/dialog/search_dialog.dart';
import '../../cubit/novel.dart';
import '../../widget/menu_readers.dart';
import '../../widget/quran_audio_chapter_widget.dart';

class QuranAudioChaptersScreen extends StatefulWidget {
  const QuranAudioChaptersScreen({
    super.key,
  });

  @override
  State<QuranAudioChaptersScreen> createState() =>
      _QuranAudioChaptersScreenState();
}

class _QuranAudioChaptersScreenState extends State<QuranAudioChaptersScreen> {
  static int? surahTotal = 114;
  dynamic resultOfAlertDialog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            isArabic()
                ? Icons.arrow_back_ios_sharp
                : Icons.arrow_back_ios_new_sharp,
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: AppColors.primary,
          size: 20.size,
        ),
        title: Text(
          'المصحف الصوتي',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            fontFamily: "Almarai",
            fontStyle: FontStyle.normal,
            fontSize: 20.0.fontSize,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 15.0.width),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => SearchDialog(),
                );
              },
              child: SvgPicture.asset('assets/svg/icon_filter.svg'),
            ),
          ),
        ],
      ),
      body: BlocBuilder<QuranChaptersCubit, QuranChaptersState>(
        builder: (context, stateChapters) {
          if (stateChapters is QuranChaptersLoadingState) {
            debugPrint("QuranChaptersLoadingState");
            return Center(
              child: LoadingWidget(),
            );
          } else if (stateChapters is QuranChaptersSuccessState) {
            debugPrint("QuranChaptersSuccessState");
            return BlocBuilder<QuranAudioCubit, QuranAudioState>(
              builder: (context, stateAudio) {
                if (stateAudio is QuranAudioLoadingState) {
                  return Center(
                    child: LoadingWidget(),
                  );
                } else if (stateAudio is QuranAudioSuccessState) {
                  return Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Image.asset(
                          'assets/image/helf_down_frame.png',
                          //height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: 330.width,
                            height: 48.height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.radius),
                              ),
                              color: const Color(0xffefe2ce),
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: SvgPicture.asset(
                                        'assets/svg/icon_search.svg'),
                                  ),
                                  10.verticalSpace,
                                  Text(
                                    'البحث في المصحف الصوتي',
                                    style: TextStyle(
                                      color: Color(0x80634e36),
                                      fontWeight: FontWeight.w300,
                                      fontFamily: "Almarai",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16.0.fontSize,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            child: BlocBuilder<NovelCubit, String>(
                              builder: (context, isChosen) {
                                surahTotal = stateAudio
                                    .quranAudio[
                                        ReaderContcetWiget.numberReaderr]
                                    .moshafs[0]!
                                    .surahTotal!;
                                return ListView.builder(
                                  itemCount: surahTotal,
                                  itemBuilder: (context, index) {
                                    debugPrint('surahTotal=>>> $surahTotal');
                                    // to convert list of string to list of integer
                                    List<int> numbers = stateAudio
                                        .quranAudio[
                                            ReaderContcetWiget.numberReaderr]
                                        .moshafs[0]!
                                        .surahList!
                                        .split(',')
                                        .map((item) => int.parse(item))
                                        .toList();

                                    final quranChapters = stateChapters
                                        .quranChapters[numbers[index] - 1];

                                    final quranAudio = stateAudio
                                        .quranAudio[
                                            ReaderContcetWiget.numberReaderr]
                                        .moshafs[0]!
                                        .server!;
                                    final quranAudioState =
                                        stateAudio.quranAudio[
                                            ReaderContcetWiget.numberReaderr];

                                    String urlMp3 =
                                        isChosen == '' ? quranAudio : isChosen;
                                    debugPrint(
                                        ' urlMp3======>>>>>>>>>>> $urlMp3');

                                    return QuranAudioChapterWidget(
                                      quranAudio: quranAudioState,
                                      urlMp3: urlMp3,
                                      quranChapters: quranChapters,
                                      index: index,
                                      surahNumber: numbers[index],
                                      numberUrls: numbers,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (stateAudio is QuranAudioErorrState) {
                  return Center(
                    child: Text(
                        'Error loading prayer times: ${stateAudio.errorMessage}'),
                  );
                } else {
                  return Container();
                }
              },
            );
          } else if (stateChapters is QuranChaptersErorrState) {
            return Center(
              child: Text(
                  'Error loading prayer times: ${stateChapters.errorMessage}'),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
