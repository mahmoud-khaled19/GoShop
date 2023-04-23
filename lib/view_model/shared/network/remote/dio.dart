import 'package:dio/dio.dart';
import 'package:shop_app/app_constance/api_constance.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstance.basicUrl,
      receiveDataWhenStatusError: true,
    ));
  }

 static Future<Response> getData({
    required String url,
     dynamic query,
   String lang ='en',
   String? token,
  }) async {
   dio.options.headers={
     'lang':lang,
     'Authorization':token??'',
     'content-type':'application/json'
   };
    return await dio.get(url, queryParameters: query);
  }
 static Future<Response> postData({
    required String url,
    dynamic query,
    required Map<String,dynamic> data,
   String lang ='ar',
   String? token,

  }) async {
   dio.options.headers={
     'lang':lang,
     'Authorization':token??'',
     'content-type':'application/json'
   };
    return await dio.post(url, queryParameters: query,data:data );
  }
  static Future<Response> putData({
    required String url,
    dynamic query,
    required Map<String,dynamic> data,
    String lang ='ar',
    String? token,
  }) async {
    dio.options.headers={
      'lang':lang,
      'Authorization':token??'',
      'content-type':'application/json'
    };
    return await dio.put(url, queryParameters: query,data:data );
  }
}
