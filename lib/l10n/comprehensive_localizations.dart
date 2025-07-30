import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:blood_system/l10n/kinyarwanda_localizations.dart';

class ComprehensiveLocalizations {
  final Locale locale;

  ComprehensiveLocalizations(this.locale);

  static ComprehensiveLocalizations of(BuildContext context) {
    return Localizations.of<ComprehensiveLocalizations>(context, ComprehensiveLocalizations)!;
  }

  static const LocalizationsDelegate<ComprehensiveLocalizations> delegate = _ComprehensiveLocalizationsDelegate();

  String get languageCode => locale.languageCode;

  // Material Design localization
  String get okButtonLabel => _getLocalizedString('OK', 'OK', 'Sawa');
  String get cancelButtonLabel => _getLocalizedString('Cancel', 'Annuler', 'Hagarika');
  String get closeButtonLabel => _getLocalizedString('Close', 'Fermer', 'Funga');
  String get searchLabel => _getLocalizedString('Search', 'Rechercher', 'Shakisha');
  String get noResultsFoundLabel => _getLocalizedString('No results found', 'Aucun résultat trouvé', 'Nta ibisubizo byabonetse');
  String get selectAllButtonLabel => _getLocalizedString('Select All', 'Tout sélectionner', 'Hitamo Byose');
  String get selectButtonLabel => _getLocalizedString('Select', 'Sélectionner', 'Hitamo');
  String get saveButtonLabel => _getLocalizedString('Save', 'Enregistrer', 'Bika');
  String get deleteButtonLabel => _getLocalizedString('Delete', 'Supprimer', 'Siba');
  String get editButtonLabel => _getLocalizedString('Edit', 'Modifier', 'Hindura');
  String get createButtonLabel => _getLocalizedString('Create', 'Créer', 'Kora');
  String get updateButtonLabel => _getLocalizedString('Update', 'Mettre à jour', 'Hindura');
  String get submitButtonLabel => _getLocalizedString('Submit', 'Soumettre', 'Ohereza');
  String get resetButtonLabel => _getLocalizedString('Reset', 'Réinitialiser', 'Tangira');
  String get backButtonLabel => _getLocalizedString('Back', 'Retour', 'Subira Inyuma');
  String get nextButtonLabel => _getLocalizedString('Next', 'Suivant', 'Ibikurikira');
  String get previousButtonLabel => _getLocalizedString('Previous', 'Précédent', 'Ibihari');
  String get continueButtonLabel => _getLocalizedString('Continue', 'Continuer', 'Komeza');
  String get finishButtonLabel => _getLocalizedString('Finish', 'Terminer', 'Rangiza');
  String get skipButtonLabel => _getLocalizedString('Skip', 'Passer', 'Siga');
  String get doneButtonLabel => _getLocalizedString('Done', 'Terminé', 'Byarangiye');
  String get yesButtonLabel => _getLocalizedString('Yes', 'Oui', 'Yego');
  String get noButtonLabel => _getLocalizedString('No', 'Non', 'Oya');

  // Date and time localization
  String get todayLabel => _getLocalizedString('Today', 'Aujourd\'hui', 'Uyu munsi');
  String get yesterdayLabel => _getLocalizedString('Yesterday', 'Hier', 'Ejo');
  String get tomorrowLabel => _getLocalizedString('Tomorrow', 'Demain', 'Ejo hazaza');
  String get thisWeekLabel => _getLocalizedString('This Week', 'Cette semaine', 'Iyi cyumweru');
  String get lastWeekLabel => _getLocalizedString('Last Week', 'La semaine dernière', 'Icyumweru gishize');
  String get nextWeekLabel => _getLocalizedString('Next Week', 'La semaine prochaine', 'Icyumweru gikurikira');
  String get thisMonthLabel => _getLocalizedString('This Month', 'Ce mois', 'Uku kwezi');
  String get lastMonthLabel => _getLocalizedString('Last Month', 'Le mois dernier', 'Ukwezi gushize');
  String get nextMonthLabel => _getLocalizedString('Next Month', 'Le mois prochain', 'Ukwezi gukurikira');
  String get thisYearLabel => _getLocalizedString('This Year', 'Cette année', 'Uyu mwaka');
  String get lastYearLabel => _getLocalizedString('Last Year', 'L\'année dernière', 'Umwaka ushize');
  String get nextYearLabel => _getLocalizedString('Next Year', 'L\'année prochaine', 'Umwaka ukurikira');

  // Form localization
  String get requiredFieldLabel => _getLocalizedString('Required', 'Requis', 'Bikenewe');
  String get optionalFieldLabel => _getLocalizedString('Optional', 'Optionnel', 'Bishobora kuba');
  String get invalidFormatLabel => _getLocalizedString('Invalid format', 'Format invalide', 'Imiterere itari myiza');
  String get fieldRequiredLabel => _getLocalizedString('This field is required', 'Ce champ est requis', 'Iki gice kikenewe');
  String get invalidEmailLabel => _getLocalizedString('Invalid email address', 'Adresse email invalide', 'Aderesi ya imeyili itari myiza');
  String get invalidPhoneLabel => _getLocalizedString('Invalid phone number', 'Numéro de téléphone invalide', 'Inomero ya telefoni itari myiza');
  String get invalidDateLabel => _getLocalizedString('Invalid date', 'Date invalide', 'Itariki itari myiza');
  String get invalidTimeLabel => _getLocalizedString('Invalid time', 'Heure invalide', 'Igihe kitari myiza');

  // Status messages
  String get loadingLabel => _getLocalizedString('Loading...', 'Chargement...', 'Birakora...');
  String get errorLabel => _getLocalizedString('Error', 'Erreur', 'Ikibazo');
  String get successLabel => _getLocalizedString('Success', 'Succès', 'Byagenze neza');
  String get warningLabel => _getLocalizedString('Warning', 'Avertissement', 'Iburira');
  String get infoLabel => _getLocalizedString('Information', 'Information', 'Amakuru');
  String get confirmLabel => _getLocalizedString('Confirm', 'Confirmer', 'Emeza');
  String get acceptLabel => _getLocalizedString('Accept', 'Accepter', 'Emeza');
  String get declineLabel => _getLocalizedString('Decline', 'Refuser', 'Wanga');
  String get approveLabel => _getLocalizedString('Approve', 'Approuver', 'Emeza');
  String get rejectLabel => _getLocalizedString('Reject', 'Rejeter', 'Wanga');

  // Helper method to get localized strings
  String _getLocalizedString(String english, String french, String kinyarwanda) {
    switch (locale.languageCode) {
      case 'en':
        return english;
      case 'fr':
        return french;
      case 'rw':
        return kinyarwanda;
      default:
        return english;
    }
  }

  // Date formatting methods
  String formatDate(DateTime date) {
    if (locale.languageCode == 'rw') {
      return KinyarwandaLocalizations.formatDate(date);
    } else {
      return DateFormat.yMMMd(locale.languageCode).format(date);
    }
  }

  String formatTime(TimeOfDay time) {
    if (locale.languageCode == 'rw') {
      return KinyarwandaLocalizations.formatTime(time);
    } else {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
  }

  String formatDateTime(DateTime dateTime) {
    if (locale.languageCode == 'rw') {
      return KinyarwandaLocalizations.formatDateTime(dateTime);
    } else {
      return DateFormat.yMMMd(locale.languageCode).add_jm().format(dateTime);
    }
  }

  String formatNumber(num number) {
    if (locale.languageCode == 'rw') {
      return KinyarwandaLocalizations.formatNumber(number);
    } else {
      return NumberFormat('#,##0', locale.languageCode).format(number);
    }
  }

  String formatCurrency(num amount) {
    if (locale.languageCode == 'rw') {
      return KinyarwandaLocalizations.formatCurrency(amount);
    } else {
      return NumberFormat.currency(locale: locale.languageCode).format(amount);
    }
  }

  String formatPercent(double percent) {
    if (locale.languageCode == 'rw') {
      return KinyarwandaLocalizations.formatPercent(percent);
    } else {
      return NumberFormat.percentPattern(locale.languageCode).format(percent);
    }
  }
}

class _ComprehensiveLocalizationsDelegate extends LocalizationsDelegate<ComprehensiveLocalizations> {
  const _ComprehensiveLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fr', 'rw'].contains(locale.languageCode);
  }

  @override
  Future<ComprehensiveLocalizations> load(Locale locale) async {
    return ComprehensiveLocalizations(locale);
  }

  @override
  bool shouldReload(_ComprehensiveLocalizationsDelegate old) => false;
} 