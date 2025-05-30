import 'package:dio/dio.dart';
import 'package:quickchance_app/conf/dio/dioservice.dart';
import 'package:quickchance_app/features/auth/data/model/user_model.dart';

class DashboardApiService {
  final Dio _dio = DioService.instance.dio;

  Future<List<UserModel>> fetchAllUser() async {
    try {
      final response = await _dio.get('/user/admin/getall');
      final dataJson = response.data['data'];

      if (dataJson != null && dataJson is List) {
        return dataJson.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception(
          'Expected a list of properties but got ${dataJson.runtimeType}',
        );
      }
    } on DioException catch (error) {
      throw error.message!;
    } catch (e) {
      return new Future.error('error: ${e.toString()}');
    }
  }
}
