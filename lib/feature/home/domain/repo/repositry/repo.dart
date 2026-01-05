import 'package:tasky/core/network/result_firbase.dart';
import 'package:tasky/feature/home/data/repo/data_source/data_source_imp.dart';
import 'package:tasky/feature/home/data/repo/repo/repo_imp.dart';
import 'package:tasky/feature/home/domain/entities/task_entity.dart';

abstract class HomeRepo{
  Future<ResultFB<TaskEntity>> addTask(TaskEntity taskEntity);
  Future<ResultFB<List<TaskEntity>>> getTasks(DateTime dateTime);
  Future<ResultFB<TaskEntity>> updateTask(TaskEntity taskEntity);
}
HomeRepo injectablehomeRepo=HomeRepoImp(injectHomeDataSourceImp);
