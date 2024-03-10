import 'package:flutter/material.dart';

class DialogExitWidget extends StatelessWidget {
  const DialogExitWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        height: 45,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Color(0xffeeeeee)),
        child: const Center(
          child: Text(
            'إغــلاق',
            style: TextStyle(
                color: Color(0xffbababa),
                fontWeight: FontWeight.w700,
                fontFamily: "Almarai",
                fontStyle: FontStyle.normal,
                fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
