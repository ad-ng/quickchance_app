import 'package:dio/dio.dart';
import 'package:quickchance_app/conf/dio/dioservice.dart';
import 'package:quickchance_app/features/saved/data/models/saved_opp_model.dart';

class SavedApiService {
  final Dio _dio = DioService.instance.dio;

  Future<List<SavedOppModel>> fetchSavedOpps() async {
    try {
      final response = await _dio.get('/saved/me');

      final dataJson = response.data['data'];

      if (dataJson != null && dataJson is List) {
        return dataJson.map((json) => SavedOppModel.fromMap(json)).toList();
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

  Future<bool> checkIsSaved(int oppId) async {
    try {
      final response = await _dio.get('/saved/check/${oppId}');
      bool isSaved = response.data['data']['isSaved'];
      return isSaved;
    } on DioException catch (e) {
      throw e.message!;
    } catch (e) {
      return Future.error('something went wrong: $e');
    }
  }

  Future saveOpp(int oppId) async {
    try {
      final response = await _dio.post('/saved/$oppId');
      return response.data['data'];
    } on DioException catch (e) {
      throw e.message!;
    } catch (e) {
      return Future.error('something went wrong: $e');
    }
  }

  Future unSavingOpp(int oppId) async {
    try {
      final response = await _dio.delete('/saved/$oppId');
      return response.data['data'];
    } on DioException catch (e) {
      throw e.message!;
    } catch (e) {
      return Future.error('something went wrong: $e');
    }
  }
}
