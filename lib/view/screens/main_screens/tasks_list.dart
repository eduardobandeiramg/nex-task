import 'package:flutter/material.dart';
import 'package:nex_task/controller/tasks_controller.dart';
import 'package:nex_task/services/storage/storage_service.dart';
import 'package:nex_task/utils/enums/tasks_list_screen_state.dart';
import 'package:nex_task/view/components/cards/task_card.dart';
import 'package:nex_task/view/components/modals/create_task_modal.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  TasksListScreenState screenState = TasksListScreenState.loading;
  List<Map<String, dynamic>> completeList = [];
  List<TaskCard> toShowList = [];
  TextEditingController controller = TextEditingController();
  List<String> imageList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    StorageService.getTasksImages().then((value) {
      imageList = value;
    });

    TasksController.getTasks().then((value) {
      setState(() {
        completeList = value;
        toShowList =
            value
                .map(
                  (element) => TaskCard(
                    id: element["id"],
                    title: element["title"],
                    description: element["description"],
                    dueDate: element["due_date"],
                    category: element["category"],
                    status: element["status"],
                    hasImage: imageList.contains(element["id"]),
                  ),
                )
                .toList();
        screenState = TasksListScreenState.list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add filter for each progress status
    return Scaffold(
      body:
          screenState == TasksListScreenState.list
              ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SearchBar(
                      hintText: "search for a task",
                      controller: controller,
                      onChanged: (value) {
                        setState(() {
                          toShowList = newTaskList(completeList, value);
                        });
                      },
                      leading: Icon(Icons.search),
                    ),
                  ),
                  Expanded(child: ListView(children: toShowList)),
                ],
              )
              : screenState == TasksListScreenState.newTask
              ? Center(child: CreateTaskModal())
              : Center(child: CircularProgressIndicator(color: Colors.orange)),
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

List<TaskCard> newTaskList(List<Map<String, dynamic>> list, String query) {
  return list
      .where((element) => element["title"].toString().toLowerCase().contains(query.toLowerCase()))
      .map(
        (element) => TaskCard(
          id: element["id"],
          title: element["title"],
          description: element["description"],
          dueDate: element["due_date"],
          category: element["category"],
          status: element["status"],
          hasImage: list.contains(element["id"]),
        ),
      )
      .toList();
}
