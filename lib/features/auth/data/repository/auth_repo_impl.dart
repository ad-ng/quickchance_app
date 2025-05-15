import 'package:quickchance_app/features/auth/data/datasource/remote/authapiservice.dart';
import 'package:quickchance_app/features/auth/data/model/login_model.dart';
import 'package:quickchance_app/features/auth/data/model/register_model.dart';
import 'package:quickchance_app/features/auth/data/model/user_model.dart';
import 'package:quickchance_app/features/auth/domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<UserModel> signin(LoginModel loginModel) async {
    return await AuthApiService().login(loginModel);
  }

  @override
  Future<UserModel> signup(RegisterModel registerModel) async {
    return await AuthApiService().register(registerModel);
  }

  @override
  Future googleService() async {
    return await AuthApiService().signInWithGoogle();
  }
}
