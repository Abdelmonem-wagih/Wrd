// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/features/islamic_corner/aliadieia/domain/entities/duea.dart';

import '../screen/duea_screen.dart';

class DueaGridWidget extends StatelessWidget {
  final Duea duea;
  const DueaGridWidget({
    super.key,
    required this.duea,
  });

  @override
  Widget build(BuildContext context) {
    // Implement the UI representation of each item in the grid
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DueaScreen(
            dueaTest: duea,
          ),
        ),
      ),
      child: Container(
        width: 169.84.width,
        height: 92.height,
        decoration: BoxDecoration(
          color: Color(0x80e5ba73),
          borderRadius: BorderRadius.all(
            Radius.circular(10.radius),
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              Text(
                duea.category!,
                style: TextStyle(
                  color: AppColors.darkTone,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Almarai",
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0.fontSize,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
