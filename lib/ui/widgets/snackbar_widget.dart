import 'package:flutter/material.dart';
import 'package:task_list/ui/themes.dart';

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
        style: theme(context).textTheme.bodyText2!.copyWith(
              fontSize: Themes().bodyTextSize,
              color: theme(context).cardColor,
            ),
      ),
      behavior: behavior ?? SnackBarBehavior.floating,
    ),
  );
}
