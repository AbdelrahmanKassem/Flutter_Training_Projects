import 'package:dio/dio.dart';

class DioHelper
{
  static Dio? dio;

  //News App
/* static void init ()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({required String url , required Map<String,dynamic>? query,}) async
  {
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }*/

  //Shop App
  static void init ()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url ,
    Map<String,dynamic>? query,
    String lang = 'en',
    String? token,
  }) async
  {
    dio!.options.headers = {
      'lang' : lang ,
      'Authorization' : token??'',
      'Content-Type' : 'application/json',
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String,dynamic> data,
    Map<String,dynamic>? query,
    String lang = 'en',
    String? authorization,
  }) async
  {
    dio!.options.headers = {
      'lang' : lang ,
      'Authorization' : authorization,
      'Content-Type' : 'application/json',
    };

    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String,dynamic> data,
    Map<String,dynamic>? query,
    String lang = 'en',
    String? authorization,
  }) async
  {
    dio!.options.headers = {
      'lang' : lang ,
      'Authorization' : authorization,
      'Content-Type' : 'application/json',
    };

    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}