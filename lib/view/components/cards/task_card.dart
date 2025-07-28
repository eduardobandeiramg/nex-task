import 'package:flutter/material.dart';
import 'package:nex_task/utils/dimensions.dart';
import 'package:nex_task/view/screens/secondary_screens/task_details.dart';

class TaskCard extends StatelessWidget {
  String? id;
  String? title;
  String? description;
  String? dueDate;
  String? category;
  String? status;

  TaskCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return TaskDetails(
                id: id,
                title: title,
                description: description,
                dueDate: dueDate,
                category: category,
                status: status,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 4, right: 4),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFBBDEFB),
            borderRadius: BorderRadius.circular(10),
          ),
          height: Dimensions.height * 0.1,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(padding: EdgeInsets.only(left: 12), child: Text(title!)),
              ),
              Expanded(child: Text("due to: $dueDate")),
              Expanded(
                child:
                    status == "to_do"
                        ? Icon(Icons.hourglass_top_outlined)
                        : status == "in_progress"
                        ? Icon(Icons.sync)
                        : Icon(Icons.check_box, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
