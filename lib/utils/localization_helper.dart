import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:blood_system/l10n/app_localizations.dart';
import 'package:blood_system/l10n/kinyarwanda_localizations.dart';
import 'package:blood_system/blocs/language/bloc.dart';

class LocalizationHelper {
  static String formatDate(BuildContext context, DateTime date) {
    final l10n = AppLocalizations.of(context)!;
    // Use our custom language system instead of MaterialApp locale
    final currentLanguage = _getCurrentLanguage(context);
    
    if (currentLanguage == 'rw') {
      return KinyarwandaLocalizations.formatDate(date);
    } else if (currentLanguage == 'fr') {
      return DateFormat.yMMMd('fr').format(date);
    } else {
      return DateFormat.yMMMd('en').format(date);
    }
  }

  static String _getCurrentLanguage(BuildContext context) {
    // Get the current language from our LanguageBloc
    try {
      final languageState = context.read<LanguageBloc>().state;
      if (languageState is LanguageLoadedState) {
        return languageState.locale.languageCode;
      }
    } catch (e) {
      // Fallback to English if there's an error
    }
    // Also check the MaterialApp locale as fallback
    final locale = Localizations.localeOf(context);
    return locale.languageCode;
  }

  static String formatTime(BuildContext context, TimeOfDay time) {
    final currentLanguage = _getCurrentLanguage(context);
    
    if (currentLanguage == 'rw') {
      return KinyarwandaLocalizations.formatTime(time);
    } else {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
  }

  static String formatDateTime(BuildContext context, DateTime dateTime) {
    final currentLanguage = _getCurrentLanguage(context);
    
    if (currentLanguage == 'rw') {
      return KinyarwandaLocalizations.formatDateTime(dateTime);
    } else if (currentLanguage == 'fr') {
      return DateFormat.yMMMd('fr').add_jm().format(dateTime);
    } else {
      return DateFormat.yMMMd('en').add_jm().format(dateTime);
    }
  }

  static String formatNumber(BuildContext context, num number) {
    final locale = Localizations.localeOf(context);
    
    if (locale.languageCode == 'rw') {
      return KinyarwandaLocalizations.formatNumber(number);
    } else {
      return NumberFormat('#,##0', locale.languageCode).format(number);
    }
  }

  static String formatCurrency(BuildContext context, num amount) {
    final locale = Localizations.localeOf(context);
    
    if (locale.languageCode == 'rw') {
      return KinyarwandaLocalizations.formatCurrency(amount);
    } else {
      return NumberFormat.currency(locale: locale.languageCode).format(amount);
    }
  }

  static String formatPercent(BuildContext context, double percent) {
    final locale = Localizations.localeOf(context);
    
    if (locale.languageCode == 'rw') {
      return KinyarwandaLocalizations.formatPercent(percent);
    } else {
      return NumberFormat.percentPattern(locale.languageCode).format(percent);
    }
  }

  static String getDayName(BuildContext context, int day) {
    final currentLanguage = _getCurrentLanguage(context);
    
    if (currentLanguage == 'rw') {
      return KinyarwandaLocalizations.getDayName(day);
    } else if (currentLanguage == 'fr') {
      final date = DateTime(2024, 1, day);
      return DateFormat.EEEE('fr').format(date);
    } else {
      // Use standard day names for other languages
      final date = DateTime(2024, 1, day);
      return DateFormat.EEEE('en').format(date);
    }
  }

  static String getMonthName(BuildContext context, int month) {
    final currentLanguage = _getCurrentLanguage(context);
    
    if (currentLanguage == 'rw') {
      return KinyarwandaLocalizations.getMonthName(month);
    } else if (currentLanguage == 'fr') {
      final date = DateTime(2024, month, 1);
      return DateFormat.MMMM('fr').format(date);
    } else {
      // Use standard month names for other languages
      final date = DateTime(2024, month, 1);
      return DateFormat.MMMM('en').format(date);
    }
  }

  // Form field validation messages
  static String getRequiredFieldMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.required;
  }

  static String getInvalidEmailMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return '${l10n.email} ${l10n.invalid}';
  }

  static String getInvalidPhoneMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return '${l10n.phone} ${l10n.invalid}';
  }

  static String getInvalidDateMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return '${l10n.dateOfBirth} ${l10n.invalid}';
  }

  static String getInvalidTimeMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return '${l10n.appointmentTime} ${l10n.invalid}';
  }

  // Form field labels
  static String getFirstNameLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.firstName;
  }

  static String getLastNameLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.lastName;
  }

  static String getEmailLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.email;
  }

  static String getPhoneLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.phone;
  }

  static String getPasswordLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.password;
  }

  static String getConfirmPasswordLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.confirmPassword;
  }

  static String getDateOfBirthLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.dateOfBirth;
  }

  static String getNationalIdLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.nationalId;
  }

  static String getAddressLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.address;
  }

  static String getCityLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.city;
  }

  static String getCountryLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.country;
  }

  static String getDistrictLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.district;
  }

  static String getRoleLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.role;
  }

  // Button labels
  static String getSaveButtonLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.save;
  }

  static String getCancelButtonLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.cancel;
  }

  static String getConfirmButtonLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.confirm;
  }

  static String getSubmitButtonLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.submit;
  }

  static String getCreateButtonLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.create;
  }

  static String getUpdateButtonLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.update;
  }

  static String getDeleteButtonLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.delete;
  }

  static String getEditButtonLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.edit;
  }

  // Status messages
  static String getSuccessMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.success;
  }

  static String getErrorMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.error;
  }

  static String getLoadingMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.loading;
  }

  static String getWarningMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.warning;
  }

  // Form placeholders
  static String getEnterFirstNamePlaceholder(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return '${l10n.enterEventName.replaceAll('event', 'first name')}';
  }

  static String getEnterLastNamePlaceholder(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return '${l10n.enterEventName.replaceAll('event', 'last name')}';
  }

  static String getEnterEmailPlaceholder(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return '${l10n.enterEventName.replaceAll('event', 'email')}';
  }

  static String getEnterPhonePlaceholder(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return '${l10n.enterEventName.replaceAll('event', 'phone')}';
  }

  static String getEnterAddressPlaceholder(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return '${l10n.enterLocation}';
  }

  static String getEnterDescriptionPlaceholder(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.enterDescription;
  }
} 