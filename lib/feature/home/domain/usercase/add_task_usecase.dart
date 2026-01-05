import 'package:tasky/core/network/result_firbase.dart';
import 'package:tasky/feature/home/domain/entities/task_entity.dart';
import 'package:tasky/feature/home/domain/repo/repositry/repo.dart';

class AddTaskUseCase{
  AddTaskUseCase(this._homeRepo);
HomeRepo _homeRepo;

Future <ResultFB<TaskEntity>> call(TaskEntity taskEntity) async=>await _homeRepo.addTask(taskEntity);
}
AddTaskUseCase injectableAddTasksUseCase()=>AddTaskUseCase(injectablehomeRepo);