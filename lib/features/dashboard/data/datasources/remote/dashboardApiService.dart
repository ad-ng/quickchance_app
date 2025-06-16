import 'package:dio/dio.dart';
import 'package:quickchance_app/conf/dio/dioservice.dart';
import 'package:quickchance_app/features/auth/data/model/user_model.dart';
import 'package:quickchance_app/features/dashboard/data/models/addUserModel.dart';
import 'package:quickchance_app/features/home/data/models/opportunity_model.dart';

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

  Future addCategory(String catName) async {
    try {
      final response = await _dio.post('/category', data: {"name": catName});
      final dataJson = response.data;

      return dataJson;
    } on DioException catch (error) {
      throw error.message!;
    } catch (e) {
      return new Future.error('error: ${e.toString()}');
    }
  }

  Future updateCategory(String catName, int catId) async {
    try {
      final response = await _dio.patch(
        '/category/$catId',
        data: {"name": catName},
      );
      final dataJson = response.data;

      return dataJson;
    } on DioException catch (error) {
      throw error.message!;
    } catch (e) {
      return new Future.error('error: ${e.toString()}');
    }
  }

  Future deleteCategory(int catId) async {
    try {
      final response = await _dio.delete('/category/$catId');
      final dataJson = response.data;

      return dataJson;
    } on DioException catch (error) {
      throw error.message!;
    } catch (e) {
      return new Future.error('error: ${e.toString()}');
    }
  }

  Future addOpportunity(OpportunityModel opportunityModel) async {
    try {
      final response = await _dio.post(
        '/opportunity',
        data: opportunityModel.toMap(),
      );
      final dataJson = response.data;

      return dataJson;
    } on DioException catch (error) {
      throw error.message!;
    } catch (e) {
      return new Future.error('error: ${e.toString()}');
    }
  }

  Future updateOpportunity(OpportunityModel opportunityModel, int oppId) async {
    try {
      final response = await _dio.patch(
        '/opportunity/$oppId',
        data: opportunityModel.toMap(),
      );
      final dataJson = response.data;

      return dataJson;
    } on DioException catch (error) {
      print('error for updating opp: ${error.message}');
      print('error for updating opp: ${error.error.toString()}');
      throw error.message!;
    } catch (e) {
      return new Future.error('error: ${e.toString()}');
    }
  }

  Future deleteOpportunity(int oppId) async {
    try {
      final response = await _dio.delete('/opportunity/$oppId');
      final dataJson = response.data;

      return dataJson;
    } on DioException catch (error) {
      throw error.message!;
    } catch (e) {
      return new Future.error('error: ${e.toString()}');
    }
  }

  Future addUser(AddUserModel addUserModel) async {
    try {
      final response = await _dio.post(
        '/user/admin/add',
        data: addUserModel.toMap(),
      );
      final dataJson = response.data;

      return dataJson;
    } on DioException catch (error) {
      throw error.message!;
    } catch (e) {
      return new Future.error('error: ${e.toString()}');
    }
  }

  Future updateUser(AddUserModel addUserModel, int userId) async {
    try {
      final response = await _dio.patch(
        '/user/admin/$userId',
        data: addUserModel.toMap(),
      );
      final dataJson = response.data;

      return dataJson;
    } on DioException catch (error) {
      throw error.message!;
    } catch (e) {
      return new Future.error('error: ${e.toString()}');
    }
  }
}
