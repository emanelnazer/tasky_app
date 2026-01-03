import 'package:tasky/core/network/result_firbase.dart';
import 'package:tasky/feature/auth/data/repo/data_sorce/data_source_imp.dart';
import 'package:tasky/feature/auth/data/repo/repo/repo_imp.dart';
import 'package:tasky/feature/auth/domain/entities/auth_entity.dart';
abstract class AuthRepo {
  Future<ResultFB<AuthEntity>> login({
    String? email,
    String? password,
  });

  Future<ResultFB<AuthEntity>> register({
    String? name,
    String? email,
    String? password,
  });
}

AuthRepo injectAuthRepo = AuthRepoImp(injectAuthDataSourceImp);