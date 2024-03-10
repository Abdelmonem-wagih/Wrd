// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/frosted_glass.dart';

import '../../../../../core/utils/app_colors.dart';

class AlmushafWidget extends StatelessWidget {
  const AlmushafWidget({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return FrostedGlassBox(
      theChild: Center(
        child: Text(
          name,
          style: TextStyle(
            color: AppColors.baseWhite,
            fontWeight: FontWeight.w400,
            fontFamily: "ae_Granada",
            fontStyle: FontStyle.normal,
            fontSize: 24.0.fontSize,
          ),
          textAlign: TextAlign.right,
        ),
      ),
      theWidth: 160.width,
      theHeight: 100.height,
      theBoraderRight: 10,
      theBoraderLeft: 10,
    );
  }
}
