import 'package:dio/dio.dart';
import 'package:quickchance_app/conf/dioservice.dart';
import 'package:quickchance_app/features/auth/data/datasource/local/tokenstore.dart';
import 'package:quickchance_app/features/auth/data/datasource/local/userpreferences.dart';
import 'package:quickchance_app/features/auth/data/model/login_model.dart';
import 'package:quickchance_app/features/auth/data/model/register_model.dart';
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

      // Save the token using Tokenstore
      TokenStore.setToken(response.data['token']);

      // Save user in SharedPreferences (uncomment if needed)
      await UserPreferences().saveLocalUser(UserModel.fromJson(dataJson));

      // Return the UserModel instance
      return UserModel.fromJson(dataJson); // Use fromMap instead of fromJson
    } on DioException catch (e) {
      // Handle Dio errors
      throw _handleError(e);
    } catch (e) {
      // Catch other errors
      return Future.error('Something went wrong: $e');
    }
  }

  Future<UserModel> register(RegisterModel registerModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    try {
      final response = await _dio.post(
        '/auth/register',
        data: registerModel.toMap(),
      );
      final dataJson = response.data['data'];

      // Save the token using Tokenstore
      TokenStore.setToken(response.data['token']);

      // Save user in SharedPreferences (uncomment if needed)
      await UserPreferences().saveLocalUser(UserModel.fromJson(dataJson));

      // Return the UserModel instance
      return UserModel.fromJson(dataJson); // Use fromMap instead of fromJson
    } on DioException catch (e) {
      // Handle Dio errors
      throw _handleError(e);
    } catch (e) {
      // Catch other errors
      return Future.error('Something went wrong: $e');
    }
  }

  // Handle Dio errors
  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';
      case DioExceptionType.sendTimeout:
        return 'Send timeout';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';
      case DioExceptionType.badResponse:
        return 'Incorrect email or password';
      case DioExceptionType.cancel:
        return 'Request canceled';
      case DioExceptionType.unknown:
        return 'Unknown error: ${error.message}';
      default:
        return 'Something went wrong';
    }
  }
}
