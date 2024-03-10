import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/widget/loading_widget.dart';
import 'package:wrd/features/quran/presention/cubit/quran_audio/quran_audio_cubit.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../cubit/novel.dart';
import '../../widget/dialog_exit_widget.dart';
import '../../widget/menu_readers.dart';

class NovelDialog extends StatelessWidget {
  const NovelDialog({
    super.key,
  });
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
      content: SizedBox(
        height: 200.height,
        width: 150.width,
        child: BlocBuilder<QuranAudioCubit, QuranAudioState>(
          builder: (context, state) {
            if (state is QuranAudioLoadingState) {
              return const Center(
                child: LoadingWidget(),
              );
            } else if (state is QuranAudioSuccessState) {
              return Scrollbar(
                interactive: true,
                scrollbarOrientation: ScrollbarOrientation.left,
                trackVisibility: true,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 10.height,
                    mainAxisExtent: 40.height,
                  ),
                  itemCount: state.quranAudio[ReaderContcetWiget.numberReaderr]
                      .moshafs.length,
                  itemBuilder: (context, index) {
                    final quranAudio =
                        state.quranAudio[ReaderContcetWiget.numberReaderr];
                    return InkWell(
                      onTap: () {
                        String newChosenValue =
                            quranAudio.moshafs[index]!.server!;

                        context.read<NovelCubit>().setNovel(newChosenValue);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0.radius),
                          ),
                          color: AppColors.second,
                        ),
                        child: Center(
                          child: Text(
                            quranAudio.moshafs[index]!.name!,
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
                  },
                ),
              );
            } else if (state is QuranAudioErorrState) {
              return Center(
                child:
                    Text('Error loading prayer times: ${state.errorMessage}'),
              );
            } else {
              return Container();
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
