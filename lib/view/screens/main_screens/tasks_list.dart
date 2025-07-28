import 'package:flutter/material.dart';
import 'package:nex_task/controller/tasks_controller.dart';
import 'package:nex_task/utils/enums/tasks_list_screen_state.dart';
import 'package:nex_task/view/components/cards/task_card.dart';
import 'package:nex_task/view/components/modals/create_task_modal.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  TasksListScreenState screenState = TasksListScreenState.list;

  @override
  Widget build(BuildContext context) {
    // TODO: Add filter for each progress status
    return Scaffold(
      body:
          screenState == TasksListScreenState.list
              ? FutureBuilder<List<Map<String, dynamic>>>(
                future: TasksController.getTasks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("an error ocurred"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("nothing to show"));
                  } else {
                    List<Map<String, dynamic>> tasks = snapshot.data!;
                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          id: tasks[index]["id"],
                          title: tasks[index]["title"],
                          description: tasks[index]["description"],
                          dueDate: tasks[index]["due_date"],
                          category: tasks[index]["category"],
                          status: tasks[index]["status"],
                        );
                      },
                    );
                  }
                },
              )
              : Center(child: CreateTaskModal()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child:
            screenState == TasksListScreenState.list
                ? Icon(Icons.add, color: Colors.white)
                : Icon(Icons.cancel_sharp, color: Colors.white),
        onPressed: () {
          setState(() {
            screenState == TasksListScreenState.list
                ? screenState = TasksListScreenState.newTask
                : screenState = TasksListScreenState.list;
          });
        },
      ),
    );
  }
}
