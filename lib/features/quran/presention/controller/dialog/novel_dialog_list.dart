import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/features/quran/presention/controller/dialog/reader_dialog_list.dart';
import 'package:wrd/features/quran/presention/cubit/rewaya_cubit/rewaya_cubit.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../widget/dialog_exit_widget.dart';

class NovelDialogList extends StatelessWidget {
  const NovelDialogList({
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
        child: BlocBuilder<RewayaCubit, RewayaState>(
          builder: (context, state) {
            if (state is RewayaLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is RewayaSuccessState) {
              return Scrollbar(
                interactive: true,
                scrollbarOrientation: ScrollbarOrientation.right,
                thumbVisibility: true,
                child: Padding(
                  padding:  EdgeInsets.only(right:15.0.width),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, // Number of columns in the grid
                      // Spacing between columns
                      crossAxisSpacing: 5.width,
                      mainAxisSpacing: 10.height,
                      mainAxisExtent: 40.height,
                    ),
                    itemCount: state.rewayat.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) => ReaderDialogList(
                              rewaya: state.rewayat[index],
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0.radius),
                            ),
                            color: AppColors.darkTone,
                          ),
                          child: Center(
                            child: Text(
                              state.rewayat[index].name ?? '',
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
