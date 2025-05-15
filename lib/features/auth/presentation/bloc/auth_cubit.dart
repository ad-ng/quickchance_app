import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/auth/data/model/login_model.dart';
import 'package:quickchance_app/features/auth/data/model/register_model.dart';
import 'package:quickchance_app/features/auth/data/model/user_model.dart';
import 'package:quickchance_app/features/auth/domain/repository/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit(this._authRepo) : super(AuthInitial());

  Future<void> login(LoginModel loginModel) async {
    emit(AuthLoading());

    try {
      final response = await _authRepo.signin(loginModel);
      print('fetching user');
      emit(AuthSuccess(response));
    } catch (e) {
      print(e);
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(RegisterModel registerModel) async {
    emit(AuthLoading());

    try {
      final response = await _authRepo.signup(registerModel);
      emit(AuthSuccess(response));
    } catch (e) {
      print(e);
      emit(AuthError(e.toString()));
    }
  }

  Future googleService() async {
    emit(AuthLoading());
    try {
      final response = await _authRepo.googleService();
      emit(AuthSuccess(response));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel response; // Response from the API
  AuthSuccess(this.response);
}

class AuthError extends AuthState {
  final String? message; // Error message
  AuthError(this.message);
}
