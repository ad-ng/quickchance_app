import 'package:dio/dio.dart';
import 'package:quickchance_app/conf/dio/dioservice.dart';
import 'package:quickchance_app/features/notifications/data/models/userNotification.dart';

class NotificationApiService {
  final Dio _dio = DioService.instance.dio;

  Future<List<UserNotification>> fetchAllUserNotification() async {
    try {
      final response = await _dio.get('/notifications');

      final dataJson = response.data['data'];

      if (dataJson != null && dataJson is List) {
        return dataJson.map((json) => UserNotification.fromMap(json)).toList();
      } else {
        throw Exception(
          'Expected a list of properties but got ${dataJson.runtimeType}',
        );
      }
    } on DioException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return Future.error('something went wring: ${e.toString()}');
    }
  }
}
