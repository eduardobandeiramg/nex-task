import 'package:flutter/material.dart';
import 'package:nex_task/utils/dimensions.dart';
import 'package:nex_task/view/components/banners/confirm_task_deletion_banner.dart';
import 'package:nex_task/view/components/banners/confirm_task_status_change.dart';
import 'package:nex_task/view/components/cards/task_details_card.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
        title: Text("Task Details", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              "https://images.unsplash.com/photo-1582735689369-4fe89db7114c?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            ),
            SizedBox(height: Dimensions.height * 0.05),
            TaskDetailsCard(title: "Task", value: widget.title!),
            TaskDetailsCard(title: "Description", value: widget.description!),
            TaskDetailsCard(title: "Category", value: widget.category!),
            TaskDetailsCard(title: "Due to", value: widget.dueDate!),
            TaskDetailsCard(title: "Status", value: widget.status!),
            SizedBox(height: Dimensions.height * 0.07),
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
          ],
        ),
      ),
    );
  }
}
