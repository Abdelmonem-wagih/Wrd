// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wrd/frosted_glass.dart';

import '../../../../../core/utils/app_colors.dart';

class IslamicWidget extends StatelessWidget {
  const IslamicWidget({
    super.key,
    required this.height,
    required this.width,
    required this.name,
    required this.imageUrl,
  });

  final double height;
  final double width;
  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return FrostedGlassBox(
      theHeight: height * 0.11,
      theWidth: width * 0.25,
      theBoraderLeft: 10,
      theBoraderRight: 10,
      theChild: Text(
        name,
        style: TextStyle(
          color: AppColors.baseWhite,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
