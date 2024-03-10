
import 'package:flutter/material.dart';
import 'package:wrd/core/services/screen_size_helper.dart';

import '../utils/app_colors.dart';

class SwitchHelper extends StatelessWidget {
  const SwitchHelper({
    super.key,
    required bool switchValue,
  }) : _switchValue = switchValue;

  final bool _switchValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65.0.width,
      height: 30.0.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: _switchValue ? AppColors.primary : AppColors.gray,
      ),
      child: Stack(
        alignment:
        _switchValue ? Alignment.centerRight : Alignment.centerLeft,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: 30.0,
            height: 30.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
