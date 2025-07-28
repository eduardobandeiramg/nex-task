import 'package:flutter/material.dart';
import 'package:nex_task/utils/dimensions.dart';
import 'package:nex_task/view/state_management/new_task_form_state/category_selection_state.dart';

class TaskCategoryDropDown extends StatefulWidget {
  const TaskCategoryDropDown({super.key});

  @override
  State<TaskCategoryDropDown> createState() => _TaskCategoryDropDownState();
}

class _TaskCategoryDropDownState extends State<TaskCategoryDropDown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: (Dimensions.width * 0.8) * 0.4,
        child: DropdownButtonFormField(
          alignment: AlignmentDirectional.center,
          hint: Text("category"),
          borderRadius: BorderRadius.circular(25),
          items: [
            DropdownMenuItem(value: "item 1", child: Text("item 1")),
            DropdownMenuItem(value: "item 2", child: Text("item 2")),
            DropdownMenuItem(value: "item 3", child: Text("item 3")),
          ],
          onChanged: (value) {
            CategorySelectionState.category = value;
          },
        ),
      ),
    );
  }
}
