import 'package:intl/intl.dart';

class DateFormatter {
  /// Formats a date into a human-readable string
  /// Returns formats like:
  /// - "HH.mm" (e.g. "18.32") for times today
  /// - "yesterday" for yesterday
  /// - "Month d, HH.mm" (e.g. "July 14, 12.30") for any other date
  static String format(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    // If time is from today, show only time (HH.mm)
    if (dateOnly.isAtSameMomentAs(today)) {
      return DateFormat('HH.mm').format(date);
    }

    // If time is from yesterday, show "yesterday"
    if (dateOnly.isAtSameMomentAs(yesterday)) {
      return 'yesterday';
    }

    // For any other date, show "Month d, HH.mm" format
    return DateFormat("MMMM d, HH.mm").format(date);
  }

  /// Alternative format that allows customization of patterns
  static String formatCustom({
    required DateTime date,
    String todayPattern = 'HH.mm',
    String yesterdayText = 'yesterday',
    String otherDaysPattern = 'MMMM d, HH.mm',
  }) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly.isAtSameMomentAs(today)) {
      return DateFormat(todayPattern).format(date);
    }

    if (dateOnly.isAtSameMomentAs(yesterday)) {
      return yesterdayText;
    }

    return DateFormat(otherDaysPattern).format(date);
  }
}
