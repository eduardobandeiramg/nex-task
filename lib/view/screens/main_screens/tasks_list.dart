import 'package:flutter/material.dart';
import 'package:nex_task/view/components/cards/task_card.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Add filter for each progress status
    return Scaffold(
      body: ListView(
        children: [
          TaskCard(name: "task 1"),
          TaskCard(name: "task 2"),
          TaskCard(name: "task 3"),
          TaskCard(name: "task 4"),
          TaskCard(name: "task 5"),
        ],
      ),
    );
  }
}
