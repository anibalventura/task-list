import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_list/ui/themes.dart';
import 'package:task_list/utils/localizations.dart';

class OutlineFormField extends StatelessWidget {
  const OutlineFormField({
    Key? key,
    required this.initialValue,
    required this.labelText,
    required this.onSaved,
    required this.onFieldSubmitted,
  }) : super(key: key);

  final String initialValue;
  final String labelText;
  final ValueChanged<String> onSaved;
  final Function onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    final _borderRadius = BorderRadius.all(Radius.circular(30.r));

    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: theme(context).textTheme.bodyText1!.copyWith(
              fontSize: Themes().bodyTextSize,
            ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(
          horizontal: isLandscape() ? 0.02.sw : 0.05.sw,
          vertical: isLandscape() ? 0.05.sh : 0.015.sh,
        ),
        border: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(
            color: theme(context).primaryColor,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(
            color: theme(context).colorScheme.secondary,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(
            color: theme(context).errorColor,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return translate(context, Texts.taskFormError);
        }
        return null;
      },
      onSaved: (value) => onSaved(value!),
      onFieldSubmitted: (_) => onFieldSubmitted,
    );
  }
}
