import 'package:task_list/services/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData theme(BuildContext context) => Theme.of(context);

bool isLandscape() => ScreenUtil().orientation == Orientation.landscape;

String translate(BuildContext context, String text) {
  return AppLocalizations.of(context)!.trans(text)!;
}
