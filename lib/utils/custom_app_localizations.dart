import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blood_system/l10n/app_localizations.dart';
import 'package:blood_system/blocs/language/bloc.dart';

class CustomAppLocalizations {
  static AppLocalizations of(BuildContext context) {
    // Get the current language from our LanguageBloc
    final languageState = context.read<LanguageBloc>().state;
    String languageCode = 'en'; // Default to English
    
    if (languageState is LanguageLoadedState) {
      languageCode = languageState.locale.languageCode;
    }
    
    // Return the appropriate AppLocalizations based on the selected language
    switch (languageCode) {
      case 'fr':
        return AppLocalizations.of(context)!;
      case 'rw':
        return AppLocalizations.of(context)!;
      default:
        return AppLocalizations.of(context)!;
    }
  }

  // Helper method to get localized string with fallback
  static String getString(BuildContext context, String Function(AppLocalizations) getter) {
    try {
      final l10n = of(context);
      return getter(l10n);
    } catch (e) {
      // Fallback to English if there's an error
      return getter(AppLocalizations.of(context)!);
    }
  }

  // Helper method to get localized string with parameters
  static String getStringWithParams(
    BuildContext context, 
    String Function(AppLocalizations) getter,
    Map<String, dynamic> params,
  ) {
    try {
      final l10n = of(context);
      return getter(l10n);
    } catch (e) {
      // Fallback to English if there's an error
      return getter(AppLocalizations.of(context)!);
    }
  }
} 