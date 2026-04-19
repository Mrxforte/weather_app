// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class SAr extends S {
  SAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'WeatherNow';

  @override
  String get home => 'الرئيسية';

  @override
  String get search => 'بحث';

  @override
  String get searchCity => 'البحث عن مدينة';

  @override
  String get favorites => 'المفضلة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get about => 'حول التطبيق';

  @override
  String get forecast => 'توقعات الأسبوع';

  @override
  String get share => 'مشاركة';

  @override
  String get airQuality => 'جودة الهواء';

  @override
  String get weatherMap => 'خريطة الطقس';

  @override
  String get weatherDetails => 'تفاصيل الطقس';

  @override
  String get details => 'التفاصيل';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String updated(String time) {
    return 'تم التحديث $time';
  }

  @override
  String get now => 'الآن';

  @override
  String get hourlyForecast => 'التوقعات بالساعة';

  @override
  String get today => 'اليوم';

  @override
  String get feelsLike => 'يشعر وكأنه';

  @override
  String get humidity => 'الرطوبة';

  @override
  String get pressure => 'الضغط';

  @override
  String get wind => 'الرياح';

  @override
  String get direction => 'الاتجاه';

  @override
  String get visibility => 'الرؤية';

  @override
  String get clouds => 'الغيوم';

  @override
  String get gusts => 'هبات الرياح';

  @override
  String get highLow => 'أعلى / أدنى';

  @override
  String get sunrise => 'شروق الشمس';

  @override
  String get sunset => 'غروب الشمس';

  @override
  String get pollutants => 'الملوثات';

  @override
  String get healthAdvice => 'نصائح صحية';

  @override
  String get noWeatherData => 'لا تتوفر بيانات الطقس';

  @override
  String get noFavorites => 'لا توجد مدن مفضلة بعد';

  @override
  String get noFavoritesHint => 'ابحث عن مدينة وأضفها إلى المفضلة';

  @override
  String get noResults => 'لم يتم العثور على نتائج';

  @override
  String get searchHint => 'أدخل اسم المدينة...';

  @override
  String get minChars => 'أدخل حرفين على الأقل';

  @override
  String get temperatureUnit => 'الحرارة';

  @override
  String get fahrenheit => 'فهرنهايت (°F)';

  @override
  String get celsius => 'مئوية (°C)';

  @override
  String get windSpeed => 'سرعة الرياح';

  @override
  String get mph => 'ميل في الساعة';

  @override
  String get kmh => 'كيلومتر في الساعة';

  @override
  String get theme => 'المظهر';

  @override
  String get themeSystem => 'افتراضي النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get language => 'اللغة';

  @override
  String get units => 'الوحدات';

  @override
  String get appearance => 'المظهر';

  @override
  String get more => 'المزيد';

  @override
  String savedCities(int count) {
    return '$count محفوظة';
  }

  @override
  String get appInfo => 'معلومات التطبيق';

  @override
  String get security => 'الأمان';

  @override
  String get appLock => 'قفل التطبيق';

  @override
  String get appLockHint => 'حماية التطبيق بنمط قفل';

  @override
  String get patternSet => 'قفل النمط مفعّل';

  @override
  String get patternNotSet => 'قفل النمط معطّل';

  @override
  String get setPattern => 'ارسم نمط القفل';

  @override
  String get confirmPattern => 'تأكيد نمط القفل';

  @override
  String get unlockApp => 'ارسم النمط لفتح القفل';

  @override
  String get patternSaved => 'تم تفعيل قفل النمط';

  @override
  String get patternRemoved => 'تم تعطيل قفل النمط';

  @override
  String get patternMismatch => 'الأنماط غير متطابقة، حاول مرة أخرى';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get dailyNotification => 'تحديث الطقس اليومي';

  @override
  String get dailyNotificationHint =>
      'احصل على إشعار الطقس يومياً الساعة 8:00 صباحاً';

  @override
  String get notificationEnabled => 'تم تفعيل الإشعارات اليومية';

  @override
  String get notificationDisabled => 'تم تعطيل الإشعارات اليومية';

  @override
  String get networkError =>
      'لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة والمحاولة مرة أخرى.';

  @override
  String get serverError => 'خطأ في الخادم. يرجى المحاولة لاحقاً.';

  @override
  String get timeoutError => 'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى.';

  @override
  String get unknownError => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';

  @override
  String get rateLimitError => 'طلبات كثيرة جداً. يرجى الانتظار لحظة.';

  @override
  String get apiKeyError => 'مفتاح API غير صالح. يرجى التحقق من الإعدادات.';

  @override
  String get notFoundError => 'المدينة غير موجودة. جرّب بحثاً مختلفاً.';

  @override
  String get good => 'جيد';

  @override
  String get fair => 'مقبول';

  @override
  String get moderate => 'معتدل';

  @override
  String get poor => 'سيئ';

  @override
  String get veryPoor => 'سيئ جداً';

  @override
  String get unknown => 'غير معروف';

  @override
  String get uvLow => 'منخفض';

  @override
  String get uvModerate => 'معتدل';

  @override
  String get uvHigh => 'مرتفع';

  @override
  String get uvVeryHigh => 'مرتفع جداً';

  @override
  String get uvExtreme => 'شديد';

  @override
  String get onboardingTitle1 => 'طقس لحظي';

  @override
  String get onboardingDesc1 =>
      'احصل على تحديثات طقس دقيقة لأي مدينة في العالم في الوقت الفعلي.';

  @override
  String get onboardingTitle2 => 'توقعات أسبوعية';

  @override
  String get onboardingDesc2 =>
      'خطط مسبقاً مع توقعات ساعية ويومية مفصلة لمدة تصل إلى 7 أيام.';

  @override
  String get onboardingTitle3 => 'احفظ مدنك';

  @override
  String get onboardingDesc3 =>
      'أضف مدنك المفضلة للوصول السريع إلى طقسها في أي وقت.';

  @override
  String get skip => 'تخطي';

  @override
  String get next => 'التالي';

  @override
  String get getStarted => 'ابدأ';

  @override
  String get aboutDesc =>
      'WeatherNow يقدم لك بيانات الطقس لحظياً من جميع أنحاء العالم. تحقق من الأحوال الحالية، توقعات 7 أيام، مؤشرات جودة الهواء، والمزيد — في واجهة جميلة وسهلة الاستخدام.';

  @override
  String get dataSource => 'مصدر البيانات';

  @override
  String get dataSourceDesc =>
      'بيانات الطقس مقدمة من WeatherAPI.com (الطبقة المجانية). يشمل الأحوال الحالية، توقعات ساعية لمدة 7 أيام، بيانات جودة الهواء، والبحث عن المدن.';

  @override
  String get builtWith => 'بُني باستخدام';

  @override
  String get privacy => 'الخصوصية';

  @override
  String get privacyDesc =>
      'هذا التطبيق لا يجمع أو يخزن أي بيانات شخصية. يُستخدم الموقع فقط لجلب بيانات الطقس ولا يُشارك أبداً مع أطراف ثالثة.';

  @override
  String get madeWith => 'صُنع بـ ❤️ باستخدام Flutter';

  @override
  String version(String v) {
    return 'الإصدار $v';
  }

  @override
  String get aqiGoodAdvice => 'جودة الهواء مُرضية. استمتع بأنشطتك الخارجية!';

  @override
  String get aqiFairAdvice =>
      'جودة الهواء مقبولة. يجب على الأشخاص الحساسين تقليل المجهود الخارجي المطول.';

  @override
  String get aqiModerateAdvice =>
      'قد تتأثر المجموعات الحساسة صحياً. فكر في تقليل الأنشطة الخارجية.';

  @override
  String get aqiPoorAdvice =>
      'قد يبدأ الجميع في الشعور بتأثيرات صحية. قلل الأنشطة الخارجية.';

  @override
  String get aqiVeryPoorAdvice =>
      'تنبيه صحي! يجب على الجميع تجنب الأنشطة الخارجية.';

  @override
  String get layers => 'الطبقات';

  @override
  String get precipitation => 'الهطول';

  @override
  String get temperature => 'الحرارة';

  @override
  String get windLayer => 'الرياح';

  @override
  String get pressureLayer => 'الضغط';

  @override
  String get location => 'الموقع';

  @override
  String get coordinates => 'الإحداثيات';

  @override
  String get undo => 'تراجع';

  @override
  String favoriteRemoved(String city) {
    return 'تمت إزالة $city';
  }

  @override
  String get listView => 'عرض القائمة';

  @override
  String get chartView => 'عرض الرسم';

  @override
  String get compact => 'مضغوط';

  @override
  String get detailView => 'عرض تفصيلي';

  @override
  String get simpleView => 'عرض بسيط';

  @override
  String get baseLayer => 'أساس';

  @override
  String get centerOnCity => 'التمركز على المدينة';

  @override
  String get aqiGoodDescription =>
      'جودة الهواء ممتازة. مثالية للأنشطة الخارجية.';

  @override
  String get aqiFairDescription =>
      'جودة الهواء مقبولة. يجب على الأشخاص الحساسين توخي الحذر.';

  @override
  String get aqiModerateDescription =>
      'جودة الهواء متوسطة. يُفضل تقليل الأنشطة الخارجية.';

  @override
  String get aqiPoorDescription =>
      'جودة الهواء سيئة. قلل التعرض الطويل في الخارج.';

  @override
  String get aqiVeryPoorDescription =>
      'جودة الهواء سيئة جدا. تجنب الأنشطة الخارجية إن أمكن.';

  @override
  String get celsiusShort => '°م';

  @override
  String get fahrenheitShort => '°ف';

  @override
  String get kmhShort => 'كم/س';

  @override
  String get mphShort => 'ميل/س';

  @override
  String get weatherCompanion => 'رفيقك للطقس';

  @override
  String get recentSearches => 'عمليات البحث الأخيرة';

  @override
  String get clearHistory => 'مسح';
}
