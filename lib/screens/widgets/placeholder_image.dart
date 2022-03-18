import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_list/utils/themes.dart';

class PlaceholderImage extends StatelessWidget {
  const PlaceholderImage({
    Key? key,
    required this.image,
    required this.message,
  }) : super(key: key);

  final Widget image;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.3,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image,
            SizedBox(height: 0.02.sh),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme(context).textTheme.bodyText1!.copyWith(
                    fontSize: Themes().headlineTextSize,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
