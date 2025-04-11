import 'package:quickchance_app/features/auth/data/datasource/remote/authapiservice.dart';
import 'package:quickchance_app/features/auth/data/model/login_model.dart';
import 'package:quickchance_app/features/auth/data/model/user_model.dart';
import 'package:quickchance_app/features/auth/domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<UserModel> signin(LoginModel loginModel) async {
    return await AuthApiService().login(loginModel);
  }
}
