import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoadEnvData {
  LoadEnvData._();

  static String apiKey = dotenv.env['API_KEY'] ?? '';
}
