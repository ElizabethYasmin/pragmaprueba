import 'package:dio/dio.dart';

class ApiClient {
  static const _baseUrl = 'https://api.thecatapi.com/v1';
  static const _apiKey = 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr';

  final Dio _dio = Dio();

  ApiClient() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers = {
      'x-api-key': _apiKey,
    };
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    return await _dio.get(path, queryParameters: queryParams);
  }
}
