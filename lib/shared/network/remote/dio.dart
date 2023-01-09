import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

 static Future<Response> getData({
    required String url,
     dynamic query,
   String lang ='ar',
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
}
