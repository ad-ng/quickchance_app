import 'package:quickchance_app/features/auth/data/model/login_model.dart';
import 'package:quickchance_app/features/auth/data/model/user_model.dart';

abstract class AuthRepo {
  Future<UserModel> signin(LoginModel loginModel);
}
