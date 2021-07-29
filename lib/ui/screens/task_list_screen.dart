import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list/data/controllers/task_controller.dart';
import 'package:task_list/ui/widgets/edit_task_form_widget.dart';
import 'package:task_list/ui/widgets/task_item_widget.dart';
import 'package:task_list/utils/texts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_list/utils/utils.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/todo-list-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Texts.appName),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future:
              Provider.of<TaskController>(context, listen: false).getTasks(),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                return const Center(child: Text('An error ocurred!'));
              } else {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 0.02.sw),
                  child: Consumer<TaskController>(
                    builder: (context, todo, child) {
                      return RefreshIndicator(
                        onRefresh: () => todo.getTasks(),
                        child: ListView.builder(
                          itemCount: todo.items.length,
                          itemBuilder: (BuildContext _, int index) {
                            return Column(
                              children: [
                                TaskItem(
                                  id: todo.items[index].id,
                                  name: todo.items[index].name,
                                  isComplete: todo.items[index].isComplete,
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              }
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => showEditTaskForm(context),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5.r,
        color: Colors.blueAccent,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Expanded(child: SizedBox()),
            Container(
              padding: EdgeInsets.only(
                top: 0.02.sh,
                right: 0.1.sw,
              ),
              child: Consumer<TaskController>(
                builder: (context, task, child) {
                  return Text(
                    '${translate(context, Texts.tasks)} ${task.items.length}',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
