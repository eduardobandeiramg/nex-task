import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nex_task/services/database/tasks_database.dart';
import 'package:nex_task/services/storage/storage_service.dart';
import 'package:nex_task/utils/dimensions.dart';
import 'package:nex_task/utils/enums/button_types.dart';
import 'package:nex_task/utils/enums/text_form_field_input.dart';
import 'package:nex_task/view/components/banners/confirm_task_deletion_banner.dart';
import 'package:nex_task/view/components/banners/confirm_task_status_change.dart';
import 'package:nex_task/view/components/buttons/standard_button.dart';
import 'package:nex_task/view/components/cards/task_details_card.dart';
import 'package:nex_task/view/components/text_form_fields/updating_task_field.dart';
import 'package:nex_task/view/screens/navigation_screen/navigation_screen.dart';
import 'package:nex_task/view/state_management/new_task_form_state/category_selection_state.dart';
import '../../components/text_form_fields/task_category_drop_down.dart';
import 'package:video_player/video_player.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class TaskDetails extends StatefulWidget {
  String? id;
  String? title;
  String? description;
  String? dueDate;
  String? category;
  String? status;
  String? mediaType;

  TaskDetails({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
    required this.status,
    this.mediaType,
  });

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  List<String> categoriesList = [];
  String? mediaUrl;

  bool editingTitle = false;
  bool editingDescription = false;
  bool editingCategory = false;
  bool editingDueDate = false;

  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController taskDueDateController = TextEditingController();

  File? image;
  File? video;
  bool hasImage = false;
  bool hasVideo = false;
  bool hasImageFile = false;
  bool hasVideoFile = false;
  final ImagePicker imagePicker = ImagePicker();

  late final player = Player();
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    print(widget.mediaType);
    TasksDatabase.getCategories().then((value) {
      setState(() {
        categoriesList = value;
      });
    });
    if (widget.mediaType != null) {
      if (widget.mediaType!.contains("image")) {
        StorageService.getTaskImage(widget.id!).then((value) {
          setState(() {
            hasImage = true;
            mediaUrl = value;
          });
        });
      } else if (widget.mediaType!.contains("video")) {
        StorageService.getTaskImage(widget.id!).then((value) {
          setState(() {
            hasVideo = true;
            player.open(Media(value));
          });
        });
      }
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
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
            child:
                hasImage
                    ? Image.network(mediaUrl!, fit: BoxFit.cover)
                    : hasImageFile
                    ? Image.file(image!)
                    : hasVideo
                    ? Video(controller: controller)
                    : Image.asset(
                      "assets/images/task_standard_image/to_do_list.jpg",
                      fit: BoxFit.cover,
                    ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  final fileChosen = await imagePicker.pickImage(source: ImageSource.camera);
                  if (fileChosen != null) {
                    setState(() {
                      hasImageFile = true;
                      image = File(fileChosen.path);
                    });
                    try {
                      await StorageService.addPhoto(File(fileChosen.path), widget.id!);
                    } catch (e) {
                      print("exception: $e");
                    }
                  }
                },
                icon: Icon(Icons.camera_alt),
              ),
              IconButton(
                onPressed: () async {
                  final fileChosen = await imagePicker.pickImage(source: ImageSource.gallery);
                  if (fileChosen != null) {
                    setState(() {
                      hasImageFile = true;
                      image = File(fileChosen.path);
                    });
                    try {
                      await StorageService.addPhoto(File(fileChosen.path), widget.id!);
                      mediaUrl = await StorageService.getTaskImage(widget.id!);
                    } catch (e) {
                      print("exception: $e");
                    }
                  }
                },
                icon: Icon(Icons.photo),
              ),
              IconButton(
                onPressed: () async {
                  final fileChosen = await imagePicker.pickVideo(source: ImageSource.camera);
                  if (fileChosen != null) {
                    /*                    setState(() {
                      image = File(fileChosen.path);
                    });*/
                    try {
                      await StorageService.addPhoto(File(fileChosen.path), widget.id!);
                      mediaUrl = await StorageService.getTaskImage(widget.id!);
                      setState(() {});
                    } catch (e) {
                      print("exception: $e");
                    }
                  }
                },
                icon: Icon(Icons.video_call_outlined),
              ),
              IconButton(
                onPressed: () async {
                  final fileChosen = await imagePicker.pickVideo(source: ImageSource.gallery);
                  if (fileChosen != null) {
                    /*                    setState(() {
                      image = File(fileChosen.path);
                    });*/
                    try {
                      await StorageService.addPhoto(File(fileChosen.path), widget.id!);
                      mediaUrl = await StorageService.getTaskImage(widget.id!);
                      setState(() {});
                    } catch (e) {
                      print("exception: $e");
                    }
                  }
                },
                icon: Icon(Icons.video_collection),
              ),
            ],
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
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: TaskDetailsCard(
                        title: "Status",
                        value:
                            widget.status! == "to-do"
                                ? "to do"
                                : widget.status! == "in_progress"
                                ? "in progress"
                                : "done",
                      ),
                    ),
                    Expanded(child: SizedBox(), flex: 1),
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
