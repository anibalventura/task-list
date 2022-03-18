import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_list/controllers/task_controller.dart';
import 'package:task_list/models/task_model.dart';
import 'package:task_list/screens/widgets/action_bottom_sheet_widget.dart';
import 'package:task_list/screens/widgets/round_button_widget.dart';
import 'package:task_list/screens/widgets/snackbar_widget.dart';
import 'package:task_list/screens/widgets/swipe_item_widget.dart';
import 'package:task_list/screens/widgets/task_form_widget.dart';
import 'package:task_list/utils/localizations.dart';
import 'package:task_list/utils/themes.dart';

// ignore: must_be_immutable
class TaskItem extends StatefulWidget {
  TaskItem({
    Key? key,
    required this.id,
    required this.name,
    required this.isComplete,
  }) : super(key: key);

  int id;
  String name;
  bool isComplete;

  @override
  TaskItemState createState() => TaskItemState();
}

class TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    final _todoController = Provider.of<TaskController>(context, listen: false);
    final _borderRadius = BorderRadius.circular(30.r);

    final _item = Task(
      id: widget.id,
      name: widget.name,
      isComplete: widget.isComplete,
    );

    void _deleteItem() {
      actionBottomSheet(
        context: context,
        title: translate(context, Texts.actionDeleteTitle),
        message: translate(context, Texts.actionDeleteMsg),
        actions: [
          Row(
            mainAxisAlignment: isLandscape()
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceEvenly,
            children: [
              RoundButton(
                title: translate(context, Texts.actionConfirmYes),
                onPressed: () {
                  _todoController.deleteTask(_item.id);
                  showSnackbar(
                    context: context,
                    msg: translate(context, Texts.actionDeleteSnackbar),
                  );
                  Navigator.of(context).pop();
                },
              ),
              if (isLandscape()) SizedBox(width: 0.05.sw),
              RoundButton(
                title: translate(context, Texts.actionConfirmNo),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ],
      );
    }

    return SwipeItem(
      taskKey: _item.id,
      swipeRightColor: theme(context).errorColor,
      swipeRightIcon: const Icon(FontAwesomeIcons.trashAlt),
      swipeRightAction: _deleteItem,
      swipeLeftColor: theme(context).highlightColor,
      swipeLeftIcon: const Icon(FontAwesomeIcons.edit),
      swipeLeftAction: () => showTaskForm(context, _item, true),
      child: PhysicalModel(
        color: theme(context).backgroundColor,
        elevation: 3,
        shadowColor: theme(context).colorScheme.secondary,
        borderRadius: _borderRadius,
        child: Container(
          padding: EdgeInsets.only(
            left: isLandscape() ? 0.025.sw : 0.05.sw,
            right: 0.01.sh,
          ),
          decoration: BoxDecoration(
            borderRadius: _borderRadius,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  _item.name,
                  style: theme(context).textTheme.bodyText1!.copyWith(
                        color: _item.isComplete
                            ? Colors.grey
                            : theme(context).textTheme.bodyText1!.color,
                        fontSize: Themes().bodyTextSize,
                        decoration: _item.isComplete
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                ),
              ),
              Transform.scale(
                scale: isLandscape() ? 2.r : 1.r,
                child: Checkbox(
                  value: _item.isComplete,
                  shape: const CircleBorder(),
                  onChanged: (value) {
                    _todoController.toggleIsComplete(_item, value!);
                    setState(() => widget.isComplete = value);
                  },
                  activeColor: theme(context).colorScheme.secondary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
