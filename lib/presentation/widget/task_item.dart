// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:learn_local_storage/data/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task, required this.onChanged});

  final TaskModel task;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.subTitle),
      leading: CircleAvatar(child: Text('${task.date.month}/${task.date.day}')),
      trailing: Checkbox(value: task.isChecked, onChanged: onChanged),
    );
  }
}
