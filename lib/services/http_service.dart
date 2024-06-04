import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../models/app_config.dart';

class HTTPService {
  final Dio dio = Dio();
  late String _baseUrl;
  late String _apiKey;

  HTTPService() {
    final AppConfig config = GetIt.instance<AppConfig>();
    _baseUrl = config.BASE_API_URL;
    _apiKey = config.API_KEY;
  }

  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    try {
      String url = '$_baseUrl$path';
      Map<String, dynamic> _query = {
        'api_key': _apiKey,
        'language': 'en-US',
      };
      if (query != null) {
        _query.addAll(query);
      }
      return await dio.get(url, queryParameters: _query);
    } on DioError catch (e) {
      print("Unable to perform get request");
      print("DioError: $e");
      throw e;
    }
  }
}
