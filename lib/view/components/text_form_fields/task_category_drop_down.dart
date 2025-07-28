import 'package:flutter/material.dart';
import 'package:nex_task/utils/dimensions.dart';
import 'package:nex_task/view/state_management/new_task_form_state/category_selection_state.dart';

class TaskCategoryDropDown extends StatefulWidget {
  List<String> categoriesList;

  TaskCategoryDropDown({super.key, required this.categoriesList});

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
        child: DropdownButtonFormField<String>(
          alignment: AlignmentDirectional.center,
          hint: Text("category"),
          borderRadius: BorderRadius.circular(25),
          items:
              widget.categoriesList
                  .map((element) => DropdownMenuItem(child: Text(element), value: element))
                  .toList(),
          onChanged: (value) {
            CategorySelectionState.category = value;
          },
        ),
      ),
    );
  }
}

List<DropdownMenuItem> returnItems(List<String> categoriesList) {
  List<DropdownMenuItem> dropDownMenuItemList = [];
  for (var category in categoriesList) {
    dropDownMenuItemList.add(DropdownMenuItem(child: Text(category), value: category));
  }
  return dropDownMenuItemList;
}
