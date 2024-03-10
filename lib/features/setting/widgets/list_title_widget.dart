import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wrd/core/utils/app_colors.dart';

class ListTitleWidget extends StatelessWidget {
  const ListTitleWidget({
    super.key,
    this.trailingIcon,
    required this.text,
    this.leadingIcon,
    this.widget,
    this.subtitle,
  });
  final String text;
  final String? leadingIcon;
  final String? subtitle;
  final IconData? trailingIcon;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontFamily: "Almarai",
            fontStyle: FontStyle.normal,
            fontSize: 18.0),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle!,
              style: const TextStyle(
                  color: AppColors.baseWhite,
                  fontWeight: FontWeight.w300,
                  fontFamily: "Almarai",
                  fontStyle: FontStyle.normal,
                  fontSize: 11.0),
            ),
      leading: leadingIcon == null
          ? null
          : SvgPicture.asset(
              height: 35,
              width: 35,
              leadingIcon!,

            ),
      trailing: widget ??
          (trailingIcon == null
              ? null
              : Icon(
                  trailingIcon,
                  color: AppColors.white,
                )),
    );
  }
}
