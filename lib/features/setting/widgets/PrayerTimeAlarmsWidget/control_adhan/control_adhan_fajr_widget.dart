import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';
import '../../../controller/muezzin_preferences.dart';
import '../../../cubit/controller/control_adhan_fajr_cubit.dart';

class ControlAdhanFajrWidget extends StatelessWidget {
  const ControlAdhanFajrWidget({
    Key? key,
    required this.muezzinNameArabic,
    required this.muezzinNameEnglish,
  }) : super(key: key);

  final String muezzinNameArabic;
  final String muezzinNameEnglish;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ControlAdhanFajrCubit>();
    return BlocBuilder<ControlAdhanFajrCubit, String>(
      builder: (context, muezzinName) {
        print('muezzinName=>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $muezzinName');
        return ListTile(
          onTap: () async {
            await MuezzinPreferencesFajr.setMuezzin(muezzinNameEnglish);
            cubit.selectMuezzin(muezzinNameEnglish);
          },
          title: Text(
            muezzinNameArabic,
            style: TextStyle(
              color: muezzinNameEnglish == muezzinName
                  ? AppColors.lightYellow
                  : Colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: "Almarai",
              fontStyle: FontStyle.normal,
              fontSize: 16.0.fontSize,
            ),
          ),
          leading: SvgPicture.asset(
            'assets/svg/icon_volume.svg',
            color: muezzinNameEnglish == muezzinName
                ? AppColors.lightYellow
                : Colors.white,
          ),
          trailing: muezzinNameEnglish == muezzinName
              ? const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.lightYellow,
                )
              : null,
        );
      },
    );
  }
}
