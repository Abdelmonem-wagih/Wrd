import 'package:flutter/material.dart';
import 'package:wrd/core/services/screen_size_helper.dart';

import '../../main.dart';
import 'app_colors.dart';

AppBar appBarWidget(BuildContext context, {required String appBarTitle}) {
  return AppBar(
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
    backgroundColor: AppColors.white,
    iconTheme:  IconThemeData(
      color: AppColors.primary,
      size: 20.size,
    ),
    title: Text(
      appBarTitle,
      style: TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.w700,
        fontFamily: "Almarai",
        fontStyle: FontStyle.normal,
        fontSize: 20.0.fontSize,
      ),
    ),
  );
}
