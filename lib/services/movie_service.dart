import 'package:get_it/get_it.dart';

//service
import '../services/http_service.dart';

class MovieService {
  final GetIt getit = GetIt.instance;

  late HTTPService _http;

  MovieService() {
    _http = getit.get<HTTPService>();
  }
}
