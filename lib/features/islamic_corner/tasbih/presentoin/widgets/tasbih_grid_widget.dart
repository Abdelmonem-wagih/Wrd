// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/features/islamic_corner/tasbih/domain/entities/tasbih.dart';

class TasbihGridWidget extends StatelessWidget {
  final Tasbih tasbih;
  final Map<String, dynamic> item;
  const TasbihGridWidget({
    super.key,
    required this.tasbih,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    // Implement the UI representation of each item in the grid
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => item['route']),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.all(
            Radius.circular(10.radius),
          ),
        ),
        child: Center(
          child: Text(
            tasbih.category!,
            style: TextStyle(
              color: AppColors.baseWhite,
              fontWeight: FontWeight.w700,
              fontFamily: "Almarai",
              fontStyle: FontStyle.normal,
              fontSize: 20.0.fontSize,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
