import 'package:dio/dio.dart';
import 'package:quickchance_app/conf/dioservice.dart';
import 'package:quickchance_app/features/home/data/models/opportunity_model.dart';

class OpportunityApiService {
  final Dio _dio = DioService.instance.dio;

  Future<List<OpportunityModel>> fetchAllOpps() async {
    try {
      final response = await _dio.get('/opportunity');
      final dataJson = response.data['data'];

      if (dataJson != null && dataJson is List) {
        return dataJson.map((json) => OpportunityModel.fromJson(json)).toList();
      } else {
        throw Exception(
          'Expected a list of properties but got ${dataJson.runtimeType}',
        );
      }
    } on DioException catch (e) {
      // Handle Dio errors
      throw e.message!;
    } catch (e) {
      // Catch other errors
      return Future.error('Something went wrong: $e');
    }
  }
}
