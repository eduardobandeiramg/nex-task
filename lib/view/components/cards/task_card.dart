import 'package:flutter/material.dart';
import 'package:nex_task/utils/dimensions.dart';

class TaskCard extends StatelessWidget {
  String? title;
  String? description;
  String? dueDate;
  String? category;
  String? status;

  TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
              Expanded(child: Icon(Icons.check_box)),
            ],
          ),
        ),
      ),
    );
  }
}
