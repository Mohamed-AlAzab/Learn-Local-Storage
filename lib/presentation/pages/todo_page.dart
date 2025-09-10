import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_local_storage/presentation/cubit/todo_cubit.dart';
import 'package:learn_local_storage/presentation/widget/custom_text_field.dart';
import 'package:learn_local_storage/presentation/widget/task_item.dart';
import 'package:learn_local_storage/data/task_model.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController title = TextEditingController();
  TextEditingController subTitle = TextEditingController();
  TextEditingController date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is TodoLoaded) {
            if (state.tasks.isEmpty) {
              return Center(child: Text('Empty Todo !'));
            }
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                return TaskItem(
                  task: state.tasks[index],
                  onChanged: (newValue) {
                    context.read<TodoCubit>().updateTask(
                      TaskModel(
                        id: state.tasks[index].id,
                        title: state.tasks[index].title,
                        subTitle: state.tasks[index].subTitle,
                        date: state.tasks[index].date,
                        isChecked: newValue ?? false,
                      ),
                    );
                  },
                );
              },
            );
          }
          if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(child: Text('Error !!'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('+', style: TextStyle(fontSize: 24)),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (bcontext) {
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
                          context: bcontext,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        ).then((selctedDate) {
                          date.text = selctedDate.toString();
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        var task = TaskModel(
                          title: title.text,
                          subTitle: subTitle.text,
                          date: DateTime.parse(date.text),
                          isChecked: false,
                        );
                        context.read<TodoCubit>().addTask(task);
                        title.clear();
                        subTitle.clear();
                        date.clear();
                        Navigator.pop(bcontext);
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
