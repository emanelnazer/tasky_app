import 'package:tasky/core/network/result_firbase.dart';
import 'package:tasky/feature/home/domain/entities/task_entity.dart';
import 'package:tasky/feature/home/domain/repo/repositry/repo.dart';

class GetTaskUseCase{
  GetTaskUseCase(this._homeRepo);
  final HomeRepo _homeRepo;

 Future<ResultFB<List<TaskEntity>>> call(DateTime dateTime)async=>await _homeRepo.getTasks(dateTime);
}
GetTaskUseCase injectableGetTasksUseCase()=>GetTaskUseCase(injectablehomeRepo);