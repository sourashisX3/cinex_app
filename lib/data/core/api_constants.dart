import 'package:cinex_app/common/constants/load_env_data.dart';

class ApiConstants {
  ApiConstants._();

  static String apiKey = LoadEnvData.apiKey;
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
}
