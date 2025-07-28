import 'package:flutter/material.dart';
import 'package:nex_task/services/database/tasks_database.dart';
import 'package:nex_task/utils/dimensions.dart';
import 'package:nex_task/utils/enums/button_types.dart';
import 'package:nex_task/utils/enums/text_form_field_input.dart';
import 'package:nex_task/view/components/banners/confirm_task_deletion_banner.dart';
import 'package:nex_task/view/components/banners/confirm_task_status_change.dart';
import 'package:nex_task/view/components/buttons/standard_button.dart';
import 'package:nex_task/view/components/cards/task_details_card.dart';
import 'package:nex_task/view/components/text_form_fields/standard_text_form_field_smaller.dart';
import 'package:nex_task/view/screens/navigation_screen/navigation_screen.dart';
import 'package:nex_task/view/state_management/new_task_form_state/category_selection_state.dart';
import '../../components/text_form_fields/task_category_drop_down.dart';

class TaskDetails extends StatefulWidget {
  String? id;
  String? title;
  String? description;
  String? dueDate;
  String? category;
  String? status;

  TaskDetails({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
    required this.status,
  });

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  List<String> categoriesList = [];

  bool editingTitle = false;
  bool editingDescription = false;
  bool editingCategory = false;
  bool editingDueDate = false;

  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();

  //TextEditingController taskCategoryController = TextEditingController();
  TextEditingController taskDueDateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TasksDatabase.getCategories().then((value) {
      setState(() {
        categoriesList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Details", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Dimensions.width,
            height: Dimensions.height * 0.22,
            child: Image.asset(
              "lib/assets/images/task_standard_image/to_do_list.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: Dimensions.height * 0.02),
          Expanded(
            child: ListView(
              children: [
                Row(
                  children: [
                    if (!editingTitle)
                      Expanded(
                        flex: 9,
                        child: TaskDetailsCard(title: "Task", value: widget.title!),
                      ),
                    if (editingTitle)
                      Expanded(
                        flex: 9,
                        child: UpdatingTaskField(
                          textFormFieldInput: TextFormFieldInput.taskTitle,
                          controller: taskTitleController,
                        ),
                      ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            editingTitle ? editingTitle = false : editingTitle = true;
                          });
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (!editingDescription)
                      Expanded(
                        child: TaskDetailsCard(title: "Description", value: widget.description!),
                        flex: 9,
                      ),
                    if (editingDescription)
                      Expanded(
                        flex: 9,
                        child: UpdatingTaskField(
                          textFormFieldInput: TextFormFieldInput.taskDescription,
                          controller: taskDescriptionController,
                        ),
                      ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            editingDescription
                                ? editingDescription = false
                                : editingDescription = true;
                          });
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (!editingCategory)
                      Expanded(
                        child: TaskDetailsCard(title: "Category", value: widget.category!),
                        flex: 9,
                      ),
                    if (editingCategory)
                      Expanded(
                        flex: 9,
                        child: TaskCategoryDropDown(categoriesList: categoriesList),
                      ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            editingCategory ? editingCategory = false : editingCategory = true;
                          });
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (!editingDueDate)
                      Expanded(
                        child: TaskDetailsCard(title: "Due to", value: widget.dueDate!),
                        flex: 9,
                      ),
                    if (editingDueDate)
                      Expanded(
                        flex: 9,
                        child: UpdatingTaskField(
                          textFormFieldInput: TextFormFieldInput.taskDueDate,
                          controller: taskDueDateController,
                        ),
                      ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            editingDueDate ? editingDueDate = false : editingDueDate = true;
                          });
                        },
                        icon: Icon(Icons.edit),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height * 0.07),
                if (editingTitle == false &&
                    editingDescription == false &&
                    editingCategory == false &&
                    editingDueDate == false)
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => buildConfirmTaskDeletionBanner(
                                    taskId: widget.id!,
                                    context: context,
                                  ),
                            );
                          },
                          icon: Icon(Icons.delete, color: Colors.red, size: Dimensions.width * 0.1),
                        ),
                      ),
                      if (widget.status == "to_do")
                        Expanded(
                          flex: 2,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => buildConfirmTaskStatusChangeBanner(
                                      taskId: widget.id!,
                                      context: context,
                                      newStatus: "in_progress",
                                    ),
                              );
                            },
                            icon: Icon(
                              Icons.play_circle,
                              color: Colors.blue,
                              size: Dimensions.width * 0.1,
                            ),
                          ),
                        ),
                      if (widget.status == "in_progress")
                        Expanded(
                          flex: 2,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => buildConfirmTaskStatusChangeBanner(
                                      taskId: widget.id!,
                                      context: context,
                                      newStatus: "done",
                                    ),
                              );
                            },
                            icon: Icon(
                              Icons.check_box,
                              color: Colors.green,
                              size: Dimensions.width * 0.1,
                            ),
                          ),
                        ),
                    ],
                  ),
                if (editingTitle || editingDescription || editingCategory || editingDueDate)
                  StandardButton(
                    dimensions: Dimensions.width * 0.7,
                    buttonTypes: ButtonTypes.editTask,
                    onPressed: () async {
                      if (taskTitleController.text.isNotEmpty) {
                        await TasksDatabase.updateTask(widget.id!, {
                          "title": taskTitleController.text,
                        });
                      }
                      if (taskDescriptionController.text.isNotEmpty) {
                        await TasksDatabase.updateTask(widget.id!, {
                          "description": taskDescriptionController.text,
                        });
                      }
                      if (CategorySelectionState.category != null) {
                        await TasksDatabase.updateTask(widget.id!, {
                          "category": CategorySelectionState.category!.toLowerCase(),
                        });
                        CategorySelectionState.category = null;
                      }
                      if (taskDueDateController.text.isNotEmpty) {
                        await TasksDatabase.updateTask(widget.id!, {
                          "due_date": taskDueDateController.text,
                        });
                      }
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => NavigationScreen()),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
