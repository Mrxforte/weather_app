// WeatherAPI.com configuration
class ApiConstants {
  ApiConstants._();

  static const String apiKey = '0e7111dd42094d9ea7c215215231601';
  static const String baseUrl = 'https://api.weatherapi.com/v1';

  // Endpoints
  static const String forecast = '/forecast.json';
  static const String search = '/search.json';

  // Build full icon URL from the partial path the API returns
  static String weatherIconUrl(String rawIcon) =>
      rawIcon.startsWith('http') ? rawIcon : 'https:$rawIcon';
}
