import 'package:equatable/equatable.dart';
import '../models/task.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
  @override
  List<Object?> get props => [];
}

class LoadTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final Task task;
  const AddTaskEvent(this.task);
  @override
  List<Object?> get props => [task];
}

class EditTaskEvent extends TaskEvent {
  final int index;
  final Task updatedTask;
  const EditTaskEvent(this.index, this.updatedTask);
  @override
  List<Object?> get props => [index, updatedTask];
}

class ToggleTaskCompletionEvent extends TaskEvent {
  final int index;
  const ToggleTaskCompletionEvent(this.index);
  @override
  List<Object?> get props => [index];
}

class RemoveTaskEvent extends TaskEvent {
  final int index;
  const RemoveTaskEvent(this.index);
  @override
  List<Object?> get props => [index];
}

class ClearAllTasksEvent extends TaskEvent {}
