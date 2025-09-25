import 'package:cinex_app/common/constants/load_env_data.dart';

class ApiConstants {
  ApiConstants._();

  static String apiKey = LoadEnvData.apiKey;
  static String baseUrl = LoadEnvData.baseUrl;
  static String imageBaseUrl = LoadEnvData.imageBaseUrl;
  static const String trendingMovies = "movie/top_rated";
  static const String upcomingMovies = "movie/upcoming";
  static const String popularMovies = "movie/popular";
  static String movieDetails(int movieId) => "movie/$movieId";
  static const String genres = "genre/movie/list";
  static String moviesByGenre(int genreId) =>
      "discover/movie?with_genres=$genreId";
}
