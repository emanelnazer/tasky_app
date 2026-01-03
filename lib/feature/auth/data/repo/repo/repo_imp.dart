import 'package:tasky/core/network/result_firbase.dart';
import 'package:tasky/feature/auth/domain/entities/auth_entity.dart';
import 'package:tasky/feature/auth/domain/repo/data_source/auth_data_source.dart';
import 'package:tasky/feature/auth/domain/repo/repository/auth_repo.dart';

class AuthRepoImp implements AuthRepo{
  AuthRepoImp(this._authDataSource);
  AuthDataSource _authDataSource;

  @override
  Future<ResultFB<AuthEntity>> login({String? email, String? password}) =>
 _authDataSource.login(email: email,password: password);


  @override
  Future<ResultFB<AuthEntity>> register({String? name, String? email, String? password})=>
      _authDataSource.register(name: name,email: email,password: password);

}