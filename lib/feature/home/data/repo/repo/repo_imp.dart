import 'package:tasky/core/network/result_firbase.dart';
import 'package:tasky/feature/home/domain/entities/task_entity.dart';
import 'package:tasky/feature/home/domain/repo/data_source/data_source.dart';
import 'package:tasky/feature/home/domain/repo/repositry/repo.dart';

class HomeRepoImp extends HomeRepo{
  HomeRepoImp(this._homeDataSource);
  HomeDataSource _homeDataSource;
  @override
  Future<ResultFB<TaskEntity>> addTask(TaskEntity taskEntity) =>_homeDataSource.addTask(taskEntity);

  @override
  Future<ResultFB<List<TaskEntity>>> getTasks( DateTime dateTime) =>_homeDataSource.getTasks(dateTime);

  @override
  Future<ResultFB<TaskEntity>> updateTask(TaskEntity taskEntity)=>_homeDataSource.updateTask(taskEntity);

}