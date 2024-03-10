import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/features/quran/domain/entities/quranAudio/rewaya.dart';
import 'package:wrd/features/quran/presention/cubit/quran_audio/quran_audio_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../cubit/novel.dart';
import '../../widget/dialog_exit_widget.dart';
import '../../widget/menu_readers.dart';

class ReaderDialogList extends StatelessWidget {
  final Rewaya rewaya;
  const ReaderDialogList({super.key, required this.rewaya});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(8.0.radius), // Adjust the value as needed
      ),
      title: // البحث بالقارئ
          Text(
        "البحث بالرواية",
        style: TextStyle(
          color: AppColors.darkTone,
          fontWeight: FontWeight.w400,
          fontFamily: "Almarai",
          fontStyle: FontStyle.normal,
          fontSize: 18.0.fontSize,
        ),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 250.height,
        width: 150.width,
        child: BlocBuilder<QuranAudioCubit, QuranAudioState>(
          builder: (context, state) {
            if (state is QuranAudioLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is QuranAudioSuccessState) {
              return Scrollbar(
                interactive: true,
                scrollbarOrientation: ScrollbarOrientation.right,
                thumbVisibility: true,
                child: Padding(
                  padding:  EdgeInsets.only(right:15.0.width),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                      // Spacing between columns
                      crossAxisSpacing: 5.width,
                      mainAxisSpacing: 10.height,
                      mainAxisExtent: 40,
                    ),
                    itemCount: state.quranAudio.length,
                    itemBuilder: (context, index) {
                      return ReaderContcetWiget(
                        comingFromReaderOrNovel: 1,
                        numberReader: index,
                        filteredItems: state.quranAudio,
                        readerName: state.quranAudio[index].readersName!,
                        rewayaIsSelected: true,
                        onTap: () {
                          context.read<NovelCubit>().setNovel(
                                state.quranAudio[index].moshafs.first?.server ?? '',
                              );
                        },
                      );
                    },
                  ),
                ),
              );
            } else {
              return const Text('Error data');
            }
          },
        ),
      ),
      actions: const [
        DialogExitWidget(),
      ],
    );
  }
}
