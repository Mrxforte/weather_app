// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class SRu extends S {
  SRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'WeatherNow';

  @override
  String get home => 'Главная';

  @override
  String get search => 'Поиск';

  @override
  String get searchCity => 'Поиск города';

  @override
  String get favorites => 'Избранное';

  @override
  String get settings => 'Настройки';

  @override
  String get about => 'О приложении';

  @override
  String get forecast => 'Прогноз на 3 дня';

  @override
  String get airQuality => 'Качество воздуха';

  @override
  String get weatherMap => 'Карта погоды';

  @override
  String get weatherDetails => 'Подробности погоды';

  @override
  String get details => 'Подробности';

  @override
  String get tryAgain => 'Попробовать снова';

  @override
  String updated(String time) {
    return 'Обновлено $time';
  }

  @override
  String get now => 'Сейчас';

  @override
  String get hourlyForecast => 'Почасовой прогноз';

  @override
  String get today => 'Сегодня';

  @override
  String get feelsLike => 'Ощущается как';

  @override
  String get humidity => 'Влажность';

  @override
  String get pressure => 'Давление';

  @override
  String get wind => 'Ветер';

  @override
  String get direction => 'Направление';

  @override
  String get visibility => 'Видимость';

  @override
  String get clouds => 'Облачность';

  @override
  String get gusts => 'Порывы';

  @override
  String get highLow => 'Макс / Мин';

  @override
  String get sunrise => 'Восход';

  @override
  String get sunset => 'Закат';

  @override
  String get pollutants => 'Загрязнители';

  @override
  String get healthAdvice => 'Советы по здоровью';

  @override
  String get noWeatherData => 'Данные о погоде недоступны';

  @override
  String get noFavorites => 'Нет избранных городов';

  @override
  String get noFavoritesHint => 'Найдите город и добавьте его в избранное';

  @override
  String get noResults => 'Ничего не найдено';

  @override
  String get searchHint => 'Введите название города...';

  @override
  String get minChars => 'Введите минимум 2 символа';

  @override
  String get temperatureUnit => 'Температура';

  @override
  String get fahrenheit => 'Фаренгейт (°F)';

  @override
  String get celsius => 'Цельсий (°C)';

  @override
  String get windSpeed => 'Скорость ветра';

  @override
  String get mph => 'Мили в час';

  @override
  String get kmh => 'Километры в час';

  @override
  String get theme => 'Тема';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get language => 'Язык';

  @override
  String get units => 'Единицы измерения';

  @override
  String get appearance => 'Внешний вид';

  @override
  String get more => 'Ещё';

  @override
  String savedCities(int count) {
    return '$count сохранено';
  }

  @override
  String get appInfo => 'Информация о приложении';

  @override
  String get security => 'Безопасность';

  @override
  String get appLock => 'Блокировка приложения';

  @override
  String get appLockHint => 'Защитите приложение графическим ключом';

  @override
  String get patternSet => 'Графический ключ включён';

  @override
  String get patternNotSet => 'Графический ключ отключён';

  @override
  String get setPattern => 'Нарисуйте графический ключ';

  @override
  String get confirmPattern => 'Подтвердите графический ключ';

  @override
  String get unlockApp => 'Нарисуйте ключ для разблокировки';

  @override
  String get patternSaved => 'Графический ключ включён';

  @override
  String get patternRemoved => 'Графический ключ отключён';

  @override
  String get patternMismatch => 'Ключи не совпадают, попробуйте снова';

  @override
  String get notifications => 'Уведомления';

  @override
  String get dailyNotification => 'Ежедневная сводка погоды';

  @override
  String get dailyNotificationHint =>
      'Получайте уведомление о погоде каждый день в 8:00';

  @override
  String get notificationEnabled => 'Ежедневные уведомления включены';

  @override
  String get notificationDisabled => 'Ежедневные уведомления отключены';

  @override
  String get networkError =>
      'Нет подключения к интернету. Проверьте сеть и попробуйте снова.';

  @override
  String get serverError => 'Ошибка сервера. Попробуйте позже.';

  @override
  String get timeoutError => 'Время ожидания истекло. Попробуйте снова.';

  @override
  String get unknownError => 'Что-то пошло не так. Попробуйте снова.';

  @override
  String get rateLimitError => 'Слишком много запросов. Подождите немного.';

  @override
  String get apiKeyError => 'Неверный API-ключ. Проверьте конфигурацию.';

  @override
  String get notFoundError => 'Город не найден. Попробуйте другой запрос.';

  @override
  String get good => 'Хорошее';

  @override
  String get fair => 'Нормальное';

  @override
  String get moderate => 'Умеренное';

  @override
  String get poor => 'Плохое';

  @override
  String get veryPoor => 'Очень плохое';

  @override
  String get unknown => 'Неизвестно';

  @override
  String get uvLow => 'Низкий';

  @override
  String get uvModerate => 'Умеренный';

  @override
  String get uvHigh => 'Высокий';

  @override
  String get uvVeryHigh => 'Очень высокий';

  @override
  String get uvExtreme => 'Экстремальный';

  @override
  String get onboardingTitle1 => 'Погода в реальном времени';

  @override
  String get onboardingDesc1 =>
      'Получайте точные обновления погоды для любого города мира в реальном времени.';

  @override
  String get onboardingTitle2 => 'Прогноз на 3 дня';

  @override
  String get onboardingDesc2 =>
      'Планируйте наперёд с подробными почасовыми и ежедневными прогнозами до 3 дней.';

  @override
  String get onboardingTitle3 => 'Сохраняйте города';

  @override
  String get onboardingDesc3 =>
      'Добавляйте любимые города для быстрого доступа к их погоде.';

  @override
  String get skip => 'Пропустить';

  @override
  String get next => 'Далее';

  @override
  String get getStarted => 'Начать';

  @override
  String get aboutDesc =>
      'WeatherNow предоставляет данные о погоде в реальном времени со всего мира. Текущие условия, прогнозы на 3 дня, индексы качества воздуха и многое другое — в красивом и удобном интерфейсе.';

  @override
  String get dataSource => 'Источник данных';

  @override
  String get dataSourceDesc =>
      'Данные о погоде предоставлены WeatherAPI.com (бесплатный тариф). Включает текущие условия, почасовые прогнозы на 3 дня, данные о качестве воздуха и поиск городов.';

  @override
  String get builtWith => 'Создано с помощью';

  @override
  String get privacy => 'Конфиденциальность';

  @override
  String get privacyDesc =>
      'Это приложение не собирает и не хранит персональные данные. Местоположение используется только для получения данных о погоде и никогда не передаётся третьим лицам.';

  @override
  String get madeWith => 'Сделано с ❤️ на Flutter';

  @override
  String version(String v) {
    return 'Версия $v';
  }

  @override
  String get aqiGoodAdvice =>
      'Качество воздуха удовлетворительное. Наслаждайтесь прогулками!';

  @override
  String get aqiFairAdvice =>
      'Качество воздуха приемлемое. Чувствительным людям стоит ограничить длительные прогулки.';

  @override
  String get aqiModerateAdvice =>
      'Чувствительные группы могут ощутить последствия. Рассмотрите снижение активности на улице.';

  @override
  String get aqiPoorAdvice =>
      'Все могут ощутить последствия. Ограничьте активность на улице.';

  @override
  String get aqiVeryPoorAdvice =>
      'Внимание! Всем следует избегать активности на улице.';

  @override
  String get layers => 'Слои';

  @override
  String get precipitation => 'Осадки';

  @override
  String get temperature => 'Температура';

  @override
  String get windLayer => 'Ветер';

  @override
  String get pressureLayer => 'Давление';

  @override
  String get location => 'Местоположение';

  @override
  String get coordinates => 'Координаты';
}
