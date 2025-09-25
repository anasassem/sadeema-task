import 'package:dio/dio.dart';

class ApiService
{
final Dio _dio ;
final String baseUrl="https://taseese.org/api/";

  ApiService(this._dio);

 Future<Map<String ,dynamic>> get({required String endPoint})async{
    var response = await _dio.get(baseUrl+endPoint);
    return response.data;

  }

 Future<Map<String ,dynamic>> post ({required String endPoint, Map<String,dynamic> ?data})async{
    var response = await _dio.post(baseUrl+endPoint,data:data);
    return response.data;
  }
  Future<Map<String ,dynamic>> delete ({required String endPoint})async{
    var response = await _dio.delete(baseUrl+endPoint);
    return response.data;
  }
  Future<Map<String ,dynamic>> put ({required String endPoint})async{
    var response = await _dio.put(baseUrl+endPoint);
    return response.data;
  }
}