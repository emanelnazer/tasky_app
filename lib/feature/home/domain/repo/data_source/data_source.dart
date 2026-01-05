import 'package:tasky/core/network/result_firbase.dart';
import 'package:tasky/feature/home/domain/entities/task_entity.dart';

abstract class HomeDataSource {
  Future<ResultFB<TaskEntity>> addTask(TaskEntity taskEntity);
  Future<ResultFB<List<TaskEntity>>> getTasks(DateTime date);
  Future<ResultFB<TaskEntity>> updateTask(TaskEntity taskEntity);
}
