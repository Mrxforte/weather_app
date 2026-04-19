import 'package:weather_app/l10n/generated/app_localizations.dart';

// Resolves error type keys from WeatherProvider into localized strings
String localizedError(S l10n, String errorKey) {
  return switch (errorKey) {
    'network' => l10n.networkError,
    'timeout' => l10n.timeoutError,
    'server' => l10n.serverError,
    'apiKey' => l10n.apiKeyError,
    'notFound' => l10n.notFoundError,
    'rateLimit' => l10n.rateLimitError,
    _ => l10n.unknownError,
  };
}
