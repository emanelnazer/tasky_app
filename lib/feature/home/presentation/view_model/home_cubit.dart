import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/network/result_firbase.dart';
import 'package:tasky/feature/home/domain/entities/task_entity.dart';
import 'package:tasky/feature/home/domain/usercase/add_task_usecase.dart';
import 'package:tasky/feature/home/domain/usercase/get_task_usecase.dart';
import 'package:tasky/feature/home/domain/usercase/update_task_usecase.dart';
import 'package:tasky/feature/home/presentation/view_model/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
      this._addTaskUseCase,
      this._getTaskUseCase,
      this._updateTasksUseCase,
      ) : super(InitalState());

  final AddTaskUseCase _addTaskUseCase;
  final GetTaskUseCase _getTaskUseCase;
  final UpdateTasksUseCase _updateTasksUseCase;

  List<TaskEntity> tasks = [];
  List<TaskEntity> completedTasks = [];

  Future<void> getTasks(DateTime date) async {
    emit(HomaLoadingSate());

    final result = await _getTaskUseCase(date);

    switch (result) {
      case SucessFB<List<TaskEntity>>():
        tasks = result.data
            .where((task) => task.isCompleted == false)
            .toList();

        completedTasks = result.data
            .where((task) => task.isCompleted == true)
            .toList();

        emit(HomeSucessState());

      case ErrorFB<List<TaskEntity>>():
        emit(HomeErrorState());
    }
  }

  Future<void> updateTask(TaskEntity task) async {
    emit(HomaLoadingSate());

    final result = await _updateTasksUseCase(task);

    switch (result) {
      case SucessFB<TaskEntity>():
        if (task.isCompleted) {
          tasks.removeWhere((e) => e.id == task.id);
          completedTasks.add(task);
        } else {
          completedTasks.removeWhere((e) => e.id == task.id);
          tasks.add(task);
        }
        emit(HomeSucessState());

      case ErrorFB<TaskEntity>():
        emit(HomeErrorState());
    }
  }

  Future<void> addTask(TaskEntity task) async {
    emit(HomaLoadingSate());

    final result = await _addTaskUseCase(task);

    switch (result) {
      case SucessFB<TaskEntity>():
        tasks.add(result.data);
        emit(HomeSucessState());

      case ErrorFB<TaskEntity>():
        emit(HomeErrorState());
    }
  }
}
