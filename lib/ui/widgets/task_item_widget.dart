import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list/data/controllers/task_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_list/data/models/task_model.dart';
import 'package:task_list/ui/widgets/edit_task_form_widget.dart';
import 'package:task_list/ui/widgets/snackbar_widget.dart';
import 'package:task_list/ui/widgets/swipe_task_widget.dart';
import 'package:task_list/utils/texts.dart';
import 'package:task_list/utils/utils.dart';

import 'action_bottom_sheet_widget.dart';

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
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    final _todoController = Provider.of<TaskController>(context, listen: false);

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
              TextButton(
                onPressed: () {
                  _todoController.deleteTask(_item.id);
                  showSnackbar(
                    context: context,
                    msg: translate(context, Texts.actionDeleteSnackbar),
                  );
                  Navigator.of(context).pop();
                },
                child: Text(translate(context, Texts.actionConfirmYes)),
              ),
              if (isLandscape()) SizedBox(width: 0.05.sw),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(translate(context, Texts.actionConfirmNo)),
              ),
            ],
          ),
        ],
      );
    }

    return SwipeTask(
      taskKey: _item.id,
      swipeRightColor: Colors.red,
      swipeRightIcon: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
      swipeRightAction: _deleteItem,
      swipeLeftColor: Colors.yellow[900],
      swipeLeftIcon: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
      swipeLeftAction: () => showEditTaskForm(context, _item, true),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 0.01.sh,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 0.02.sh,
        ),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _item.name,
              style: TextStyle(
                color: Colors.black,
                decoration:
                    _item.isComplete ? TextDecoration.lineThrough : null,
              ),
            ),
            Transform.scale(
              scale: 1.r,
              child: Checkbox(
                value: _item.isComplete,
                shape: const CircleBorder(),
                onChanged: (value) {
                  _todoController.toggleIsComplete(_item, value!);
                  setState(() => widget.isComplete = value);
                },
                activeColor: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
