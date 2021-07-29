import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwipeTask extends StatelessWidget {
  const SwipeTask({
    Key? key,
    required this.taskKey,
    required this.child,
    this.swipeRightColor,
    this.swipeRightIcon,
    this.swipeRightAction,
    this.swipeLeftColor,
    this.swipeLeftIcon,
    this.swipeLeftAction,
  }) : super(key: key);

  final int taskKey;
  final Widget child;
  final Color? swipeRightColor;
  final Icon? swipeRightIcon;
  final Function? swipeRightAction;
  final Color? swipeLeftColor;
  final Icon? swipeLeftIcon;
  final Function? swipeLeftAction;

  @override
  Widget build(BuildContext context) {
    final _borderRadius = BorderRadius.circular(30.r);
    final _margin = EdgeInsets.symmetric(
      horizontal: 0.02.sw,
      vertical: 0.01.sh,
    );
    final _padding = EdgeInsets.symmetric(
      horizontal: 0.02.sw,
      vertical: 0.01.sh,
    );

    return Dismissible(
      key: ValueKey(taskKey),
      background: Container(
        decoration: BoxDecoration(
          color: swipeRightColor,
          borderRadius: _borderRadius,
        ),
        alignment: Alignment.centerLeft,
        margin: _margin,
        padding: _padding,
        child: swipeRightIcon,
      ),
      secondaryBackground: Container(
        decoration: BoxDecoration(
          color: swipeLeftColor,
          borderRadius: _borderRadius,
        ),
        alignment: Alignment.centerRight,
        margin: _margin,
        padding: _padding,
        child: swipeLeftIcon,
      ),
      confirmDismiss: (direction) async {
        switch (direction) {
          case DismissDirection.startToEnd:
            // ignore: avoid_dynamic_calls
            swipeRightAction?.call();
            break;
          case DismissDirection.endToStart:
            // ignore: avoid_dynamic_calls
            swipeLeftAction?.call();
            break;
          default:
        }
      },
      child: child,
    );
  }
}
