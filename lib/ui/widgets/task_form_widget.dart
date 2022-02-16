import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_list/data/controllers/task_controller.dart';
import 'package:task_list/data/models/task_model.dart';
import 'package:task_list/ui/themes.dart';
import 'package:task_list/ui/widgets/bottom_sheet_widget.dart';
import 'package:task_list/ui/widgets/outline_form_field_widget.dart';
import 'package:task_list/ui/widgets/round_button_widget.dart';
import 'package:task_list/utils/localizations.dart';

// ignore: avoid_positional_boolean_parameters
void showTaskForm(BuildContext context, [Task? task, bool? edit]) {
  final formKey = GlobalKey<FormState>();
  final newTask = Task(id: 0, name: '', isComplete: false);
  final todoController = Provider.of<TaskController>(context, listen: false);

  Future<void> saveTask() async {
    // Validate is form can be saved.
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if (edit != true) {
        await todoController.addTask(newTask);
      } else {
        await todoController.editTask(task!, newTask);
      }

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  bottomSheet(
    context: context,
    body: [
      Text(
        task != null
            ? translate(context, Texts.taskFormTitleEdit)
            : translate(context, Texts.taskFormTitleAdd),
        style: theme(context).textTheme.headline1!.copyWith(
              fontSize: Themes().headlineTextSize,
            ),
      ),
      SizedBox(height: isLandscape() ? 0.05.sh : 0.03.sh),
      Form(
        key: formKey,
        child: Column(
          children: [
            OutlineFormField(
              initialValue: task != null ? task.name : '',
              labelText: task != null
                  ? translate(context, Texts.taskFormTitleEdit)
                  : translate(context, Texts.taskFormTitleAdd),
              // ignore: noop_primitive_operations
              onSaved: (value) => newTask.name = value.toString(),
              onFieldSubmitted: () => saveTask,
            ),
          ],
        ),
      ),
      SizedBox(height: isLandscape() ? 0.05.sh : 0.02.sh),
      RoundButton(
        title: translate(context, Texts.taskFormButton),
        onPressed: saveTask,
      ),
    ],
  );
}
