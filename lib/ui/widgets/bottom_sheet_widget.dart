import 'package:task_list/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void bottomSheet({
  required BuildContext? context,
  Color? backgroundColor,
  List<Widget>? body,
}) {
  showModalBottomSheet<void>(
    context: context!,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: backgroundColor ?? theme(context).scaffoldBackgroundColor,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isLandscape() ? 0.01.sw : 0.03.sw,
          vertical: isLandscape() ? 0.1.sh : 0.05.sh,
        ),
        child: Container(
          padding: isLandscape()
              ? null
              : EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: body!,
          ),
        ),
      );
    },
  );
}
