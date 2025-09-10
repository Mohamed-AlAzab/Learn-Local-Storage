part of 'todo_cubit.dart';

@immutable
sealed class TodoState {}

final class TodoInit extends TodoState {}

final class TodoLoading extends TodoState {}

final class TodoLoaded extends TodoState {
  final List<TaskModel> tasks;

  TodoLoaded(this.tasks);
}

final class TodoError extends TodoState {}