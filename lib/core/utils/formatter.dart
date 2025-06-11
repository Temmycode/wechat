import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
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
    bool useTodayText = false,
    String todayPattern = 'HH.mm',
    String yesterdayText = 'yesterday',
    String otherDaysPattern = 'MMMM d, HH.mm',
  }) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly.isAtSameMomentAs(today)) {
      if (useTodayText) {
        return "Today";
      }

      return DateFormat(todayPattern).format(date);
    }

    if (dateOnly.isAtSameMomentAs(yesterday)) {
      return yesterdayText;
    }

    return DateFormat(otherDaysPattern).format(date);
  }
}

class NumberFormatter {
  static const String DEFAULT_COUNTRY_CODE = '+234';

  static Future<String> standardizePhoneNumber(String phoneNumber) async {
    // Remove all non-digit characters except the + sign
    String cleaned = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

    // If it already starts with +, it already has a country code
    if (cleaned.startsWith('+')) {
      return cleaned;
    }

    // Get deivce country code
    String countryCode = await _getDeviceCountryCode();

    // if the number starts with 0, remove it before adding the country code
    if (cleaned.startsWith('0')) {
      cleaned = cleaned.substring(1);
    }

    return '$countryCode$cleaned';
  }

  static Future<String> _getDeviceCountryCode() async {
    try {
      final deviceInfo = DeviceInfoPlugin();

      if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        // Convert ISO country code to calling code
        return _getCallingCode(iosInfo.localizedModel.split('_').last);
      } else if (Platform.isAndroid) {
        final systemLocales = PlatformDispatcher.instance.locales;
        final countryCode =
            systemLocales.isNotEmpty
                ? systemLocales.first.countryCode ?? 'NG'
                : 'NG';
        return _getCallingCode(countryCode);
      }
    } catch (e) {
      debugPrint('Error getting device country code: $e');
    }

    return DEFAULT_COUNTRY_CODE;
  }

  static String _getCallingCode(String isoCode) {
    // This is a simplified mapping. You might want to use a more complete database
    final Map<String, String> countryCodes = {
      'NG': '+234', // Nigeria
      'US': '+1', // United States
      'GB': '+44', // United Kingdom
      'GH': '+233', // Ghana
      // Add more countries as needed
    };

    return countryCodes[isoCode] ?? DEFAULT_COUNTRY_CODE;
  }
}
