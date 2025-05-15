import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      throw e.message!;
    } catch (e) {
      // Catch other errors
      return Future.error('Something went wrong: $e');
    }
  }

  Future signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email', 'profile'],
      clientId:
          '1006205845168-365pel72t3stj8krg21fr23k7leo3jb7.apps.googleusercontent.com',
    );
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      print('User canceled sign-in');
      return;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    print('User ID: ${googleUser.id}');
    print('ID Token: ${googleAuth.idToken}');
    print('Access Token: ${googleAuth.accessToken}');

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      final response = await _dio.post(
        '/auth/google',
        data: {
          "username": googleUser.displayName,
          "email": googleUser.email,
          "profileImg": googleUser.photoUrl,
          "password": googleUser.id,
        },
      );
      final dataJson = response.data['data'];

      // Save the token using Tokenstore
      TokenStore.setToken(response.data['token']);

      // Save user in SharedPreferences (uncomment if needed)
      await UserPreferences().saveLocalUser(UserModel.fromJson(dataJson));

      // Return the UserModel instance
      return UserModel.fromJson(dataJson);
    } on DioException catch (e) {
      // Handle Dio errors
      throw e.message!;
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
