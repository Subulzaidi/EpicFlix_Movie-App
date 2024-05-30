import 'package:get_it/get_it.dart';
//models
import '../models/app_config.dart';

class Movie {
  final String name;
  final String language;
  final bool isAdult;
  final String description;
  final num rating;
  final String posterPath;
  final String backdropPath;
  final String releasingDate;

  Movie({
    required this.name,
    required this.language,
    required this.isAdult,
    required this.description,
    required this.rating,
    required this.posterPath,
    required this.backdropPath,
    required this.releasingDate,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      name: map['title'],
      language: map['original_language'],
      isAdult: map['adult'],
      description: map['description'],
      posterPath: map['poster_path'],
      backdropPath: map['backdrop_path'],
      rating: map['vote_average'],
      releasingDate: map['release_date'],
    );
  }
  String posterURL() {
    final AppConfig appConfig = GetIt.instance.get<AppConfig>();
    return '${appConfig.BASE_IMAGE_API_URL}${this.posterPath}';
  }
}
