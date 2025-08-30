import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task.dart';
import '../services/local_file_storage.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final LocalFileStorage storage;

  TaskBloc(this.storage) : super(const TaskState()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<EditTaskEvent>(_onEditTask);
    on<ToggleTaskCompletionEvent>(_onToggleTask);
    on<RemoveTaskEvent>(_onRemoveTask);
    on<ClearAllTasksEvent>(_onClearAll);

    add(LoadTasksEvent()); // load at startup
  }

  Future<void> _onLoadTasks(
    LoadTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    final tasks = await storage.loadTasks();
    emit(state.copyWith(tasks: tasks));
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    final updated = List<Task>.from(state.tasks)..add(event.task);
    emit(state.copyWith(tasks: updated));
    await storage.saveTasks(updated);
  }

  Future<void> _onEditTask(EditTaskEvent event, Emitter<TaskState> emit) async {
    final updated = List<Task>.from(state.tasks);
    updated[event.index] = event.updatedTask;
    emit(state.copyWith(tasks: updated));
    await storage.saveTasks(updated);
  }

  Future<void> _onToggleTask(
    ToggleTaskCompletionEvent event,
    Emitter<TaskState> emit,
  ) async {
    final updated = List<Task>.from(state.tasks);
    updated[event.index] = updated[event.index].copyWith(
      isDone: !updated[event.index].isDone,
    );
    emit(state.copyWith(tasks: updated));
    await storage.saveTasks(updated);
  }

  Future<void> _onRemoveTask(
    RemoveTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final updated = List<Task>.from(state.tasks)..removeAt(event.index);
    emit(state.copyWith(tasks: updated));
    await storage.saveTasks(updated);
  }

  Future<void> _onClearAll(
    ClearAllTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(tasks: []));
    await storage.saveTasks([]);
  }
}
