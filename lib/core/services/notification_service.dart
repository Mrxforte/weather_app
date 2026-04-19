import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

const _dailyWeatherTask = 'daily_weather_notification';

// Background task callback — must be top-level
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == _dailyWeatherTask) {
      await NotificationService.showWeatherNotification(
        title: 'Daily Weather Update',
        body: 'Tap to check today\'s weather forecast!',
      );
    }
    return true;
  });
}

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
    );
    await _plugin.initialize(settings);

    // Initialize workmanager
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  }

  static Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final granted = await android?.requestNotificationsPermission();
      return granted ?? false;
    }
    return true;
  }

  static Future<void> showWeatherNotification({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'weather_daily',
      'Daily Weather',
      channelDescription: 'Daily weather update notification',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      styleInformation: BigTextStyleInformation(''),
    );
    const details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );
    await _plugin.show(0, title, body, details);
  }

  static Future<void> scheduleDailyNotification() async {
    await Workmanager().registerPeriodicTask(
      _dailyWeatherTask,
      _dailyWeatherTask,
      frequency: const Duration(hours: 24),
      initialDelay: _timeUntilNextMorning(),
      constraints: Constraints(networkType: NetworkType.connected),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
    );
  }

  static Future<void> cancelDailyNotification() async {
    await Workmanager().cancelByUniqueName(_dailyWeatherTask);
  }

  static Duration _timeUntilNextMorning() {
    final now = DateTime.now();
    var next = DateTime(now.year, now.month, now.day, 8, 0);
    if (now.isAfter(next)) {
      next = next.add(const Duration(days: 1));
    }
    return next.difference(now);
  }
}
