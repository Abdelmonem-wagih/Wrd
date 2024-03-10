// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/features/islamic_corner/azkar/presentoin/screen/azkar_screen.dart';

class AzkarGridWidget extends StatelessWidget {
  final azkar;

  const AzkarGridWidget({
    super.key,
    required this.azkar,
  });

  @override
  Widget build(BuildContext context) {
    // Implement the UI representation of each item in the grid
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AzkarScreen(
            azkarTest: azkar,
          ),
        ),
      ),
      child: Container(
        width: 16.width,
        height: 92.height,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.all(
            Radius.circular(10.radius),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2.0,
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            azkar.category!,
            style: TextStyle(
              color: AppColors.baseWhite,
              fontWeight: FontWeight.w700,
              fontFamily: "Almarai",
              fontStyle: FontStyle.normal,
              fontSize: 22.0.fontSize,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
