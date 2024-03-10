import 'package:flutter/material.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/core/utils/app_string.dart';

import '../../domain/entities/quran_chapter.dart';
import '../pages/quran_db_screen.dart';

class QuranChapterWidget extends StatelessWidget {
  const QuranChapterWidget(
      {super.key, required this.quranChapter, required this.index, this.quranSorhaName});
  final List<QuranChapter>? quranSorhaName;

  final QuranChapter quranChapter;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Text(
          quranChapter.nameArabic!,
          style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w400,
              fontFamily: "ae_Granada",
              fontStyle: FontStyle.normal,
              fontSize: 30.0),
        ),
        title: Text(
          textDirection: TextDirection.ltr,
          quranChapter.nameArabic!,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            fontFamily: "Almarai",
            fontStyle: FontStyle.normal,
            fontSize: 18.0,
          ),
        ),
        subtitle: Text(
          textDirection: TextDirection.ltr,
          '(${quranChapter.versesCount})'
          ' ${quranChapter.revelationPlace == 'makkah' ? AppString.Makkah : AppString.Madinah}',
        ),
        trailing: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/image/icon_shape.png',
              ),
            ),
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Almarai",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0),
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuarnDBScreen(
                initPage: quranChapter.pages!.first,
                quranSorhaName: quranSorhaName,
              ),
            ),
          );
        });
  }
}
