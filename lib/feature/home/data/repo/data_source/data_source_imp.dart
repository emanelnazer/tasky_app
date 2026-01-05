import 'package:tasky/core/network/result_firbase.dart';
import 'package:tasky/feature/home/data/firebase/task_firebase.dart';
import 'package:tasky/feature/home/data/model/task_dto.dart';
import 'package:tasky/feature/home/domain/entities/task_entity.dart';
import 'package:tasky/feature/home/domain/repo/data_source/data_source.dart';

class HomeDataSourceImpl implements HomeDataSource {
  final FireBaseTask _fireBaseTask;

  HomeDataSourceImpl(this._fireBaseTask);

  @override
  Future<ResultFB<TaskEntity>> addTask(TaskEntity taskEntity) async {
    final result = await _fireBaseTask.addTask(
      TaskDto(
        id: taskEntity.id,
        title: taskEntity.title,
        description: taskEntity.description,
        date: taskEntity.date,
        priority: taskEntity.priority,
        isCompleted: taskEntity.isCompleted,
      ),
    );

    switch (result) {
      case SucessFB<TaskDto>():
        return SucessFB<TaskEntity>(
          data: result.data.toEntity(),
        );

      case ErrorFB<TaskDto>():
        return ErrorFB<TaskEntity>(result.message);

      default:
        return ErrorFB<TaskEntity>('Unknown error');
    }
  }

  @override
  Future<ResultFB<List<TaskEntity>>> getTasks(DateTime date) async {
    final result = await _fireBaseTask.getTask(date);

    switch (result) {
      case SucessFB<List<TaskDto>>():
        return SucessFB<List<TaskEntity>>(
          data: result.data.map((e) => e.toEntity()).toList(),
        );

      case ErrorFB<List<TaskDto>>():
        return ErrorFB<List<TaskEntity>>(result.message);

      default:
        return ErrorFB<List<TaskEntity>>('Unknown error');
    }
  }

  @override
  Future<ResultFB<TaskEntity>> updateTask(TaskEntity taskEntity) async {
    final result = await _fireBaseTask.updateTask(
      TaskDto(
        id: taskEntity.id,
        title: taskEntity.title,
        description: taskEntity.description,
        date: taskEntity.date,
        priority: taskEntity.priority,
        isCompleted: taskEntity.isCompleted,
      ),
    );

    switch (result) {
      case SucessFB<TaskDto>():
        return SucessFB<TaskEntity>(
          data: result.data.toEntity(),
        );

      case ErrorFB<TaskDto>():
        return ErrorFB<TaskEntity>(result.message);

      default:
        return ErrorFB<TaskEntity>('Unknown error');
    }
  }
}
HomeDataSource injectHomeDataSourceImp=HomeDataSourceImpl(injectHomeFirebase());