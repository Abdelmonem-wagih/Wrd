import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/features/quran/domain/entities/quranAudio/quran_audio.dart';
import 'package:wrd/features/quran/presention/cubit/quran_audio/quran_audio_cubit.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../widget/dialog_exit_widget.dart';
import '../../widget/menu_readers.dart';

class ReaderDialog extends StatelessWidget {
  final String letter;
  const ReaderDialog({super.key, required this.letter});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(8.0.radius), // Adjust the value as needed
      ),
      title: // البحث بالقارئ
          Text(
        "البحث بالقارئ",
        style: TextStyle(
          color: AppColors.darkTone,
          fontWeight: FontWeight.w400,
          fontFamily: "Almarai",
          fontStyle: FontStyle.normal,
          fontSize: 18.0.fontSize,
        ),
        textAlign: TextAlign.center,
      ),
      content: BlocBuilder<QuranAudioCubit, QuranAudioState>(
        builder: (context, state) {
          if (state is QuranAudioLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is QuranAudioSuccessState) {
            List<MapEntry<int, QuranAudio>> filteredItemsWithIndices =
                state.quranAudio.asMap().entries.where((entry) {
              return entry.value.letter == letter;
            }).toList();
            // int x = 0;

            return SizedBox(
              height: 200.height,
              width: 150.width,
              child:  Scrollbar(
                interactive: true,
                scrollbarOrientation: ScrollbarOrientation.right,
                thumbVisibility: true,
                child: Padding(
                  padding:  EdgeInsets.only(right:15.0.width),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                      // Spacing between columns
                      crossAxisSpacing: 15.width,
                      mainAxisSpacing: 10.height,
                      mainAxisExtent: 40.height,
                    ),
                    itemCount: filteredItemsWithIndices.length,
                    itemBuilder: (context, index) {
                      return ReaderContcetWiget(
                        comingFromReaderOrNovel: 2,
                        numberReader: filteredItemsWithIndices[index].key,
                        filteredItems: state.quranAudio,
                        readerName:
                            filteredItemsWithIndices[index].value.readersName!,
                      );
                    },
                  ),
                ),
              ),
            );
          } else {
            return const Text('Error data');
          }
        },
      ),
      actions: const [
        DialogExitWidget(),
      ],
    );
  }
}
