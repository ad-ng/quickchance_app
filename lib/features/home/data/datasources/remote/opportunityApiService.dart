import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/conf/dio/dioservice.dart';
import 'package:quickchance_app/features/home/data/models/commentModel.dart';
import 'package:quickchance_app/features/home/data/models/opportunity_model.dart';
import 'package:quickchance_app/features/home/presentation/bloc/commentCubit.dart';

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

  Future likingOpp(int oppId) async {
    try {
      final response = await _dio.post('/like/add/$oppId');
      return response.data['data'];
    } on DioException catch (e) {
      throw e.message!;
    } catch (e) {
      return Future.error('something went wrong: $e');
    }
  }

  Future unLikingOpp(int oppId) async {
    try {
      final response = await _dio.delete('/like/delete/$oppId');
      return response.data['data'];
    } on DioException catch (e) {
      throw e.message!;
    } catch (e) {
      return Future.error('something went wrong: $e');
    }
  }

  Future<int> totalComments(int oppId) async {
    try {
      final response = await _dio.get('/comment/count/$oppId');
      final int dataJson = response.data['data']['count'];
      return dataJson;
    } on DioException catch (e) {
      throw e.message!;
    } catch (e) {
      return Future.error('Something went wrong: $e');
    }
  }

  Future<List<CommentModel>> fetchAllComments(
    int oppId,
    BuildContext context,
  ) async {
    try {
      final response = await _dio.get('/comment/$oppId');
      final dataJson = response.data['data'];

      if (dataJson != null && dataJson is List) {
        BlocProvider.of<CommentCubit>(context).fetchAllComments(oppId, context);
        return dataJson.map((json) => CommentModel.fromMap(json)).toList();
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

  Future postComment(CommentModel commentModel) async {
    try {
      final response = await _dio.post('/comment', data: commentModel.toMap());
      final dataJson = response.data['data'];

      return dataJson;
    } on DioException catch (e) {
      // Handle Dio errors
      throw e.message!;
    } catch (e) {
      // Catch other errors
      return Future.error('Something went wrong: $e');
    }
  }
}
