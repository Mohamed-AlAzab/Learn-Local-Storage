import 'package:flutter/material.dart';
import 'package:learn_local_storage/custom_text_field.dart';
import 'package:learn_local_storage/task_item.dart';
import 'package:learn_local_storage/task_model.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController title = TextEditingController();

  TextEditingController subTitle = TextEditingController();

  TextEditingController date = TextEditingController();

  List<TaskModel> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskItem(task: tasks[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('+', style: TextStyle(fontSize: 24)),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                width: double.infinity,
                color: Colors.blue[200],
                child: Column(
                  children: [
                    CustomTextField(label: 'Title', controller: title),
                    CustomTextField(label: 'Subtitle', controller: subTitle),
                    CustomTextField(
                      label: 'Date',
                      controller: date,
                      onClick: () {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        ).then((selctedDate) {
                          date.text = selctedDate.toString();
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        var model = TaskModel(
                          title: title.text,
                          subTitle: subTitle.text,
                          date: DateTime.parse(date.text),
                          isChecked: false,
                        );
                        setState(() {
                          tasks.add(model);
                        });
                        title.clear();
                        subTitle.clear();
                        date.clear();
                        Navigator.pop(context);
                      },
                      child: const Text('Create Task'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
