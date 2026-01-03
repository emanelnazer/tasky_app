import 'package:tasky/core/network/result_firbase.dart';
import 'package:tasky/feature/auth/domain/entities/auth_entity.dart';
import 'package:tasky/feature/auth/domain/repo/repository/auth_repo.dart';

class LoginUseCase{
  LoginUseCase(this._authRepo);
 final AuthRepo _authRepo;
 Future<ResultFB<AuthEntity>> call(String email,String password)=>
     _authRepo.login(email: email,password: password);
}
LoginUseCase injectableloginUseCase() => LoginUseCase(injectAuthRepo);