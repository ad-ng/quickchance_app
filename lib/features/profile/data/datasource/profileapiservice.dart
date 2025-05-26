import 'package:dio/dio.dart';
import 'package:quickchance_app/conf/dio/dioservice.dart';
import 'package:quickchance_app/features/auth/data/datasource/local/userpreferences.dart';
import 'package:quickchance_app/features/auth/data/model/user_model.dart';
import 'package:quickchance_app/features/profile/data/model/updateUserModel.dart';

class ProfileApiService {
  final Dio _dio = DioService.instance.dio;

  Future<UserModel> updateUser(UpdateUserModel updateUserModel) async {
    try {
      final response = await _dio.put(
        '/user/update',
        data: updateUserModel.toMap(),
      );
      final dataJson = response.data['date'];

      await UserPreferences().removeLocalUser();

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
}
