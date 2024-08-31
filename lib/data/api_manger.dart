import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
@singleton
class ApiManger {
  late Dio dio;

  ApiManger(){
    dio=Dio( BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Content-Type': 'application/json'},
      responseType: ResponseType.json,
      validateStatus: (status) => true,
    ),
    );
  }


  Future<Response> postData(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {


    var response=await dio.post("https://ecommerce.routemisr.com/api/v1/auth/signup",
        data: body, options: Options(headers: headers));

    return response;
  }
  static Future<Response> postData2(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    var dio = Dio();
    var response=await dio.post("https://ecommerce.routemisr.com/api/v1/auth/signup",
        data: body, options: Options(headers: headers));

    return response;
  }
}
