import 'package:tasky/core/network/result_firbase.dart';
import 'package:tasky/feature/auth/domain/entities/auth_entity.dart';
import 'package:tasky/feature/auth/domain/repo/repository/auth_repo.dart';

class RegisterUserCase{
  RegisterUserCase(this._authRepo);
  AuthRepo _authRepo;

  Future<ResultFB<AuthEntity>> call(String name,String email,String password)=>
      _authRepo.register(name: name,email: email,password: password);
}
RegisterUserCase injectableregisterUseCase() => RegisterUserCase(injectAuthRepo);