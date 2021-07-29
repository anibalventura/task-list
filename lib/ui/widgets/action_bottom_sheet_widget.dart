import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_list/ui/themes.dart';
import 'package:task_list/utils/utils.dart';

void actionBottomSheet({
  required BuildContext context,
  String? title,
  String? message,
  List<Widget>? actions,
}) {
  showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: theme(context).scaffoldBackgroundColor,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 0.03.sw,
          vertical: 0.05.sh,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title!,
              style: theme(context).textTheme.bodyText1!.copyWith(
                    fontSize: Themes().bodyTextSize1,
                  ),
            ),
            SizedBox(height: isLandscape() ? 0.01.sh : 0.005.sh),
            Text(
              message!,
              style: theme(context).textTheme.headline1!.copyWith(
                    fontSize: Themes().bodyTextSize1,
                  ),
            ),
            SizedBox(height: isLandscape() ? 0.05.sh : 0.02.sh),
            ...actions!,
            SizedBox(height: isLandscape() ? 0.05.sh : 0.02.sh),
          ],
        ),
      );
    },
  );
}
