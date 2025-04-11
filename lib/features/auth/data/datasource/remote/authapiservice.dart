import 'package:dio/dio.dart';
import 'package:quickchance_app/conf/dioservice.dart';
import 'package:quickchance_app/features/auth/data/model/login_model.dart';
import 'package:quickchance_app/features/auth/data/model/user_model.dart';

class AuthApiService {
  final Dio _dio = DioService.instance.dio;

  Future<UserModel> login(LoginModel loginModel) async {
    try {
      final response = await _dio.post('/auth/login', data: loginModel.toMap());

      final dataJson = response.data['data'];

      return UserModel.fromMap(dataJson);
    } on DioException catch (e) {
      throw e.message.toString();
    }
  }
}
