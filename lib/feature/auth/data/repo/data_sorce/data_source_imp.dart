import 'package:tasky/core/network/result_firbase.dart';
import 'package:tasky/feature/auth/data/firebase/firebase_database_user.dart';
import 'package:tasky/feature/auth/data/model/user_dto.dart';
import 'package:tasky/feature/auth/domain/entities/auth_entity.dart';
import 'package:tasky/feature/auth/domain/repo/data_source/auth_data_source.dart';



class AuthDataSourceImp extends AuthDataSource {
  AuthDataSourceImp(this._authFirebase);

  final FBFSAuthUser _authFirebase;

  @override
  Future<ResultFB<AuthEntity>> login({
    String? email,
    String? password,
  }) async {
    final result = await _authFirebase.loginuser(
   UserDto(email: email,password: password)
    );

    switch (result) {
      case SucessFB<UserDto>():
        return SucessFB<AuthEntity>(
          data: result.data.toEntity(),
        );

      case ErrorFB<UserDto>():
        return ErrorFB<AuthEntity>(result.message);

      default:
        return ErrorFB<AuthEntity>('Unknown error');
    }
  }

  @override
  Future<ResultFB<AuthEntity>> register({String? name, String? email, String? password}) async{
   final result=await _authFirebase.registerUser(UserDto(name: name,email: email,password:password ));
   switch(result){
     case SucessFB<UserDto>():
       return SucessFB<AuthEntity>(data: result.data.toEntity());
     case ErrorFB<UserDto>():
       return ErrorFB<AuthEntity>(result.message);

     default:
       return ErrorFB<AuthEntity>('Unknown error');
   }
  }
}

AuthDataSource injectAuthDataSourceImp = AuthDataSourceImp(injectAuthFB());