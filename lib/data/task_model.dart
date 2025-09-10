class TaskModel {
  final int? id;
  final String title;
  final String subTitle;
  final DateTime date;
  bool isChecked;

  TaskModel({
    this.id,
    required this.title,
    DateTime? date,
    this.subTitle = '',
    this.isChecked = false,
  }) : date = date ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subTitle': subTitle,
      'date': date.toIso8601String(),
      'isChecked': isChecked ? 1 : 0,
    };
  }

  factory TaskModel.formJson(Map<String, dynamic> task) {
    return TaskModel(
      id: task['id'],
      title: task['title'],
      subTitle: task['subTitle'],
      date: DateTime.parse(task['date']),
      isChecked: task['isChecked'] == 1,
    );
  }
}
