import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KinyarwandaLocalizations {
  static const Locale locale = Locale('rw');

  static String getLanguageCode() => locale.languageCode;

  static String getCountryCode() => locale.countryCode ?? '';

  static String getLocaleName() => locale.toString();

  static List<Locale> get supportedLocales => [locale];

  // Add more comprehensive localization support
  static String getLanguageName() => 'Ikinyarwanda';
  static String getCountryName() => 'Rwanda';
  static String getCurrencyCode() => 'RWF';
  static String getCurrencySymbol() => '₣';
  static String getDateFormat() => 'dd/MM/yyyy';
  static String getTimeFormat() => 'HH:mm';
  static String getDateTimeFormat() => 'dd/MM/yyyy HH:mm';
  static String getNumberFormat() => '#,##0';
  static String getDecimalSeparator() => ',';
  static String getThousandsSeparator() => '.';
  static String getPercentFormat() => '#,##0%';
  static String getCurrencyFormat() => '#,##0.00 ₣';

  static String formatDate(DateTime date) {
    return DateFormat(getDateFormat(), 'rw').format(date);
  }

  static String formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat(getDateTimeFormat(), 'rw').format(dateTime);
  }

  static String formatNumber(num number) {
    return NumberFormat('#,##0', 'rw').format(number);
  }

  static String formatCurrency(num amount) {
    return NumberFormat.currency(locale: 'rw', symbol: 'RWF').format(amount);
  }

  static String formatPercent(double percent) {
    return NumberFormat.percentPattern('rw').format(percent);
  }

  // Add more comprehensive formatting methods
  static String formatShortDate(DateTime date) {
    return DateFormat('dd/MM/yy', 'rw').format(date);
  }

  static String formatLongDate(DateTime date) {
    return DateFormat('EEEE, d MMMM yyyy', 'rw').format(date);
  }

  static String formatShortTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  static String formatLongTime(TimeOfDay time) {
    final hour = time.hour;
    final minute = time.minute;
    if (hour < 12) {
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} AM';
    } else {
      return '${(hour - 12).toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} PM';
    }
  }

  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) {
      return 'Uyu munsi';
    } else if (difference == 1) {
      return 'Ejo';
    } else if (difference == -1) {
      return 'Ejo hazaza';
    } else if (difference > 0 && difference < 7) {
      return 'Iminsi $difference ishize';
    } else if (difference < 0 && difference > -7) {
      return 'Mu myinsi ${difference.abs()}';
    } else {
      return formatDate(date);
    }
  }

  // Days of the week
  static String getDayName(int day) {
    switch (day) {
      case 1:
        return 'Kuwa Mbere';
      case 2:
        return 'Kuwa Kabiri';
      case 3:
        return 'Kuwa Gatatu';
      case 4:
        return 'Kuwa Kane';
      case 5:
        return 'Kuwa Gatanu';
      case 6:
        return 'Kuwa Gatandatu';
      case 7:
        return 'Kuwa Cyumweru';
      default:
        return '';
    }
  }

  // Months
  static String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Mutarama';
      case 2:
        return 'Gashyantare';
      case 3:
        return 'Werurwe';
      case 4:
        return 'Mata';
      case 5:
        return 'Gicurasi';
      case 6:
        return 'Kamena';
      case 7:
        return 'Nyakanga';
      case 8:
        return 'Kanama';
      case 9:
        return 'Nzeli';
      case 10:
        return 'Ukwakira';
      case 11:
        return 'Ugushyingo';
      case 12:
        return 'Ukuboza';
      default:
        return '';
    }
  }
}

class KinyarwandaLocalizationsDelegate extends LocalizationsDelegate<KinyarwandaLocalizations> {
  const KinyarwandaLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == 'rw';
  }

  @override
  Future<KinyarwandaLocalizations> load(Locale locale) async {
    return KinyarwandaLocalizations();
  }

  @override
  bool shouldReload(KinyarwandaLocalizationsDelegate old) => false;
} 