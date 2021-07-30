import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:task_list/data/controllers/task_controller.dart';
import 'package:task_list/ui/themes.dart';
import 'package:task_list/ui/widgets/task_form_widget.dart';
import 'package:task_list/ui/widgets/task_item_widget.dart';
import 'package:task_list/utils/localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({Key? key}) : super(key: key);
  static const routeName = '/todo-list-screen';

  @override
  Widget build(BuildContext context) {
    final todoController = Provider.of<TaskController>(context, listen: false);
    final refreshController = RefreshController(initialRefresh: false);

    void refresh() async {
      await todoController.getTasks();
      refreshController.refreshCompleted();
    }

    return Scaffold(
      backgroundColor: theme(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          Texts.appName,
          style: theme(context).textTheme.headline1!.copyWith(
              fontSize: Themes().headlineTextSize,
              color: theme(context).textTheme.bodyText2!.color),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15.r),
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: todoController.getTasks(),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  height: isLandscape() ? 0.09.sh : 0.04.sh,
                  width: isLandscape() ? 0.3.sw : 0.4.sw,
                  child: LiquidLinearProgressIndicator(
                    value: 0.5,
                    valueColor:
                        AlwaysStoppedAnimation(theme(context).accentColor),
                    backgroundColor: Colors.transparent,
                    borderColor: theme(context).accentColor,
                    borderWidth: 1.r,
                    borderRadius: 30.r,
                    direction: Axis.horizontal,
                    center: Text(
                      translate(context, Texts.loading),
                      style: theme(context).textTheme.bodyText2!.copyWith(
                            fontSize: Themes().bodyTextSize,
                          ),
                    ),
                  ),
                ),
              );
            } else {
              if (dataSnapshot.error != null) {
                return const Center(
                  child: Text('An error ocurred!'),
                );
              } else {
                return Consumer<TaskController>(
                  builder: (context, todo, child) {
                    return SmartRefresher(
                      controller: refreshController,
                      onRefresh: refresh,
                      child: ListView.builder(
                        itemCount: todo.items.length,
                        itemBuilder: (BuildContext _, int index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: isLandscape() ? 0.03.sw : 0.05.sw,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: isLandscape() ? 0.02.sh : 0.015.sh,
                                ),
                                TaskItem(
                                  id: todo.items[index].id,
                                  name: todo.items[index].name,
                                  isComplete: todo.items[index].isComplete,
                                ),
                                SizedBox(
                                  height: isLandscape() ? 0.02.sh : 0.015.sh,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme(context).accentColor,
        foregroundColor: theme(context).iconTheme.color,
        onPressed: () => showTaskForm(context),
        child: const Icon(FontAwesomeIcons.plus),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.r),
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: isLandscape() ? 10.r : 5.r,
          color: theme(context).primaryColor,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Expanded(child: SizedBox()),
              Container(
                padding: EdgeInsets.only(
                  top: isLandscape() ? 0.05.sh : 0.02.sh,
                  right: isLandscape() ? 0.03.sw : 0.1.sw,
                ),
                child: Consumer<TaskController>(
                  builder: (context, task, child) {
                    return Text(
                      '${translate(context, Texts.tasks)} ${task.items.length}',
                      style: theme(context).textTheme.bodyText2!.copyWith(
                            fontSize: Themes().bodyTextSize,
                          ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
