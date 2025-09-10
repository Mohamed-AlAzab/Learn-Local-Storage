import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_local_storage/data/task_database.dart';
import 'package:learn_local_storage/data/task_model.dart';
import 'package:meta/meta.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInit());

  Future<void> init() async {
    emit(TodoLoading());
    try {
      var tasks = await TaskDatabase.instance.getTasks();
      emit(TodoLoaded(tasks));
    } catch (e) {
      emit(TodoError());
    }
  }

  Future<void> getTasks() async {
    try {
      var tasks = await TaskDatabase.instance.getTasks();
      emit(TodoLoaded(tasks));
    } catch (e) {
      emit(TodoError());
    }
  }

  Future<void> addTask(TaskModel task) async {
    try {
      await TaskDatabase.instance.createTask(task);
      getTasks();
    } catch (e) {
      emit(TodoError());
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await TaskDatabase.instance.updateTask(task, task.id!);
      getTasks();
    } catch (e) {
      emit(TodoError());
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await TaskDatabase.instance.deleteTask(id);
      getTasks();
    } catch (e) {
      emit(TodoError());
    }
  }
}
