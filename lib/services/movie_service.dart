import 'package:get_it/get_it.dart';
import 'http_service.dart';

class MovieService {
  late HTTPService _http;

  MovieService() {
    _http = GetIt.instance<HTTPService>();
  }

  // Define methods to fetch movie data using _http.get()
}
