import 'package:dio/dio.dart';
import 'package:quickchance_app/conf/dioservice.dart';
import 'package:quickchance_app/features/auth/data/datasource/local/tokenstore.dart';
import 'package:quickchance_app/features/auth/data/datasource/local/userpreferences.dart';
import 'package:quickchance_app/features/auth/data/model/login_model.dart';
import 'package:quickchance_app/features/auth/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApiService {
  final Dio _dio = DioService.instance.dio;

  Future<UserModel> login(LoginModel loginModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    try {
      final response = await _dio.post('/auth/login', data: loginModel.toMap());

      final dataJson = response.data['data'];

      TokenStore.setToken(response.data['token']);

      UserPreferences().saveLocalUser(UserModel.fromJson(dataJson));

      return UserModel.fromMap(dataJson);
    } on DioException catch (e) {
      throw e.message.toString();
    }
  }
}
