import 'package:flutter/material.dart';
import 'package:nex_task/utils/enums/tasks_list_screen_state.dart';
import 'package:nex_task/view/components/cards/task_card.dart';
import 'package:nex_task/view/components/modals/create_task_modal.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  ///TODO: START WITH LOADING!!
  TasksListScreenState screenState = TasksListScreenState.list;

  @override
  Widget build(BuildContext context) {
    // TODO: Add filter for each progress status
    return screenState == TasksListScreenState.loading
        ? Stack(
          children: [
            ModalBarrier(color: Colors.transparent.withOpacity(0.5)),
            Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)),
          ],
        )
        : Scaffold(
          body:
              screenState == TasksListScreenState.list
                  ? ListView(
                    children: [
                      TaskCard(name: "task 1"),
                      TaskCard(name: "task 2"),
                      TaskCard(name: "task 3"),
                      TaskCard(name: "task 4"),
                      TaskCard(name: "task 5"),
                    ],
                  )
                  : Center(child: CreateTaskModal()),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child:
                screenState == TasksListScreenState.list
                    ? Icon(Icons.add, color: Colors.white)
                    : Icon(Icons.cancel_sharp, color: Colors.white,),
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
