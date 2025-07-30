// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Application de Don de Sang';

  @override
  String get settings => 'Paramètres';

  @override
  String get language => 'Langue';

  @override
  String get security => 'Sécurité';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String lastChanged(int days) {
    return 'Dernière modification il y a $days jours';
  }

  @override
  String get twoFactorAuth => 'Authentification à deux facteurs';

  @override
  String get recommended => 'Recommandé';

  @override
  String get appInformation => 'Informations sur l\'application';

  @override
  String get appVersion => 'Version de l\'application';

  @override
  String get lastUpdated => 'Dernière mise à jour';

  @override
  String get other => 'Autre';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get privacyPolicyDesc => 'Découvrez comment nous traitons vos données.';

  @override
  String get termsOfService => 'Conditions de service';

  @override
  String get termsOfServiceDesc => 'Consultez notre accord de service.';

  @override
  String get logout => 'Déconnexion';

  @override
  String get logoutConfirm => 'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get save => 'Enregistrer';

  @override
  String get loading => 'Chargement...';

  @override
  String get error => 'Erreur';

  @override
  String get success => 'Succès';

  @override
  String get home => 'Accueil';

  @override
  String get events => 'Événements';

  @override
  String get appointments => 'Rendez-vous';

  @override
  String get profile => 'Profil';

  @override
  String get history => 'Historique';

  @override
  String get helpSupport => 'Aide et Support';

  @override
  String get donationHistory => 'Historique des Dons';

  @override
  String get createEvent => 'Créer un Événement';

  @override
  String get editEvent => 'Modifier l\'Événement';

  @override
  String get viewEvent => 'Voir l\'Événement';

  @override
  String get eventName => 'Nom de l\'Événement';

  @override
  String get eventLocation => 'Lieu';

  @override
  String get eventDate => 'Date';

  @override
  String get eventTime => 'Heure';

  @override
  String get eventDescription => 'Description';

  @override
  String get eventStatus => 'Statut';

  @override
  String get upcoming => 'À venir';

  @override
  String get active => 'Actif';

  @override
  String get completed => 'Terminé';

  @override
  String get bookAppointment => 'Prendre Rendez-vous';

  @override
  String get appointmentDate => 'Date du Rendez-vous';

  @override
  String get appointmentTime => 'Heure du Rendez-vous';

  @override
  String get appointmentType => 'Type de Rendez-vous';

  @override
  String get bloodDonation => 'Don de Sang';

  @override
  String get consultation => 'Consultation';

  @override
  String get login => 'Connexion';

  @override
  String get register => 'S\'inscrire';

  @override
  String get email => 'Email';

  @override
  String get password => 'Mot de passe';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get fullName => 'Nom complet';

  @override
  String get phoneNumber => 'Numéro de téléphone';

  @override
  String get district => 'District';

  @override
  String get role => 'Rôle';

  @override
  String get volunteer => 'Bénévole';

  @override
  String get hospitalAdmin => 'Administrateur d\'Hôpital';

  @override
  String get welcome => 'Bienvenue';

  @override
  String get dashboard => 'Tableau de bord';

  @override
  String get overview => 'Aperçu';

  @override
  String get upcomingEvents => 'Événements à venir';

  @override
  String get pendingAppointments => 'Demandes de Rendez-vous en Attente';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationsComingSoon => 'Les notifications arrivent bientôt !';

  @override
  String get userName => 'Nom d\'utilisateur';

  @override
  String get userEmail => 'utilisateur@exemple.com';

  @override
  String get selectLanguage => 'Sélectionner la Langue';

  @override
  String get english => 'Anglais';

  @override
  String get french => 'Français';

  @override
  String get kinyarwanda => 'Kinyarwanda';

  @override
  String get languageChanged => 'Langue changée avec succès';

  @override
  String get pleaseLogin => 'Veuillez vous connecter pour voir les événements';

  @override
  String get noEvents => 'Aucun événement trouvé';

  @override
  String get noAppointments => 'Aucun rendez-vous trouvé';

  @override
  String get createNewEvent => 'Créer un Nouvel Événement';

  @override
  String get editEventDetails => 'Modifier les Détails de l\'Événement';

  @override
  String get eventCreated => 'Événement créé avec succès !';

  @override
  String get eventUpdated => 'Événement mis à jour avec succès !';

  @override
  String get eventDeleted => 'Événement supprimé avec succès !';

  @override
  String get failedToCreateEvent => 'Échec de la création de l\'événement. Veuillez réessayer.';

  @override
  String get failedToUpdateEvent => 'Échec de la mise à jour de l\'événement. Veuillez réessayer.';

  @override
  String get failedToDeleteEvent => 'Échec de la suppression de l\'événement. Veuillez réessayer.';

  @override
  String get viewDetails => 'Voir les Détails';

  @override
  String get enterEventName => 'Entrer le nom de l\'événement';

  @override
  String get enterLocation => 'Entrer le lieu';

  @override
  String get enterDescription => 'Entrer la description de l\'événement';

  @override
  String get selectDate => 'Sélectionner la Date';

  @override
  String get selectTime => 'Sélectionner l\'Heure';

  @override
  String get fromTime => 'Heure de Début';

  @override
  String get toTime => 'Heure de Fin';

  @override
  String get invalidTime => 'L\'heure de fin doit être après l\'heure de début';

  @override
  String get required => 'Requis';

  @override
  String get optional => 'Optionnel';

  @override
  String get welcomeToBloodDonation => 'Bienvenue au Don de Sang';

  @override
  String get saveChanges => 'Enregistrer les Modifications';

  @override
  String get delete => 'Supprimer';

  @override
  String get edit => 'Modifier';

  @override
  String get create => 'Créer';

  @override
  String get update => 'Mettre à Jour';

  @override
  String get back => 'Retour';

  @override
  String get next => 'Suivant';

  @override
  String get previous => 'Précédent';

  @override
  String get submit => 'Soumettre';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get search => 'Rechercher';

  @override
  String get filter => 'Filtrer';

  @override
  String get sort => 'Trier';

  @override
  String get refresh => 'Actualiser';

  @override
  String get close => 'Fermer';

  @override
  String get open => 'Ouvrir';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get ok => 'OK';

  @override
  String get done => 'Terminé';

  @override
  String get skip => 'Passer';

  @override
  String get continueAction => 'Continuer';

  @override
  String get finishAction => 'Terminer';

  @override
  String get startAction => 'Commencer';

  @override
  String get stopAction => 'Arrêter';

  @override
  String get pauseAction => 'Pause';

  @override
  String get resumeAction => 'Reprendre';

  @override
  String get retryAction => 'Réessayer';

  @override
  String get abortAction => 'Annuler';

  @override
  String get accept => 'Accept';

  @override
  String get decline => 'Decline';

  @override
  String get approve => 'Approve';

  @override
  String get reject => 'Reject';

  @override
  String get pending => 'En Attente';

  @override
  String get approved => 'Approuvé';

  @override
  String get rejected => 'Rejeté';

  @override
  String get inProgress => 'En Cours';

  @override
  String get scheduled => 'Programmé';

  @override
  String get cancelled => 'Annulé';

  @override
  String get expired => 'Expiré';

  @override
  String get inactive => 'Inactif';

  @override
  String get enabled => 'Activé';

  @override
  String get disabled => 'Désactivé';

  @override
  String get visible => 'Visible';

  @override
  String get hidden => 'Masqué';

  @override
  String get public => 'Public';

  @override
  String get private => 'Privé';

  @override
  String get draft => 'Brouillon';

  @override
  String get published => 'Publié';

  @override
  String get archived => 'Archivé';

  @override
  String get deleted => 'Supprimé';

  @override
  String get restored => 'Restauré';

  @override
  String get moved => 'Déplacé';

  @override
  String get copied => 'Copié';

  @override
  String get shared => 'Partagé';

  @override
  String get unshared => 'Non Partagé';

  @override
  String get locked => 'Verrouillé';

  @override
  String get unlocked => 'Déverrouillé';

  @override
  String get verified => 'Vérifié';

  @override
  String get unverified => 'Non Vérifié';

  @override
  String get valid => 'Valide';

  @override
  String get invalid => 'Invalide';

  @override
  String get successful => 'Réussi';

  @override
  String get failed => 'Échoué';

  @override
  String get warning => 'Avertissement';

  @override
  String get info => 'Information';

  @override
  String get debug => 'Débogage';

  @override
  String get trace => 'Trace';

  @override
  String get fatal => 'Fatal';

  @override
  String get critical => 'Critique';

  @override
  String get high => 'Élevé';

  @override
  String get medium => 'Moyen';

  @override
  String get low => 'Faible';

  @override
  String get none => 'Aucun';

  @override
  String get all => 'Tous';

  @override
  String get some => 'Certains';

  @override
  String get few => 'Peu';

  @override
  String get many => 'Beaucoup';

  @override
  String get most => 'La Plupart';

  @override
  String get least => 'Le Moins';

  @override
  String get best => 'Meilleur';

  @override
  String get worst => 'Pire';

  @override
  String get better => 'Mieux';

  @override
  String get worse => 'Pire';

  @override
  String get same => 'Même';

  @override
  String get different => 'Différent';

  @override
  String get similar => 'Similaire';

  @override
  String get unique => 'Unique';

  @override
  String get common => 'Commun';

  @override
  String get rare => 'Rare';

  @override
  String get frequent => 'Fréquent';

  @override
  String get occasional => 'Occasionnel';

  @override
  String get regular => 'Régulier';

  @override
  String get irregular => 'Irregular';

  @override
  String get normal => 'Normal';

  @override
  String get abnormal => 'Anormal';

  @override
  String get standardType => 'Standard';

  @override
  String get customType => 'Personnalisé';

  @override
  String get defaultValue => 'Par Défaut';

  @override
  String get automaticMode => 'Automatique';

  @override
  String get manualMode => 'Manuel';

  @override
  String get automatic => 'Automatic';

  @override
  String get semiAutomatic => 'Semi-Automatic';

  @override
  String get fullyAutomatic => 'Fully Automatic';

  @override
  String get partiallyAutomatic => 'Partially Automatic';

  @override
  String get completelyAutomatic => 'Completely Automatic';

  @override
  String get notAutomatic => 'Not Automatic';

  @override
  String get semiManual => 'Semi-Manual';

  @override
  String get fullyManual => 'Fully Manual';

  @override
  String get partiallyManual => 'Partially Manual';

  @override
  String get completelyManual => 'Completely Manual';

  @override
  String get notManual => 'Not Manual';

  @override
  String get semiCustom => 'Semi-Custom';

  @override
  String get fullyCustom => 'Fully Custom';

  @override
  String get partiallyCustom => 'Partially Custom';

  @override
  String get completelyCustom => 'Completely Custom';

  @override
  String get notCustom => 'Not Custom';

  @override
  String get semiStandard => 'Semi-Standard';

  @override
  String get fullyStandard => 'Fully Standard';

  @override
  String get partiallyStandard => 'Partially Standard';

  @override
  String get completelyStandard => 'Completely Standard';

  @override
  String get notStandard => 'Not Standard';

  @override
  String get semiDefault => 'Semi-Default';

  @override
  String get fullyDefault => 'Fully Default';

  @override
  String get partiallyDefault => 'Partially Default';

  @override
  String get completelyDefault => 'Completely Default';

  @override
  String get notDefault => 'Not Default';

  @override
  String get semiNormal => 'Semi-Normal';

  @override
  String get fullyNormal => 'Fully Normal';

  @override
  String get partiallyNormal => 'Partially Normal';

  @override
  String get completelyNormal => 'Completely Normal';

  @override
  String get notNormal => 'Not Normal';

  @override
  String get semiAbnormal => 'Semi-Abnormal';

  @override
  String get fullyAbnormal => 'Fully Abnormal';

  @override
  String get partiallyAbnormal => 'Partially Abnormal';

  @override
  String get completelyAbnormal => 'Completely Abnormal';

  @override
  String get notAbnormal => 'Not Abnormal';

  @override
  String get semiRegular => 'Semi-Regular';

  @override
  String get fullyRegular => 'Fully Regular';

  @override
  String get partiallyRegular => 'Partially Regular';

  @override
  String get completelyRegular => 'Completely Regular';

  @override
  String get notRegular => 'Not Regular';

  @override
  String get semiIrregular => 'Semi-Irregular';

  @override
  String get fullyIrregular => 'Fully Irregular';

  @override
  String get partiallyIrregular => 'Partially Irregular';

  @override
  String get completelyIrregular => 'Completely Irregular';

  @override
  String get notIrregular => 'Not Irregular';

  @override
  String get semiFrequent => 'Semi-Frequent';

  @override
  String get fullyFrequent => 'Fully Frequent';

  @override
  String get partiallyFrequent => 'Partially Frequent';

  @override
  String get completelyFrequent => 'Completely Frequent';

  @override
  String get notFrequent => 'Not Frequent';

  @override
  String get semiOccasional => 'Semi-Occasional';

  @override
  String get fullyOccasional => 'Fully Occasional';

  @override
  String get partiallyOccasional => 'Partially Occasional';

  @override
  String get completelyOccasional => 'Completely Occasional';

  @override
  String get notOccasional => 'Not Occasional';

  @override
  String get semiRare => 'Semi-Rare';

  @override
  String get fullyRare => 'Fully Rare';

  @override
  String get partiallyRare => 'Partially Rare';

  @override
  String get completelyRare => 'Completely Rare';

  @override
  String get notRare => 'Not Rare';

  @override
  String get semiCommon => 'Semi-Common';

  @override
  String get fullyCommon => 'Fully Common';

  @override
  String get partiallyCommon => 'Partially Common';

  @override
  String get completelyCommon => 'Completely Common';

  @override
  String get notCommon => 'Not Common';

  @override
  String get semiUnique => 'Semi-Unique';

  @override
  String get fullyUnique => 'Fully Unique';

  @override
  String get partiallyUnique => 'Partially Unique';

  @override
  String get completelyUnique => 'Completely Unique';

  @override
  String get notUnique => 'Not Unique';

  @override
  String get semiSimilar => 'Semi-Similar';

  @override
  String get fullySimilar => 'Fully Similar';

  @override
  String get partiallySimilar => 'Partially Similar';

  @override
  String get completelySimilar => 'Completely Similar';

  @override
  String get notSimilar => 'Not Similar';

  @override
  String get semiDifferent => 'Semi-Different';

  @override
  String get fullyDifferent => 'Fully Different';

  @override
  String get partiallyDifferent => 'Partially Different';

  @override
  String get completelyDifferent => 'Completely Different';

  @override
  String get notDifferent => 'Not Different';

  @override
  String get semiSame => 'Semi-Same';

  @override
  String get fullySame => 'Fully Same';

  @override
  String get partiallySame => 'Partially Same';

  @override
  String get completelySame => 'Completely Same';

  @override
  String get notSame => 'Not Same';

  @override
  String get semiWorse => 'Semi-Worse';

  @override
  String get fullyWorse => 'Fully Worse';

  @override
  String get partiallyWorse => 'Partially Worse';

  @override
  String get completelyWorse => 'Completely Worse';

  @override
  String get notWorse => 'Not Worse';

  @override
  String get semiBetter => 'Semi-Better';

  @override
  String get fullyBetter => 'Fully Better';

  @override
  String get partiallyBetter => 'Partially Better';

  @override
  String get completelyBetter => 'Completely Better';

  @override
  String get notBetter => 'Not Better';

  @override
  String get semiWorst => 'Semi-Worst';

  @override
  String get fullyWorst => 'Fully Worst';

  @override
  String get partiallyWorst => 'Partially Worst';

  @override
  String get completelyWorst => 'Completely Worst';

  @override
  String get notWorst => 'Not Worst';

  @override
  String get semiBest => 'Semi-Best';

  @override
  String get fullyBest => 'Fully Best';

  @override
  String get partiallyBest => 'Partially Best';

  @override
  String get completelyBest => 'Completely Best';

  @override
  String get notBest => 'Not Best';

  @override
  String get semiLeast => 'Semi-Least';

  @override
  String get fullyLeast => 'Fully Least';

  @override
  String get partiallyLeast => 'Partially Least';

  @override
  String get completelyLeast => 'Completely Least';

  @override
  String get notLeast => 'Not Least';

  @override
  String get semiMost => 'Semi-Most';

  @override
  String get fullyMost => 'Fully Most';

  @override
  String get partiallyMost => 'Partially Most';

  @override
  String get completelyMost => 'Completely Most';

  @override
  String get notMost => 'Not Most';

  @override
  String get semiMany => 'Semi-Many';

  @override
  String get fullyMany => 'Fully Many';

  @override
  String get partiallyMany => 'Partially Many';

  @override
  String get completelyMany => 'Completely Many';

  @override
  String get notMany => 'Not Many';

  @override
  String get semiFew => 'Semi-Few';

  @override
  String get fullyFew => 'Fully Few';

  @override
  String get partiallyFew => 'Partially Few';

  @override
  String get completelyFew => 'Completely Few';

  @override
  String get notFew => 'Not Few';

  @override
  String get semiSome => 'Semi-Some';

  @override
  String get fullySome => 'Fully Some';

  @override
  String get partiallySome => 'Partially Some';

  @override
  String get completelySome => 'Completely Some';

  @override
  String get notSome => 'Not Some';

  @override
  String get semiAll => 'Semi-All';

  @override
  String get fullyAll => 'Fully All';

  @override
  String get partiallyAll => 'Partially All';

  @override
  String get completelyAll => 'Completely All';

  @override
  String get notAll => 'Not All';

  @override
  String get semiNone => 'Semi-None';

  @override
  String get fullyNone => 'Fully None';

  @override
  String get partiallyNone => 'Partially None';

  @override
  String get completelyNone => 'Completely None';

  @override
  String get notNone => 'Not None';

  @override
  String get semiLow => 'Semi-Low';

  @override
  String get fullyLow => 'Fully Low';

  @override
  String get partiallyLow => 'Partially Low';

  @override
  String get completelyLow => 'Completely Low';

  @override
  String get notLow => 'Not Low';

  @override
  String get semiMedium => 'Semi-Medium';

  @override
  String get fullyMedium => 'Fully Medium';

  @override
  String get partiallyMedium => 'Partially Medium';

  @override
  String get completelyMedium => 'Completely Medium';

  @override
  String get notMedium => 'Not Medium';

  @override
  String get semiHigh => 'Semi-High';

  @override
  String get fullyHigh => 'Fully High';

  @override
  String get partiallyHigh => 'Partially High';

  @override
  String get completelyHigh => 'Completely High';

  @override
  String get notHigh => 'Not High';

  @override
  String get semiCritical => 'Semi-Critical';

  @override
  String get fullyCritical => 'Fully Critical';

  @override
  String get partiallyCritical => 'Partially Critical';

  @override
  String get completelyCritical => 'Completely Critical';

  @override
  String get notCritical => 'Not Critical';

  @override
  String get semiFatal => 'Semi-Fatal';

  @override
  String get fullyFatal => 'Fully Fatal';

  @override
  String get partiallyFatal => 'Partially Fatal';

  @override
  String get completelyFatal => 'Completely Fatal';

  @override
  String get notFatal => 'Not Fatal';

  @override
  String get semiTrace => 'Semi-Trace';

  @override
  String get fullyTrace => 'Fully Trace';

  @override
  String get partiallyTrace => 'Partially Trace';

  @override
  String get completelyTrace => 'Completely Trace';

  @override
  String get notTrace => 'Not Trace';

  @override
  String get semiDebug => 'Semi-Debug';

  @override
  String get fullyDebug => 'Fully Debug';

  @override
  String get partiallyDebug => 'Partially Debug';

  @override
  String get completelyDebug => 'Completely Debug';

  @override
  String get notDebug => 'Not Debug';

  @override
  String get semiInfo => 'Semi-Info';

  @override
  String get fullyInfo => 'Fully Info';

  @override
  String get partiallyInfo => 'Partially Info';

  @override
  String get completelyInfo => 'Completely Info';

  @override
  String get notInfo => 'Not Info';

  @override
  String get semiWarning => 'Semi-Warning';

  @override
  String get fullyWarning => 'Fully Warning';

  @override
  String get partiallyWarning => 'Partially Warning';

  @override
  String get completelyWarning => 'Completely Warning';

  @override
  String get notWarning => 'Not Warning';

  @override
  String get semiError => 'Semi-Error';

  @override
  String get fullyError => 'Fully Error';

  @override
  String get partiallyError => 'Partially Error';

  @override
  String get completelyError => 'Completely Error';

  @override
  String get notError => 'Not Error';

  @override
  String get semiFailed => 'Semi-Failed';

  @override
  String get fullyFailed => 'Fully Failed';

  @override
  String get partiallyFailed => 'Partially Failed';

  @override
  String get completelyFailed => 'Completely Failed';

  @override
  String get notFailed => 'Not Failed';

  @override
  String get semiSuccessful => 'Semi-Successful';

  @override
  String get fullySuccessful => 'Fully Successful';

  @override
  String get partiallySuccessful => 'Partially Successful';

  @override
  String get completelySuccessful => 'Completely Successful';

  @override
  String get notSuccessful => 'Not Successful';

  @override
  String get semiInvalid => 'Semi-Invalid';

  @override
  String get fullyInvalid => 'Fully Invalid';

  @override
  String get partiallyInvalid => 'Partially Invalid';

  @override
  String get completelyInvalid => 'Completely Invalid';

  @override
  String get notInvalid => 'Not Invalid';

  @override
  String get semiValid => 'Semi-Valid';

  @override
  String get fullyValid => 'Fully Valid';

  @override
  String get partiallyValid => 'Partially Valid';

  @override
  String get completelyValid => 'Completely Valid';

  @override
  String get notValid => 'Not Valid';

  @override
  String get semiUnverified => 'Semi-Unverified';

  @override
  String get fullyUnverified => 'Fully Unverified';

  @override
  String get partiallyUnverified => 'Partially Unverified';

  @override
  String get completelyUnverified => 'Completely Unverified';

  @override
  String get notUnverified => 'Not Unverified';

  @override
  String get semiVerified => 'Semi-Verified';

  @override
  String get fullyVerified => 'Fully Verified';

  @override
  String get partiallyVerified => 'Partially Verified';

  @override
  String get completelyVerified => 'Completely Verified';

  @override
  String get notVerified => 'Not Verified';

  @override
  String get semiUnlocked => 'Semi-Unlocked';

  @override
  String get fullyUnlocked => 'Fully Unlocked';

  @override
  String get partiallyUnlocked => 'Partially Unlocked';

  @override
  String get completelyUnlocked => 'Completely Unlocked';

  @override
  String get notUnlocked => 'Not Unlocked';

  @override
  String get semiLocked => 'Semi-Locked';

  @override
  String get fullyLocked => 'Fully Locked';

  @override
  String get partiallyLocked => 'Partially Locked';

  @override
  String get completelyLocked => 'Completely Locked';

  @override
  String get notLocked => 'Not Locked';

  @override
  String get semiUnshared => 'Semi-Unshared';

  @override
  String get fullyUnshared => 'Fully Unshared';

  @override
  String get partiallyUnshared => 'Partially Unshared';

  @override
  String get completelyUnshared => 'Completely Unshared';

  @override
  String get notUnshared => 'Not Unshared';

  @override
  String get semiShared => 'Semi-Shared';

  @override
  String get fullyShared => 'Fully Shared';

  @override
  String get partiallyShared => 'Partially Shared';

  @override
  String get completelyShared => 'Completely Shared';

  @override
  String get notShared => 'Not Shared';

  @override
  String get semiCopied => 'Semi-Copied';

  @override
  String get fullyCopied => 'Fully Copied';

  @override
  String get partiallyCopied => 'Partially Copied';

  @override
  String get completelyCopied => 'Completely Copied';

  @override
  String get notCopied => 'Not Copied';

  @override
  String get semiMoved => 'Semi-Moved';

  @override
  String get fullyMoved => 'Fully Moved';

  @override
  String get partiallyMoved => 'Partially Moved';

  @override
  String get completelyMoved => 'Completely Moved';

  @override
  String get notMoved => 'Not Moved';

  @override
  String get semiRestored => 'Semi-Restored';

  @override
  String get fullyRestored => 'Fully Restored';

  @override
  String get partiallyRestored => 'Partially Restored';

  @override
  String get completelyRestored => 'Completely Restored';

  @override
  String get notRestored => 'Not Restored';

  @override
  String get semiDeleted => 'Semi-Deleted';

  @override
  String get fullyDeleted => 'Fully Deleted';

  @override
  String get partiallyDeleted => 'Partially Deleted';

  @override
  String get completelyDeleted => 'Completely Deleted';

  @override
  String get notDeleted => 'Not Deleted';

  @override
  String get semiArchived => 'Semi-Archived';

  @override
  String get fullyArchived => 'Fully Archived';

  @override
  String get partiallyArchived => 'Partially Archived';

  @override
  String get completelyArchived => 'Completely Archived';

  @override
  String get notArchived => 'Not Archived';

  @override
  String get semiPublished => 'Semi-Published';

  @override
  String get fullyPublished => 'Fully Published';

  @override
  String get partiallyPublished => 'Partially Published';

  @override
  String get completelyPublished => 'Completely Published';

  @override
  String get notPublished => 'Not Published';

  @override
  String get semiDraft => 'Semi-Draft';

  @override
  String get fullyDraft => 'Fully Draft';

  @override
  String get partiallyDraft => 'Partially Draft';

  @override
  String get completelyDraft => 'Completely Draft';

  @override
  String get notDraft => 'Not Draft';

  @override
  String get semiPrivate => 'Semi-Private';

  @override
  String get fullyPrivate => 'Fully Private';

  @override
  String get partiallyPrivate => 'Partially Private';

  @override
  String get completelyPrivate => 'Completely Private';

  @override
  String get notPrivate => 'Not Private';

  @override
  String get semiPublic => 'Semi-Public';

  @override
  String get fullyPublic => 'Fully Public';

  @override
  String get partiallyPublic => 'Partially Public';

  @override
  String get completelyPublic => 'Completely Public';

  @override
  String get notPublic => 'Not Public';

  @override
  String get semiHidden => 'Semi-Hidden';

  @override
  String get fullyHidden => 'Fully Hidden';

  @override
  String get partiallyHidden => 'Partially Hidden';

  @override
  String get completelyHidden => 'Completely Hidden';

  @override
  String get notHidden => 'Not Hidden';

  @override
  String get semiVisible => 'Semi-Visible';

  @override
  String get fullyVisible => 'Fully Visible';

  @override
  String get partiallyVisible => 'Partially Visible';

  @override
  String get completelyVisible => 'Completely Visible';

  @override
  String get notVisible => 'Not Visible';

  @override
  String get semiDisabled => 'Semi-Disabled';

  @override
  String get fullyDisabled => 'Fully Disabled';

  @override
  String get partiallyDisabled => 'Partially Disabled';

  @override
  String get completelyDisabled => 'Completely Disabled';

  @override
  String get notDisabled => 'Not Disabled';

  @override
  String get semiEnabled => 'Semi-Enabled';

  @override
  String get fullyEnabled => 'Fully Enabled';

  @override
  String get partiallyEnabled => 'Partially Enabled';

  @override
  String get completelyEnabled => 'Completely Enabled';

  @override
  String get notEnabled => 'Not Enabled';

  @override
  String get semiInactive => 'Semi-Inactive';

  @override
  String get fullyInactive => 'Fully Inactive';

  @override
  String get partiallyInactive => 'Partially Inactive';

  @override
  String get completelyInactive => 'Completely Inactive';

  @override
  String get notInactive => 'Not Inactive';

  @override
  String get semiActive => 'Semi-Active';

  @override
  String get fullyActive => 'Fully Active';

  @override
  String get partiallyActive => 'Partially Active';

  @override
  String get completelyActive => 'Completely Active';

  @override
  String get notActive => 'Not Active';

  @override
  String get semiExpired => 'Semi-Expired';

  @override
  String get fullyExpired => 'Fully Expired';

  @override
  String get partiallyExpired => 'Partially Expired';

  @override
  String get completelyExpired => 'Completely Expired';

  @override
  String get notExpired => 'Not Expired';

  @override
  String get semiCancelled => 'Semi-Cancelled';

  @override
  String get fullyCancelled => 'Fully Cancelled';

  @override
  String get partiallyCancelled => 'Partially Cancelled';

  @override
  String get completelyCancelled => 'Completely Cancelled';

  @override
  String get notCancelled => 'Not Cancelled';

  @override
  String get semiScheduled => 'Semi-Scheduled';

  @override
  String get fullyScheduled => 'Fully Scheduled';

  @override
  String get partiallyScheduled => 'Partially Scheduled';

  @override
  String get completelyScheduled => 'Completely Scheduled';

  @override
  String get notScheduled => 'Not Scheduled';

  @override
  String get semiInProgress => 'Semi-In Progress';

  @override
  String get fullyInProgress => 'Fully In Progress';

  @override
  String get partiallyInProgress => 'Partially In Progress';

  @override
  String get completelyInProgress => 'Completely In Progress';

  @override
  String get notInProgress => 'Not In Progress';

  @override
  String get semiCompleted => 'Semi-Completed';

  @override
  String get fullyCompleted => 'Fully Completed';

  @override
  String get partiallyCompleted => 'Partially Completed';

  @override
  String get completelyCompleted => 'Completely Completed';

  @override
  String get notCompleted => 'Not Completed';

  @override
  String get semiRejected => 'Semi-Rejected';

  @override
  String get fullyRejected => 'Fully Rejected';

  @override
  String get partiallyRejected => 'Partially Rejected';

  @override
  String get completelyRejected => 'Completely Rejected';

  @override
  String get notRejected => 'Not Rejected';

  @override
  String get semiApproved => 'Semi-Approved';

  @override
  String get fullyApproved => 'Fully Approved';

  @override
  String get partiallyApproved => 'Partially Approved';

  @override
  String get completelyApproved => 'Completely Approved';

  @override
  String get notApproved => 'Not Approved';

  @override
  String get semiDecline => 'Semi-Decline';

  @override
  String get fullyDecline => 'Fully Decline';

  @override
  String get partiallyDecline => 'Partially Decline';

  @override
  String get completelyDecline => 'Completely Decline';

  @override
  String get notDecline => 'Not Decline';

  @override
  String get semiAccept => 'Semi-Accept';

  @override
  String get fullyAccept => 'Fully Accept';

  @override
  String get partiallyAccept => 'Partially Accept';

  @override
  String get completelyAccept => 'Completely Accept';

  @override
  String get notAccept => 'Not Accept';

  @override
  String get semiConfirm => 'Semi-Confirm';

  @override
  String get fullyConfirm => 'Fully Confirm';

  @override
  String get partiallyConfirm => 'Partially Confirm';

  @override
  String get completelyConfirm => 'Completely Confirm';

  @override
  String get notConfirm => 'Not Confirm';

  @override
  String get semiCancel => 'Semi-Cancel';

  @override
  String get fullyCancel => 'Fully Cancel';

  @override
  String get partiallyCancel => 'Partially Cancel';

  @override
  String get completelyCancel => 'Completely Cancel';

  @override
  String get notCancel => 'Not Cancel';

  @override
  String get semiAbort => 'Semi-Abort';

  @override
  String get fullyAbort => 'Fully Abort';

  @override
  String get partiallyAbort => 'Partially Abort';

  @override
  String get completelyAbort => 'Completely Abort';

  @override
  String get notAbort => 'Not Abort';

  @override
  String get semiRetry => 'Semi-Retry';

  @override
  String get fullyRetry => 'Fully Retry';

  @override
  String get partiallyRetry => 'Partially Retry';

  @override
  String get completelyRetry => 'Completely Retry';

  @override
  String get notRetry => 'Not Retry';

  @override
  String get semiResume => 'Semi-Resume';

  @override
  String get fullyResume => 'Fully Resume';

  @override
  String get partiallyResume => 'Partially Resume';

  @override
  String get completelyResume => 'Completely Resume';

  @override
  String get notResume => 'Not Resume';

  @override
  String get semiPause => 'Semi-Pause';

  @override
  String get fullyPause => 'Fully Pause';

  @override
  String get partiallyPause => 'Partially Pause';

  @override
  String get completelyPause => 'Completely Pause';

  @override
  String get notPause => 'Not Pause';

  @override
  String get semiStop => 'Semi-Stop';

  @override
  String get fullyStop => 'Fully Stop';

  @override
  String get partiallyStop => 'Partially Stop';

  @override
  String get completelyStop => 'Completely Stop';

  @override
  String get notStop => 'Not Stop';

  @override
  String get semiStart => 'Semi-Start';

  @override
  String get fullyStart => 'Fully Start';

  @override
  String get partiallyStart => 'Partially Start';

  @override
  String get completelyStart => 'Completely Start';

  @override
  String get notStart => 'Not Start';

  @override
  String get semiFinish => 'Semi-Finish';

  @override
  String get fullyFinish => 'Fully Finish';

  @override
  String get partiallyFinish => 'Partially Finish';

  @override
  String get completelyFinish => 'Completely Finish';

  @override
  String get notFinish => 'Not Finish';

  @override
  String get semiContinue => 'Semi-Continue';

  @override
  String get fullyContinue => 'Fully Continue';

  @override
  String get partiallyContinue => 'Partially Continue';

  @override
  String get completelyContinue => 'Completely Continue';

  @override
  String get notContinue => 'Not Continue';

  @override
  String get semiSkip => 'Semi-Skip';

  @override
  String get fullySkip => 'Fully Skip';

  @override
  String get partiallySkip => 'Partially Skip';

  @override
  String get completelySkip => 'Completely Skip';

  @override
  String get notSkip => 'Not Skip';

  @override
  String get semiDone => 'Semi-Done';

  @override
  String get fullyDone => 'Fully Done';

  @override
  String get partiallyDone => 'Partially Done';

  @override
  String get completelyDone => 'Completely Done';

  @override
  String get notDone => 'Not Done';

  @override
  String get semiOk => 'Semi-OK';

  @override
  String get fullyOk => 'Fully OK';

  @override
  String get partiallyOk => 'Partially OK';

  @override
  String get completelyOk => 'Completely OK';

  @override
  String get notOk => 'Not OK';

  @override
  String get semiNo => 'Semi-No';

  @override
  String get fullyNo => 'Fully No';

  @override
  String get partiallyNo => 'Partially No';

  @override
  String get completelyNo => 'Completely No';

  @override
  String get notNo => 'Not No';

  @override
  String get semiYes => 'Semi-Yes';

  @override
  String get fullyYes => 'Fully Yes';

  @override
  String get partiallyYes => 'Partially Yes';

  @override
  String get completelyYes => 'Completely Yes';

  @override
  String get notYes => 'Not Yes';

  @override
  String get semiOpen => 'Semi-Open';

  @override
  String get fullyOpen => 'Fully Open';

  @override
  String get partiallyOpen => 'Partially Open';

  @override
  String get completelyOpen => 'Completely Open';

  @override
  String get notOpen => 'Not Open';

  @override
  String get semiClose => 'Semi-Close';

  @override
  String get fullyClose => 'Fully Close';

  @override
  String get partiallyClose => 'Partially Close';

  @override
  String get completelyClose => 'Completely Close';

  @override
  String get notClose => 'Not Close';

  @override
  String get semiRefresh => 'Semi-Refresh';

  @override
  String get fullyRefresh => 'Fully Refresh';

  @override
  String get partiallyRefresh => 'Partially Refresh';

  @override
  String get completelyRefresh => 'Completely Refresh';

  @override
  String get notRefresh => 'Not Refresh';

  @override
  String get semiSort => 'Semi-Sort';

  @override
  String get fullySort => 'Fully Sort';

  @override
  String get partiallySort => 'Partially Sort';

  @override
  String get completelySort => 'Completely Sort';

  @override
  String get notSort => 'Not Sort';

  @override
  String get semiFilter => 'Semi-Filter';

  @override
  String get fullyFilter => 'Fully Filter';

  @override
  String get partiallyFilter => 'Partially Filter';

  @override
  String get completelyFilter => 'Completely Filter';

  @override
  String get notFilter => 'Not Filter';

  @override
  String get semiSearch => 'Semi-Search';

  @override
  String get fullySearch => 'Fully Search';

  @override
  String get partiallySearch => 'Partially Search';

  @override
  String get completelySearch => 'Completely Search';

  @override
  String get notSearch => 'Not Search';

  @override
  String get semiReset => 'Semi-Reset';

  @override
  String get fullyReset => 'Fully Reset';

  @override
  String get partiallyReset => 'Partially Reset';

  @override
  String get completelyReset => 'Completely Reset';

  @override
  String get notReset => 'Not Reset';

  @override
  String get semiSubmit => 'Semi-Submit';

  @override
  String get fullySubmit => 'Fully Submit';

  @override
  String get partiallySubmit => 'Partially Submit';

  @override
  String get completelySubmit => 'Completely Submit';

  @override
  String get notSubmit => 'Not Submit';

  @override
  String get semiPrevious => 'Semi-Previous';

  @override
  String get fullyPrevious => 'Fully Previous';

  @override
  String get partiallyPrevious => 'Partially Previous';

  @override
  String get completelyPrevious => 'Completely Previous';

  @override
  String get notPrevious => 'Not Previous';

  @override
  String get semiNext => 'Semi-Next';

  @override
  String get fullyNext => 'Fully Next';

  @override
  String get partiallyNext => 'Partially Next';

  @override
  String get completelyNext => 'Completely Next';

  @override
  String get notNext => 'Not Next';

  @override
  String get semiBack => 'Semi-Back';

  @override
  String get fullyBack => 'Fully Back';

  @override
  String get partiallyBack => 'Partially Back';

  @override
  String get completelyBack => 'Completely Back';

  @override
  String get notBack => 'Not Back';

  @override
  String get semiUpdate => 'Semi-Update';

  @override
  String get fullyUpdate => 'Fully Update';

  @override
  String get partiallyUpdate => 'Partially Update';

  @override
  String get completelyUpdate => 'Completely Update';

  @override
  String get notUpdate => 'Not Update';

  @override
  String get semiCreate => 'Semi-Create';

  @override
  String get fullyCreate => 'Fully Create';

  @override
  String get partiallyCreate => 'Partially Create';

  @override
  String get completelyCreate => 'Completely Create';

  @override
  String get notCreate => 'Not Create';

  @override
  String get semiEdit => 'Semi-Edit';

  @override
  String get fullyEdit => 'Fully Edit';

  @override
  String get partiallyEdit => 'Partially Edit';

  @override
  String get completelyEdit => 'Completely Edit';

  @override
  String get notEdit => 'Not Edit';

  @override
  String get semiDelete => 'Semi-Delete';

  @override
  String get fullyDelete => 'Fully Delete';

  @override
  String get partiallyDelete => 'Partially Delete';

  @override
  String get completelyDelete => 'Completely Delete';

  @override
  String get notDelete => 'Not Delete';

  @override
  String get semiSaveChanges => 'Semi-Save Changes';

  @override
  String get fullySaveChanges => 'Fully Save Changes';

  @override
  String get partiallySaveChanges => 'Partially Save Changes';

  @override
  String get completelySaveChanges => 'Completely Save Changes';

  @override
  String get notSaveChanges => 'Not Save Changes';

  @override
  String get semiWelcomeToBloodDonation => 'Semi-Welcome to Blood Donation';

  @override
  String get fullyWelcomeToBloodDonation => 'Fully Welcome to Blood Donation';

  @override
  String get partiallyWelcomeToBloodDonation => 'Partially Welcome to Blood Donation';

  @override
  String get completelyWelcomeToBloodDonation => 'Completely Welcome to Blood Donation';

  @override
  String get notWelcomeToBloodDonation => 'Not Welcome to Blood Donation';

  @override
  String get bloodType => 'Groupe Sanguin';

  @override
  String get bloodGroup => 'Groupe Sanguin';

  @override
  String get donor => 'Donneur';

  @override
  String get recipient => 'Receveur';

  @override
  String get hospital => 'Hôpital';

  @override
  String get clinic => 'Clinique';

  @override
  String get medicalCenter => 'Centre Médical';

  @override
  String get healthCenter => 'Centre de Santé';

  @override
  String get emergency => 'Urgence';

  @override
  String get urgent => 'Urgent';

  @override
  String get stable => 'Stable';

  @override
  String get unstable => 'Instable';

  @override
  String get healthy => 'En bonne santé';

  @override
  String get sick => 'Malade';

  @override
  String get recovered => 'Rétabli';

  @override
  String get healing => 'Guérison';

  @override
  String get treatment => 'Traitement';

  @override
  String get medication => 'Médicament';

  @override
  String get prescription => 'Ordonnance';

  @override
  String get diagnosis => 'Diagnostic';

  @override
  String get symptoms => 'Symptômes';

  @override
  String get condition => 'État';

  @override
  String get disease => 'Maladie';

  @override
  String get infection => 'Infection';

  @override
  String get injury => 'Blessure';

  @override
  String get wound => 'Plaie';

  @override
  String get pain => 'Douleur';

  @override
  String get fever => 'Fièvre';

  @override
  String get temperature => 'Température';

  @override
  String get pressure => 'Pression';

  @override
  String get heartRate => 'Fréquence Cardiaque';

  @override
  String get bloodPressure => 'Pression Artérielle';

  @override
  String get weight => 'Poids';

  @override
  String get height => 'Taille';

  @override
  String get age => 'Âge';

  @override
  String get gender => 'Genre';

  @override
  String get male => 'Masculin';

  @override
  String get female => 'Féminin';

  @override
  String get contact => 'Contact';

  @override
  String get address => 'Adresse';

  @override
  String get city => 'Ville';

  @override
  String get country => 'Pays';

  @override
  String get postalCode => 'Code Postal';

  @override
  String get phone => 'Téléphone';

  @override
  String get mobile => 'Mobile';

  @override
  String get landline => 'Ligne Fixe';

  @override
  String get emergencyContact => 'Contact d\'Urgence';

  @override
  String get relationship => 'Relation';

  @override
  String get spouse => 'Conjoint';

  @override
  String get parent => 'Parent';

  @override
  String get child => 'Enfant';

  @override
  String get sibling => 'Frère/Sœur';

  @override
  String get friend => 'Ami';

  @override
  String get colleague => 'Collègue';

  @override
  String get neighbor => 'Voisin';
}
