class TaskModel {
  final String title;
  final String subTitle;
  final DateTime date;
  bool isChecked;

  TaskModel({
    required this.title,
    DateTime? date,
    this.subTitle = '',
    this.isChecked = false,
  }) : date = date ?? DateTime.now();
}
