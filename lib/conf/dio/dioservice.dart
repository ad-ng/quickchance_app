import 'package:dio/dio.dart';
import 'package:quickchance_app/conf/appVariables.dart';
import 'package:quickchance_app/conf/dio/errorinterceptor.dart';
import 'package:quickchance_app/conf/dio/headerInterceptor.dart';

class DioService {
  DioService._privateConstructor();
  static final DioService instance = DioService._privateConstructor();

  Dio dio = Dio();

  void setup() {
    dio.options.baseUrl = Appvariables().homeUrl;

    dio.options.connectTimeout = Duration(seconds: 15);
    dio.options.receiveTimeout = Duration(seconds: 15);

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    dio.interceptors.add(ErrorInterceptor());
    dio.interceptors.add(HeaderInterceptor());
  }
}
