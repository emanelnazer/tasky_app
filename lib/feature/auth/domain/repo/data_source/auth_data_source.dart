import 'package:tasky/core/network/result_firbase.dart';
import 'package:tasky/feature/auth/domain/entities/auth_entity.dart';

abstract class AuthDataSource {
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
