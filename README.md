# WeatherNow �️

A beautiful, feature-rich weather application built with Flutter. Get real-time weather data, 3-day forecasts, air quality information, and more — all in a stunning glassmorphism UI with multi-language support.

---

## Screenshots

| Splash | Onboarding | Home |
|--------|------------|------|
| Animated brand intro | 3-page feature walkthrough | Full weather dashboard |

| Search | Forecast | Air Quality |
|--------|----------|-------------|
| City search with live results | 3-day detailed breakdown | AQI + pollutant details |

| Settings | Favorites | Lock Screen |
|----------|-----------|-------------|
| Units, theme, language, security | Saved cities quick access | Pattern lock protection |

---

## Features

- **Real-Time Weather** — Current conditions with temperature, humidity, wind, pressure, and visibility
- **3-Day Forecast** — Hourly and daily forecasts with high/low temperatures and precipitation chances
- **Air Quality Index** — AQI levels, pollutant breakdown, and health advice
- **Weather Map** — Interactive map layers for precipitation, temperature, clouds, wind, and pressure
- **Favorite Cities** — Save and quickly switch between multiple locations
- **City Search** — Search any city worldwide with autocomplete suggestions
- **Localization** — Full support for 7 languages: English, Russian, Uzbek, Arabic, French, German, Spanish
- **Dark & Light Theme** — System-aware theming with manual override
- **Daily Notifications** — Scheduled push notifications with current weather summary
- **Pattern Lock** — Protect the app with a graphical pattern lock screen
- **Onboarding** — Guided introduction for first-time users
- **Portrait-Only** — Optimized for portrait orientation
- **High Refresh Rate** — Automatically uses the highest display refresh rate available
- **Error Handling** — Localized, user-friendly error messages with retry actions
- **Dynamic Backgrounds** — Gradient changes based on weather conditions and time of day
- **Shimmer Loading** — Polished skeleton screens while data loads
- **Smooth Animations** — Page transitions, staggered list animations, scale/fade effects
- **Pull to Refresh** — Swipe down to reload weather data

---

## Architecture

The app follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                    # Shared app infrastructure
│   ├── constants/           # API keys, app-wide constants
│   ├── di/                  # GetIt service locator setup
│   ├── router/              # GoRouter navigation config
│   ├── services/            # Notification service
│   ├── theme/               # Colors, text styles, ThemeData
│   └── utils/               # Weather, date, error utilities
├── data/                    # Data layer
│   ├── datasources/         # API service (Dio HTTP client)
│   ├── models/              # JSON parsing models
│   └── repositories/        # Repository implementations
├── domain/                  # Business logic layer
│   ├── entities/            # Pure data classes
│   └── repositories/        # Repository contracts
├── l10n/                    # ARB localization files (7 languages)
└── presentation/            # UI layer
    ├── providers/           # ChangeNotifier state management
    ├── screens/             # All app screens
    │   ├── splash/
    │   ├── onboarding/
    │   ├── home/
    │   │   └── widgets/     # Hourly & daily forecast components
    │   ├── search/
    │   ├── weather_detail/
    │   ├── forecast/
    │   ├── air_quality/
    │   ├── weather_map/
    │   ├── favorites/
    │   ├── settings/
    │   ├── lock/            # Pattern lock screens
    │   └── about/
    └── widgets/             # Shared reusable widgets
```

---

## Screens

| # | Screen | Description |
|---|--------|-------------|
| 1 | **Splash** | Animated brand intro with auto-navigation |
| 2 | **Onboarding** | 3-page swipeable feature introduction |
| 3 | **Home** | Main dashboard with current weather, hourly/daily forecast, AQI |
| 4 | **Search** | City search with live API results |
| 5 | **Weather Detail** | Full breakdown of all weather metrics |
| 6 | **Forecast** | 3-day forecast with hourly slots per day |
| 7 | **Air Quality** | AQI gauge, pollutant bars, health recommendations |
| 8 | **Weather Map** | Layer-selectable weather map view |
| 9 | **Favorites** | Saved cities list with swipe-to-delete |
| 10 | **Settings** | Units, theme, language, notifications, security |
| 11 | **About** | App info, data attribution, privacy note |
| 12 | **Lock Screen** | Pattern lock verification on app launch |

---

## Localization

Supported languages:

| Code | Language |
|------|----------|
| `en` | English |
| `ru` | Русский |
| `uz` | O'zbek |
| `ar` | العربية |
| `fr` | Français |
| `de` | Deutsch |
| `es` | Español |

To add a new language, create `lib/l10n/app_<code>.arb` with translations and add the locale to `AppConstants.supportedLocales`.

---

## Tech Stack

| Category | Package |
|----------|---------|
| State Management | `provider` |
| Dependency Injection | `get_it` |
| Navigation | `go_router` |
| HTTP Client | `dio` |
| Local Storage | `shared_preferences` |
| Animations | `flutter_animate`, `shimmer` |
| Charts | `fl_chart` |
| Typography | `google_fonts` (Inter) |
| Localization | `flutter_localizations` + ARB |
| Notifications | `flutter_local_notifications` + `workmanager` |
| Security | `flutter_screen_lock` |
| Performance | `flutter_displaymode` |
| Connectivity | `connectivity_plus` |

---

## Getting Started

### Prerequisites

- Flutter SDK >= 3.38
- Dart SDK >= 3.10
- A [WeatherAPI.com](https://www.weatherapi.com/) API key (free tier works)

### Setup

1. **Clone the repository**
   ```bash
   git clone <repo-url>
   cd weather_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

The API key is configured in `lib/core/constants/app_constants.dart`. Replace with your own key for production use.

---

## Testing

```bash
flutter test
```

---

## Key Design Decisions

- **Glassmorphism cards** — Semi-transparent containers with blur effects for a modern look
- **Dynamic weather gradients** — Background colors shift based on conditions (sunny, rainy, night, etc.)
- **Staggered animations** — List items and cards animate in sequence for a polished feel
- **Shimmer placeholders** — Loading skeletons instead of spinners for better perceived performance
- **Error type keys** — Weather provider returns error keys resolved to localized strings at display time
- **Pattern lock** — Optional app security using `flutter_screen_lock`

---

## License

This project is for educational and personal use. Weather data provided by [WeatherAPI.com](https://www.weatherapi.com/).
