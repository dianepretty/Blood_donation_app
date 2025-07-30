import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CustomMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const CustomMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fr', 'rw'].contains(locale.languageCode);
  }

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    // For Kinyarwanda, return English MaterialLocalizations as fallback
    if (locale.languageCode == 'rw') {
      return await GlobalMaterialLocalizations.delegate.load(const Locale('en'));
    }
    // For other languages, use the built-in delegate
    return await GlobalMaterialLocalizations.delegate.load(locale);
  }

  @override
  bool shouldReload(CustomMaterialLocalizationsDelegate old) => false;
} 