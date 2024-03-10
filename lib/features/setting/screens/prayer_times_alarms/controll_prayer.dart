import 'package:flutter/material.dart';
import 'package:wrd/core/services/screen_size_helper.dart';

import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/core/utils/appbar_widget.dart';
import '../../widgets/PrayerTimeAlarmsWidget/control_adhan/control_adhan_fajr_widget.dart';
import '../../widgets/PrayerTimeAlarmsWidget/control_adhan/control_adhan_widget.dart';

class ControllPrayer extends StatelessWidget {
  const ControllPrayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, appBarTitle: 'التحكم في الأذان'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20.0.width, top: 10.0.height),
              child: Text(
                "أذان الفجر",
                style: TextStyle(
                  color: AppColors.darkTone,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Almarai",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0.fontSize,
                ),
              ),
            ),
            const ControlAzanFajr(),
            // أذان الصلوات الأخري
            Padding(
              padding: EdgeInsets.only(right: 20.0.width, top: 10.0.height),
              child: Text(
                "أذان الصلوات الأخري",
                style: TextStyle(
                  color: AppColors.darkTone,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Almarai",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0.fontSize,
                ),
              ),
            ),
            const ControlAzan(),
          ],
        ),
      ),
    );
  }
}

class ControlAzan extends StatelessWidget {
  const ControlAzan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.darkTone,
      ),
      child: const Column(
        children: [
          ControlAdhanWidget(
            muezzinNameEnglish: 'adhan_ahmad_naeayanae',
            muezzinNameArabic: 'أذان أحمد نعينع',
          ),
          Divider(
            color: AppColors.white,
            thickness: 0.5,
          ),
          ControlAdhanWidget(
            muezzinNameEnglish: 'adhan_alharam_almakiyi',
            muezzinNameArabic: 'أذان الحرم المكي',
          ),
          Divider(
            color: AppColors.white,
            thickness: 0.5,
          ),
          ControlAdhanWidget(
            muezzinNameEnglish: 'adhan_eabdalbasit_eabd_alsamad',
            muezzinNameArabic: 'أذان عبدالباسط عبد الصمد',
          ),
          Divider(
            color: AppColors.white,
            thickness: 0.5,
          ),
          ControlAdhanWidget(
            muezzinNameEnglish: 'adhan_muhamad_rufeat',
            muezzinNameArabic: 'أذان محمد رفعت',
          ),
        ],
      ),
    );
  }
}

class ControlAzanFajr extends StatelessWidget {
  const ControlAzanFajr({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.darkTone,
      ),
      child: const Column(
        children: [
          ControlAdhanFajrWidget(
              muezzinNameEnglish: 'azan_yasser_aldosari_fajr',
              muezzinNameArabic: 'أذان ياسر الدوسري'),
          Divider(
            color: AppColors.white,
            thickness: 0.5,
          ),
          ControlAdhanFajrWidget(
            muezzinNameEnglish: 'adhan_mishari_bin_rashid_alafasy',
            muezzinNameArabic: 'أذان مشاري بن راشد العفاسي',
          ),
          Divider(
            color: AppColors.white,
            thickness: 0.5,
          ),
          ControlAdhanFajrWidget(
            muezzinNameEnglish: 'adhan_medina',
            muezzinNameArabic: 'أذان المدينة المنورة',
          ),
          Divider(
            color: AppColors.white,
            thickness: 0.5,
          ),
          ControlAdhanFajrWidget(
            muezzinNameEnglish: 'adhan_mecca',
            muezzinNameArabic: 'أذان مكه المكرمة',
          ),
        ],
      ),
    );
  }
}
