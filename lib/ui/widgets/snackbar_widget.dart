import 'package:task_list/ui/themes.dart';
import 'package:task_list/utils/utils.dart';
import 'package:flutter/material.dart';

void showSnackbar({
  required BuildContext context,
  required String msg,
  SnackBarBehavior? behavior,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: theme(context).textTheme.headline1!.color,
      duration: const Duration(milliseconds: 2500),
      content: Text(
        msg,
        style: TextStyle(
          color: theme(context).cardColor,
          fontSize: Themes().bodyTextSize3,
        ),
      ),
      behavior: behavior ?? SnackBarBehavior.floating,
    ),
  );
}
