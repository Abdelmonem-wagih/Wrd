import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/utils/app_colors.dart';

import '../cubit/controller/control_adhan_asr_timing.dart';

class ControlAdhanAsrTiming extends StatelessWidget {
  const ControlAdhanAsrTiming({
    super.key,
    required this.selectSchool,
  });

  final String selectSchool;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlAdhanAsrTimingCubit, String>(
      builder: (context, state) {
        return ListTile(
          onTap: () {

            context
                .read<ControlAdhanAsrTimingCubit>()
                .selectSchoolOfAdhanAsrTiming(selectSchool);
            Navigator.pop(context); // Close the bottom sheet

          },
          title: Text(
            selectSchool,
            style: TextStyle(
              color:
                  selectSchool == state ? AppColors.lightYellow : Colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: "Almarai",
              fontStyle: FontStyle.normal,
              fontSize: 16.0,
            ),
          ),
          trailing: selectSchool == state
              ? const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.lightYellow,
                )
              : const Icon(
                  Icons.check_circle_outline,
                ),
        );
      },
    );
  }
}
