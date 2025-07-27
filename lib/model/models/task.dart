import '../enums/status.dart';

class Task {
  String title;
  String description;
  String dueDate;
  String category;
  Status status;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
    required this.status,
  });
}
