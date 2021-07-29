import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list/data/controllers/task_controller.dart';
import 'package:task_list/data/models/task_model.dart';
import 'package:task_list/ui/widgets/bottom_sheet_widget.dart';
import 'package:task_list/utils/texts.dart';
import 'package:task_list/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showEditTaskForm(BuildContext context, [Task? task, bool? edit]) {
  final formKey = GlobalKey<FormState>();
  final newTask = Task(id: 0, name: '', isComplete: false);
  final todoController = Provider.of<TaskController>(context, listen: false);

  Future<void> saveOrEditTask() async {
    // Validate is form can be saved.
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if (edit != true) {
        await todoController.addTask(newTask);
      } else {
        await todoController.editTask(task!, newTask);
      }

      Navigator.of(context).pop();
    }
  }

  bottomSheet(
    context: context,
    body: [
      Text(translate(context, Texts.taskFormTitle)),
      SizedBox(height: 0.01.sh),
      Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: task != null ? task.name : '',
              decoration: InputDecoration(
                labelText: translate(context, Texts.taskFormLabel),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return translate(context, Texts.taskFormSave);
                }
              },
              onSaved: (value) => newTask.name = value.toString(),
              onFieldSubmitted: (_) => saveOrEditTask,
            ),
          ],
        ),
      ),
      TextButton(
        onPressed: saveOrEditTask,
        child: Text(translate(context, Texts.taskFormLabel)),
      ),
    ],
  );
}
