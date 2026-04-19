import 'package:intl/intl.dart';

// Date/time formatting helpers for weather timestamps
class AppDateUtils {
  AppDateUtils._();

  static String formatTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('EEE, MMM d').format(dateTime);
  }

  static String formatFullDate(DateTime dateTime) {
    return DateFormat('EEEE, MMMM d, yyyy').format(dateTime);
  }

  static String formatDayOfWeek(DateTime dateTime) {
    return DateFormat('EEE').format(dateTime);
  }

  static String formatHour(DateTime dateTime) {
    return DateFormat('ha').format(dateTime).toLowerCase();
  }

  static String timeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  // Check if given timestamp is during nighttime (rough: 6pm to 6am)
  static bool isNight(int timestamp, {int? sunrise, int? sunset}) {
    if (sunrise != null && sunset != null) {
      return timestamp < sunrise || timestamp > sunset;
    }
    final hour = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).hour;
    return hour < 6 || hour > 18;
  }

  // Convert unix timestamp from API
  static DateTime fromUnixTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }
}
