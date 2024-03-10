import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/error/widget/remote_failure_content.dart';
import '../../../../core/utils/constance.dart';
import '../controller/failuer.dart';


class FailureWidget extends StatelessWidget {
  const FailureWidget(this.failure, this.refreshFunction,
      {super.key, this.withAppbar = false});

  final Failure failure;
  final void Function() refreshFunction;
  final bool withAppbar;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        refreshFunction();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: 1.sh -
              ScreenUtil().bottomBarHeight -
              ScreenUtil().statusBarHeight -
              (withAppbar ? 50 : 0),
          padding: kPagePadding,
          width: 1.sw,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (failure is RemoteFailure)
                RemoteFailureContent(failure as RemoteFailure),

            ],
          ),
        ),
      ),
    );
  }
}
