// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class SUz extends S {
  SUz([String locale = 'uz']) : super(locale);

  @override
  String get appName => 'WeatherNow';

  @override
  String get home => 'Bosh sahifa';

  @override
  String get search => 'Qidirish';

  @override
  String get searchCity => 'Shahar qidirish';

  @override
  String get favorites => 'Sevimlilar';

  @override
  String get settings => 'Sozlamalar';

  @override
  String get about => 'Ilova haqida';

  @override
  String get forecast => '3 kunlik prognoz';

  @override
  String get airQuality => 'Havo sifati';

  @override
  String get weatherMap => 'Ob-havo xaritasi';

  @override
  String get weatherDetails => 'Ob-havo tafsilotlari';

  @override
  String get details => 'Tafsilotlar';

  @override
  String get tryAgain => 'Qayta urinish';

  @override
  String updated(String time) {
    return 'Yangilangan $time';
  }

  @override
  String get now => 'Hozir';

  @override
  String get hourlyForecast => 'Soatlik prognoz';

  @override
  String get today => 'Bugun';

  @override
  String get feelsLike => 'His qilinadi';

  @override
  String get humidity => 'Namlik';

  @override
  String get pressure => 'Bosim';

  @override
  String get wind => 'Shamol';

  @override
  String get direction => 'Yo\'nalish';

  @override
  String get visibility => 'Ko\'rinish';

  @override
  String get clouds => 'Bulutlilik';

  @override
  String get gusts => 'Shamol kuchi';

  @override
  String get highLow => 'Yuqori / Past';

  @override
  String get sunrise => 'Quyosh chiqishi';

  @override
  String get sunset => 'Quyosh botishi';

  @override
  String get pollutants => 'Ifloslantirishlar';

  @override
  String get healthAdvice => 'Sog\'liq maslahati';

  @override
  String get noWeatherData => 'Ob-havo ma\'lumotlari mavjud emas';

  @override
  String get noFavorites => 'Sevimli shaharlar yo\'q';

  @override
  String get noFavoritesHint =>
      'Shahar qidiring va sevimlilaringizga qo\'shing';

  @override
  String get noResults => 'Natijalar topilmadi';

  @override
  String get searchHint => 'Shahar nomini kiriting...';

  @override
  String get minChars => 'Kamida 2 belgi kiriting';

  @override
  String get temperatureUnit => 'Harorat';

  @override
  String get fahrenheit => 'Farengeyt (°F)';

  @override
  String get celsius => 'Selsiy (°C)';

  @override
  String get windSpeed => 'Shamol tezligi';

  @override
  String get mph => 'Mil/soat';

  @override
  String get kmh => 'Km/soat';

  @override
  String get theme => 'Mavzu';

  @override
  String get themeSystem => 'Tizim bo\'yicha';

  @override
  String get themeLight => 'Yorug\'';

  @override
  String get themeDark => 'Qorong\'u';

  @override
  String get language => 'Til';

  @override
  String get units => 'O\'lchov birliklari';

  @override
  String get appearance => 'Ko\'rinish';

  @override
  String get more => 'Boshqalar';

  @override
  String savedCities(int count) {
    return '$count ta saqlangan';
  }

  @override
  String get appInfo => 'Ilova ma\'lumotlari';

  @override
  String get security => 'Xavfsizlik';

  @override
  String get appLock => 'Ilova qulfi';

  @override
  String get appLockHint => 'Ilovani grafik kalit bilan himoyalang';

  @override
  String get patternSet => 'Grafik qulf yoqilgan';

  @override
  String get patternNotSet => 'Grafik qulf o\'chirilgan';

  @override
  String get setPattern => 'Grafik kalitni chizing';

  @override
  String get confirmPattern => 'Grafik kalitni tasdiqlang';

  @override
  String get unlockApp => 'Qulfni ochish uchun chizing';

  @override
  String get patternSaved => 'Grafik qulf yoqildi';

  @override
  String get patternRemoved => 'Grafik qulf o\'chirildi';

  @override
  String get patternMismatch => 'Kalitlar mos kelmadi, qayta urinib ko\'ring';

  @override
  String get notifications => 'Bildirishnomalar';

  @override
  String get dailyNotification => 'Kundalik ob-havo yangiligi';

  @override
  String get dailyNotificationHint =>
      'Har kuni soat 8:00 da ob-havo bildirishnomasini oling';

  @override
  String get notificationEnabled => 'Kundalik bildirishnomalar yoqildi';

  @override
  String get notificationDisabled => 'Kundalik bildirishnomalar o\'chirildi';

  @override
  String get networkError =>
      'Internetga ulanish yo\'q. Tarmoqni tekshiring va qayta urinib ko\'ring.';

  @override
  String get serverError => 'Server xatosi. Keyinroq urinib ko\'ring.';

  @override
  String get timeoutError => 'Ulanish vaqti tugadi. Qayta urinib ko\'ring.';

  @override
  String get unknownError => 'Nimadir xato ketdi. Qayta urinib ko\'ring.';

  @override
  String get rateLimitError => 'Juda ko\'p so\'rov. Biroz kuting.';

  @override
  String get apiKeyError => 'Noto\'g\'ri API kaliti. Sozlamalarni tekshiring.';

  @override
  String get notFoundError =>
      'Shahar topilmadi. Boshqa qidiruvni sinab ko\'ring.';

  @override
  String get good => 'Yaxshi';

  @override
  String get fair => 'O\'rtacha';

  @override
  String get moderate => 'Mo\'\'tadil';

  @override
  String get poor => 'Yomon';

  @override
  String get veryPoor => 'Juda yomon';

  @override
  String get unknown => 'Noma\'lum';

  @override
  String get uvLow => 'Past';

  @override
  String get uvModerate => 'O\'rtacha';

  @override
  String get uvHigh => 'Yuqori';

  @override
  String get uvVeryHigh => 'Juda yuqori';

  @override
  String get uvExtreme => 'Ekstremal';

  @override
  String get onboardingTitle1 => 'Real vaqt ob-havosi';

  @override
  String get onboardingDesc1 =>
      'Dunyoning istalgan shahri uchun aniq ob-havo yangilanishlarini real vaqtda oling.';

  @override
  String get onboardingTitle2 => '3 kunlik prognoz';

  @override
  String get onboardingDesc2 =>
      '3 kungacha bo\'lgan batafsil soatlik va kunlik prognozlar bilan rejalashtiring.';

  @override
  String get onboardingTitle3 => 'Shaharlarni saqlang';

  @override
  String get onboardingDesc3 =>
      'Sevimli shaharlarni qo\'shing va ularga tezkor kirish imkoniga ega bo\'ling.';

  @override
  String get skip => 'O\'tkazib yuborish';

  @override
  String get next => 'Keyingi';

  @override
  String get getStarted => 'Boshlash';

  @override
  String get aboutDesc =>
      'WeatherNow butun dunyo bo\'ylab real vaqt ob-havo ma\'lumotlarini taqdim etadi. Joriy sharoitlar, 3 kunlik prognozlar, havo sifati indekslari va boshqalar — chiroyli va qulay interfeysda.';

  @override
  String get dataSource => 'Ma\'lumot manbasi';

  @override
  String get dataSourceDesc =>
      'Ob-havo ma\'lumotlari WeatherAPI.com (bepul tarif) tomonidan taqdim etilgan. Joriy sharoitlar, 3 kunlik soatlik prognozlar, havo sifati ma\'lumotlari va shahar qidiruvini o\'z ichiga oladi.';

  @override
  String get builtWith => 'Yaratilgan';

  @override
  String get privacy => 'Maxfiylik';

  @override
  String get privacyDesc =>
      'Bu ilova hech qanday shaxsiy ma\'lumotlarni to\'plamaydi yoki saqlamaydi. Joylashuv faqat ob-havo ma\'lumotlarini olish uchun ishlatiladi va uchinchi tomonlarga hech qachon uzatilmaydi.';

  @override
  String get madeWith => 'Flutter bilan ❤️ yaratilgan';

  @override
  String version(String v) {
    return 'Versiya $v';
  }

  @override
  String get aqiGoodAdvice => 'Havo sifati qoniqarli. Ochiq havoda dam oling!';

  @override
  String get aqiFairAdvice =>
      'Havo sifati maqbul. Sezgir odamlar uzoq muddatli ochiq havo faoliyatini cheklashi kerak.';

  @override
  String get aqiModerateAdvice =>
      'Sezgir guruhlar sog\'liqqa ta\'sirni sezishi mumkin. Ochiq havoda faoliyatni kamaytirishni ko\'rib chiqing.';

  @override
  String get aqiPoorAdvice =>
      'Hamma sog\'liqqa ta\'sirni seza boshlashi mumkin. Ochiq havoda faoliyatni cheklang.';

  @override
  String get aqiVeryPoorAdvice =>
      'Sog\'liq ogohlantiruvi! Hamma ochiq havoda faoliyatdan qochishi kerak.';

  @override
  String get layers => 'Qatlamlar';

  @override
  String get precipitation => 'Yog\'ingarchilik';

  @override
  String get temperature => 'Harorat';

  @override
  String get windLayer => 'Shamol';

  @override
  String get pressureLayer => 'Bosim';

  @override
  String get location => 'Joylashuv';

  @override
  String get coordinates => 'Koordinatalar';
}
