import 'package:flutter/material.dart';
import 'package:nex_task/controller/tasks_controller.dart';
import 'package:nex_task/model/enums/status.dart';
import 'package:nex_task/model/models/task.dart';
import 'package:nex_task/services/database/tasks_database.dart';
import 'package:nex_task/utils/dimensions.dart';
import 'package:nex_task/utils/enums/button_types.dart';
import 'package:nex_task/utils/enums/text_form_field_input.dart';
import 'package:nex_task/view/components/buttons/standard_button.dart';
import 'package:nex_task/view/components/text_form_fields/smaller_standard_text_form_field.dart';
import 'package:nex_task/view/components/text_form_fields/standard_text_form_field.dart';
import 'package:nex_task/view/components/text_form_fields/task_category_drop_down.dart';
import 'package:nex_task/view/screens/navigation_screen/navigation_screen.dart';
import 'package:nex_task/view/state_management/new_task_form_state/category_selection_state.dart';

class CreateTaskModal extends StatefulWidget {
  const CreateTaskModal({super.key});

  @override
  State<CreateTaskModal> createState() => _CreateTaskModalState();
}

class _CreateTaskModalState extends State<CreateTaskModal> {
  final key = GlobalKey<FormState>();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController taskDueDateController = TextEditingController();
  TextEditingController taskNewCategoryController = TextEditingController();
  TextEditingController taskStatusController = TextEditingController();
  List<String> categoriesList = [];
  bool newCategory = false;

  @override
  void initState() {
    super.initState();
    TasksDatabase.getCategories().then((value) {
      setState(() {
        categoriesList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.zero, color: Color(0xFFE3F2FD)),
        height: Dimensions.height * 0.7,
        width: Dimensions.width * 0.8,
        child: Form(
          key: key,
          child: Column(
            children: [
              SizedBox(height: Dimensions.height * 0.05),
              Text("create a new task", style: TextStyle(fontSize: 20)),
              Expanded(
                child: ListView(
                  children: [
                    SmallerStandardTextFormField(
                      textFormFieldInput: TextFormFieldInput.taskTitle,
                      controller: taskTitleController,
                    ),
                    SmallerStandardTextFormField(
                      textFormFieldInput: TextFormFieldInput.taskDescription,
                      controller: taskDescriptionController,
                    ),
                    SmallerStandardTextFormField(
                      textFormFieldInput: TextFormFieldInput.taskDueDate,
                      controller: taskDueDateController,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TaskCategoryDropDown(categoriesList: categoriesList),
                          flex: 3,
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                newCategory = true;
                              });
                            },
                            icon: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                    if (newCategory)
                      SmallerStandardTextFormField(
                        textFormFieldInput: TextFormFieldInput.newCategory,
                        controller: taskNewCategoryController,
                      ),
                    StandardButton(
                      buttonTypes: ButtonTypes.createTask,
                      onPressed: () async {
                        if (key.currentState!.validate()) {
                          String? newCategory = null;
                          if (CategorySelectionState.category != null ||
                              taskNewCategoryController.text.isNotEmpty) {
                            // checks whether the user added a new or and old category:
                            String category =
                                CategorySelectionState.category != null
                                    ? CategorySelectionState.category!
                                    : taskNewCategoryController.text;
                            Task newTask = Task(
                              title: taskTitleController.text,
                              description: taskDescriptionController.text,
                              dueDate: taskDueDateController.text,
                              category: category.toLowerCase(),
                              status: TaskStatus.toDo,
                            );
                            // checks if user added a new category:
                            if (taskNewCategoryController.text.isNotEmpty) {
                              taskNewCategoryController.text.toLowerCase();
                              if (!categoriesList.contains(taskNewCategoryController.text)) {
                                newCategory = taskNewCategoryController.text;
                              }
                            }
                            CategorySelectionState.category = null;
                            await TasksController.createTask(newTask);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => NavigationScreen()),
                            );
                          }
                        } else {}
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
