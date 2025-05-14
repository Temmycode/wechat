import 'package:intl/intl.dart';

class DateFormatter {
  /// Formats a date into a human-readable string
  /// Returns formats like:
  /// - "HH.mm" (e.g. "18.32") for times today
  /// - "yesterday" for yesterday
  /// - "MM.dd" (e.g. "06.13") for dates in current year
  /// - "yyyy.MM.dd" (e.g. "2023.06.13") for dates in previous years
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

    // If time is from current year but not today or yesterday, show MM.dd
    if (date.year == now.year) {
      return DateFormat('MM.dd').format(date);
    }

    // If time is from previous years, show yyyy.MM.dd
    return DateFormat('yyyy.MM.dd').format(date);
  }

  /// Alternative format that allows customization of patterns
  static String formatCustom({
    required DateTime date,
    String todayPattern = 'HH.mm',
    String yesterdayText = 'yesterday',
    String thisYearPattern = 'MM.dd',
    String otherYearPattern = 'yyyy.MM.dd',
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

    if (date.year == now.year) {
      return DateFormat(thisYearPattern).format(date);
    }

    return DateFormat(otherYearPattern).format(date);
  }
}
