import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../features/prayer_timing/presention/controller/erorr_code.dart';
import '../../../features/prayer_timing/presention/controller/failuer.dart';




class RemoteFailureContent extends StatelessWidget {
  const RemoteFailureContent(this.failure, {super.key});

  final RemoteFailure failure;

  @override
  Widget build(BuildContext context) {
    if (failure.errorCode == RemoteErrorCode.INTERNET_ERROR_CODE) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 500.w,
            ),
            child: ClipOval(
              child: LottieBuilder.asset(
                'assets/json/no_internet.json',
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            failure.message,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 500.w,
          ),
          child: LottieBuilder.asset(
            'assets/json/all_set.json',
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Text(
          failure.message,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
