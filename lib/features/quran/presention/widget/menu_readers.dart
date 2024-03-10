import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/features/quran/domain/entities/quranAudio/quran_audio.dart';
import 'package:wrd/features/quran/presention/cubit/quran_chapters/quran_chapters_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../controller/dialog/novel_dialog.dart';

// ignore: must_be_immutable
class ReaderContcetWiget extends StatelessWidget {
  const ReaderContcetWiget({
    super.key,
    required this.numberReader,
    required this.readerName,
    required this.filteredItems,
    this.rewayaIsSelected = false,
    this.onTap, required this.comingFromReaderOrNovel,
  });
  final String readerName;
  final List<QuranAudio?> filteredItems;

  final int numberReader;
  static int indexOf = 1;
  static int numberReaderr = 0;
  final bool rewayaIsSelected;
  final void Function()? onTap;
  final int comingFromReaderOrNovel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.pop(context); // Close the current AlertDialog
        Navigator.pop(context);
        if (!rewayaIsSelected) {
          showDialog(
            context: context,
            builder: (context) => const NovelDialog(),
          );
        }

        if (onTap != null) onTap!();

        numberReaderr = numberReader;
        debugPrint('numberReaderr =>>>>$numberReaderr');
        indexOf = numberReader + 1;

        context.read<QuranChaptersCubit>().getQuranChapters();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0.radius),
          ),
          color:comingFromReaderOrNovel == 1? AppColors.darkTone:AppColors.second,
        ),
        child: Center(
          child: Text(
            readerName,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: "Almarai",
              fontStyle: FontStyle.normal,
              fontSize: 13.0.fontSize,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
