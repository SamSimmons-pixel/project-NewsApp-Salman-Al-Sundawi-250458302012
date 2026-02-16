import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static const String baseUrl = 'https://newsapi.org/v2/';

  static String get apiKey => dotenv.env['API_KEY'] ?? '';

  static const String topHeadlines = '/top-headlines';

  static const String everything = '/everything';

  static const List<String> categories = [
    'general',
    'business',
    'technology',
    'health',
    'science',
    'sports',
    'entertainment',
    'world',
  ];

  static const String defaultCountry = 'us';

  static const String appName = 'Zone News';

  static const String appVersion = '1.0.0';
}

final Map<String, String> categoryImages = {
  'general': 'assets/images/general.png',
  'business': 'assets/images/business.png',
  'technology': 'assets/images/technology.png',
  'health': 'assets/images/health.png',
  'science': 'assets/images/science.png',
  'sports': 'assets/images/sports.png',
  'entertainment': 'assets/images/entertainment.png',
  'world': 'assets/images/world.png',
};
