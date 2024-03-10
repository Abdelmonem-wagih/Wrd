import 'package:flutter/material.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/features/quran/presention/controller/dialog/reader_dialog.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../widget/dialog_exit_widget.dart';
import '../letter_controller.dart';

class LetterDialog extends StatelessWidget {
  const LetterDialog({super.key});

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
        child: Scrollbar(
          interactive: true,
          scrollbarOrientation: ScrollbarOrientation.right,
          thumbVisibility: true,
          child: Padding(
            padding:  EdgeInsets.only(right:15.0.width),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Number of columns in the grid
                // Spacing between columns
                crossAxisSpacing: 10.width,
                mainAxisSpacing: 10.height,
                mainAxisExtent: 35.height,
              ),
              itemCount: letterList.length,
              itemBuilder: (context, index) {
                final letter = letterList[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => ReaderDialog(
                        letter: letter,
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.0.radius),
                      ),
                      color: AppColors.second,
                    ),
                    child: Center(
                      child: Text(
                        letter,
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
        ),
      ),
      actions: const [
        DialogExitWidget(),

      ],
    );
  }
}
