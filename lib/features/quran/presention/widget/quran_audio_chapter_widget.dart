import 'package:flutter/material.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/core/utils/app_string.dart';
import 'package:wrd/features/quran/domain/entities/quranAudio/quran_audio.dart';
import 'package:wrd/features/quran/domain/entities/quran_chapters.dart';
import 'package:wrd/features/quran/presention/pages/quranAudio/quran_audio_screen.dart';

class QuranAudioChapterWidget extends StatelessWidget {
  const QuranAudioChapterWidget(
      {super.key,
      required this.quranChapters,
      required this.index,
      required this.urlMp3,
      required this.quranAudio,
      required this.surahNumber,
      required this.numberUrls});

  final QuranChapters quranChapters;
  final int index;
  final String urlMp3;
  final QuranAudio quranAudio;
  final int surahNumber;
  final List<int> numberUrls;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Text(
          quranChapters.nameArabic!,
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w400,
            fontFamily: "ae_Granada",
            fontStyle: FontStyle.normal,
            fontSize: 30.0.fontSize,
          ),
        ),
        title: Text(
          textDirection: TextDirection.ltr,
          quranChapters.nameArabic!,
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            fontFamily: "Almarai",
            fontStyle: FontStyle.normal,
            fontSize: 18.0.fontSize,
          ),
        ),
        subtitle: Text(
          '(${quranChapters.versesCount})'
          ' ${quranChapters.revelationPlace == 'makkah' ? AppString.Makkah : AppString.Madinah}',
          textDirection: TextDirection.ltr,
        ),
        trailing: Container(
          height: 50.height,
          width: 50.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/image/icon_shape.png',
              ),
            ),
          ),
          child: Center(
            child: Text(
              '$surahNumber',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontFamily: "Almarai",
                fontStyle: FontStyle.normal,
                fontSize: 14.0.fontSize,
              ),
            ),
          ),
        ),
        onTap: () {
          debugPrint('quranAudioMenu=======>>>>>>$urlMp3');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AudioPlayerScreen(
                quranAudioState: quranAudio,
                urlMp3: urlMp3,
                index: index,
                numberUrls: numberUrls,
              ),
            ),
          );
        });
  }
}
