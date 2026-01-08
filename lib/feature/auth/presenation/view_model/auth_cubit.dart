import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/network/result_firbase.dart';
import 'package:tasky/feature/auth/domain/entities/auth_entity.dart';
import 'package:tasky/feature/auth/domain/usescases/login_use_case.dart';
import 'package:tasky/feature/auth/domain/usescases/register_usecase.dart';
import 'package:tasky/feature/auth/presenation/view_model/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._loginUseCase, this._registerUserCase) : super(IntialState());

  final LoginUseCase _loginUseCase;
  final RegisterUserCase _registerUserCase;
  AuthEntity? user;

  Future<void> login({required String email, required String password}) async {
    emit(LoadingState());
    final result = await _loginUseCase(email, password);


    if (result is SucessFB<AuthEntity>) {
      user = result.data;
      emit(SucessState());
    } else if (result is ErrorFB<AuthEntity>) {
      emit(ErrorSate(result.message));
    } else {
      emit(ErrorSate("Unexpected result"));
    }
  }

  Future<void> register({required String name, required String email, required String password}) async {
    emit(LoadingState());
    final result = await _registerUserCase(name, email, password);

    if (result is SucessFB<AuthEntity>) {
      user = result.data;
      emit(SucessState());
    } else if (result is ErrorFB<AuthEntity>) {
      emit(ErrorSate(result.message));
    } else {
      emit(ErrorSate("Unexpected result"));
    }
  }
}