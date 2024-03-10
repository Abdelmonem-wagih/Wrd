
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import '../../../../../core/utils/app_colors.dart';

class GroupWidget extends StatelessWidget {
  const GroupWidget({
    super.key,
    required this.widgetArray, required this.len,
  });

  final widgetArray;
  final int len;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: widgetArray.text));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Text copied to clipboard"),
              ),
            );
          },
          child: const Icon(Icons.copy, color: AppColors.primary),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.height),
          child: Container(
            width: 56.width,
            height: 27.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.radius),
              ),
              color: const Color(0xb2c58940),
            ),
            child: Center(
              child: Text(
                ' $len / ${widgetArray.id}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Almarai",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0.fontSize,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
