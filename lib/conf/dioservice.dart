import 'package:dio/dio.dart';
import 'package:quickchance_app/conf/errorinterceptor.dart';
import 'package:quickchance_app/conf/headerInterceptor.dart';

class DioService {
  DioService._privateConstructor();
  static final DioService instance = DioService._privateConstructor();

  Dio dio = Dio();

  void setup() {
    dio.options.baseUrl = 'https://quickchance-backend.onrender.com';

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
