import 'package:flutter/material.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/features/quran/presention/controller/dialog/novel_dialog_list.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../widget/dialog_exit_widget.dart';
import 'letter_dialog.dart';

class SearchDialog extends StatelessWidget {
  const SearchDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(8.0.radius), // Adjust the value as needed
      ),
      title: // البحث داخل المصحف الصوتي
          Text(
        'البحث داخل المصحف الصوتي',
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
          height: 150.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => const LetterDialog(),
                  );
                },
                child: Container(
                  height: 50.height,
                  padding: EdgeInsets.all(10.radius),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0.radius),
                    ),
                    color: AppColors.second,
                  ),
                  child: Center(
                    child: // بالقارئ
                        Text(
                      "بالقارئ",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Almarai",
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0.fontSize,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => const NovelDialogList(),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(10.radius),
                  height: 50.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0.radius),
                    ),
                    color: AppColors.darkTone,
                  ),
                  child: Center(
                    child: // بالقارئ
                        Text(
                      "بالرواية",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Almarai",
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0.fontSize,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          )),
      actions: const [
        DialogExitWidget(),

      ],
    );
  }
}
