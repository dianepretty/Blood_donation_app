import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_rw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('rw')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Blood Donation App'**
  String get appTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @lastChanged.
  ///
  /// In en, this message translates to:
  /// **'Last changed {days} days ago'**
  String lastChanged(int days);

  /// No description provided for @twoFactorAuth.
  ///
  /// In en, this message translates to:
  /// **'Two-factor authentication'**
  String get twoFactorAuth;

  /// No description provided for @recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get recommended;

  /// No description provided for @appInformation.
  ///
  /// In en, this message translates to:
  /// **'App Information'**
  String get appInformation;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated'**
  String get lastUpdated;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @privacyPolicyDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn how we handle your data.'**
  String get privacyPolicyDesc;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get termsOfService;

  /// No description provided for @termsOfServiceDesc.
  ///
  /// In en, this message translates to:
  /// **'Review our service agreement.'**
  String get termsOfServiceDesc;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @events.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get events;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @donationHistory.
  ///
  /// In en, this message translates to:
  /// **'Donation History'**
  String get donationHistory;

  /// No description provided for @createEvent.
  ///
  /// In en, this message translates to:
  /// **'Create Event'**
  String get createEvent;

  /// No description provided for @editEvent.
  ///
  /// In en, this message translates to:
  /// **'Edit Event'**
  String get editEvent;

  /// No description provided for @viewEvent.
  ///
  /// In en, this message translates to:
  /// **'View Event'**
  String get viewEvent;

  /// No description provided for @eventName.
  ///
  /// In en, this message translates to:
  /// **'Event Name'**
  String get eventName;

  /// No description provided for @eventLocation.
  ///
  /// In en, this message translates to:
  /// **'Event Location'**
  String get eventLocation;

  /// No description provided for @eventDate.
  ///
  /// In en, this message translates to:
  /// **'Event Date'**
  String get eventDate;

  /// No description provided for @eventTime.
  ///
  /// In en, this message translates to:
  /// **'Event Time'**
  String get eventTime;

  /// No description provided for @eventDescription.
  ///
  /// In en, this message translates to:
  /// **'Event Description'**
  String get eventDescription;

  /// No description provided for @eventStatus.
  ///
  /// In en, this message translates to:
  /// **'Event Status'**
  String get eventStatus;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @bookAppointment.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get bookAppointment;

  /// No description provided for @appointmentDate.
  ///
  /// In en, this message translates to:
  /// **'Appointment Date'**
  String get appointmentDate;

  /// No description provided for @appointmentTime.
  ///
  /// In en, this message translates to:
  /// **'Appointment Time'**
  String get appointmentTime;

  /// No description provided for @appointmentType.
  ///
  /// In en, this message translates to:
  /// **'Appointment Type'**
  String get appointmentType;

  /// No description provided for @bloodDonation.
  ///
  /// In en, this message translates to:
  /// **'Blood Donation'**
  String get bloodDonation;

  /// No description provided for @consultation.
  ///
  /// In en, this message translates to:
  /// **'Consultation'**
  String get consultation;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get district;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @volunteer.
  ///
  /// In en, this message translates to:
  /// **'Volunteer'**
  String get volunteer;

  /// No description provided for @hospitalAdmin.
  ///
  /// In en, this message translates to:
  /// **'Hospital Admin'**
  String get hospitalAdmin;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @upcomingEvents.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Events'**
  String get upcomingEvents;

  /// No description provided for @pendingAppointments.
  ///
  /// In en, this message translates to:
  /// **'Pending Appointment Requests'**
  String get pendingAppointments;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Notifications coming soon!'**
  String get notificationsComingSoon;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get userName;

  /// No description provided for @userEmail.
  ///
  /// In en, this message translates to:
  /// **'user@example.com'**
  String get userEmail;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @kinyarwanda.
  ///
  /// In en, this message translates to:
  /// **'Kinyarwanda'**
  String get kinyarwanda;

  /// No description provided for @languageChanged.
  ///
  /// In en, this message translates to:
  /// **'Language changed successfully'**
  String get languageChanged;

  /// No description provided for @pleaseLogin.
  ///
  /// In en, this message translates to:
  /// **'Please log in to view events'**
  String get pleaseLogin;

  /// No description provided for @noEvents.
  ///
  /// In en, this message translates to:
  /// **'No events found'**
  String get noEvents;

  /// No description provided for @noAppointments.
  ///
  /// In en, this message translates to:
  /// **'No appointments found'**
  String get noAppointments;

  /// No description provided for @createNewEvent.
  ///
  /// In en, this message translates to:
  /// **'Create New Event'**
  String get createNewEvent;

  /// No description provided for @editEventDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit Event Details'**
  String get editEventDetails;

  /// No description provided for @eventCreated.
  ///
  /// In en, this message translates to:
  /// **'Event created successfully!'**
  String get eventCreated;

  /// No description provided for @eventUpdated.
  ///
  /// In en, this message translates to:
  /// **'Event updated successfully!'**
  String get eventUpdated;

  /// No description provided for @eventDeleted.
  ///
  /// In en, this message translates to:
  /// **'Event deleted successfully!'**
  String get eventDeleted;

  /// No description provided for @failedToCreateEvent.
  ///
  /// In en, this message translates to:
  /// **'Failed to create event. Please try again.'**
  String get failedToCreateEvent;

  /// No description provided for @failedToUpdateEvent.
  ///
  /// In en, this message translates to:
  /// **'Failed to update event. Please try again.'**
  String get failedToUpdateEvent;

  /// No description provided for @failedToDeleteEvent.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete event. Please try again.'**
  String get failedToDeleteEvent;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @enterEventName.
  ///
  /// In en, this message translates to:
  /// **'Enter event name'**
  String get enterEventName;

  /// No description provided for @enterLocation.
  ///
  /// In en, this message translates to:
  /// **'Enter location'**
  String get enterLocation;

  /// No description provided for @enterDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter event description'**
  String get enterDescription;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @fromTime.
  ///
  /// In en, this message translates to:
  /// **'From Time'**
  String get fromTime;

  /// No description provided for @toTime.
  ///
  /// In en, this message translates to:
  /// **'To Time'**
  String get toTime;

  /// No description provided for @invalidTime.
  ///
  /// In en, this message translates to:
  /// **'End time must be after start time'**
  String get invalidTime;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @welcomeToBloodDonation.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Blood Donation'**
  String get welcomeToBloodDonation;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @finishAction.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finishAction;

  /// No description provided for @startAction.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get startAction;

  /// No description provided for @stopAction.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stopAction;

  /// No description provided for @pauseAction.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pauseAction;

  /// No description provided for @resumeAction.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resumeAction;

  /// No description provided for @retryAction.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryAction;

  /// No description provided for @abortAction.
  ///
  /// In en, this message translates to:
  /// **'Abort'**
  String get abortAction;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @disabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// No description provided for @visible.
  ///
  /// In en, this message translates to:
  /// **'Visible'**
  String get visible;

  /// No description provided for @hidden.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get hidden;

  /// No description provided for @public.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get public;

  /// No description provided for @private.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get private;

  /// No description provided for @draft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get draft;

  /// No description provided for @published.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get published;

  /// No description provided for @archived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get archived;

  /// No description provided for @deleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get deleted;

  /// No description provided for @restored.
  ///
  /// In en, this message translates to:
  /// **'Restored'**
  String get restored;

  /// No description provided for @moved.
  ///
  /// In en, this message translates to:
  /// **'Moved'**
  String get moved;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @shared.
  ///
  /// In en, this message translates to:
  /// **'Shared'**
  String get shared;

  /// No description provided for @unshared.
  ///
  /// In en, this message translates to:
  /// **'Unshared'**
  String get unshared;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get locked;

  /// No description provided for @unlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get unlocked;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @unverified.
  ///
  /// In en, this message translates to:
  /// **'Unverified'**
  String get unverified;

  /// No description provided for @valid.
  ///
  /// In en, this message translates to:
  /// **'Valid'**
  String get valid;

  /// No description provided for @invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid'**
  String get invalid;

  /// No description provided for @successful.
  ///
  /// In en, this message translates to:
  /// **'Successful'**
  String get successful;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get info;

  /// No description provided for @debug.
  ///
  /// In en, this message translates to:
  /// **'Debug'**
  String get debug;

  /// No description provided for @trace.
  ///
  /// In en, this message translates to:
  /// **'Trace'**
  String get trace;

  /// No description provided for @fatal.
  ///
  /// In en, this message translates to:
  /// **'Fatal'**
  String get fatal;

  /// No description provided for @critical.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get critical;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @some.
  ///
  /// In en, this message translates to:
  /// **'Some'**
  String get some;

  /// No description provided for @few.
  ///
  /// In en, this message translates to:
  /// **'Few'**
  String get few;

  /// No description provided for @many.
  ///
  /// In en, this message translates to:
  /// **'Many'**
  String get many;

  /// No description provided for @most.
  ///
  /// In en, this message translates to:
  /// **'Most'**
  String get most;

  /// No description provided for @least.
  ///
  /// In en, this message translates to:
  /// **'Least'**
  String get least;

  /// No description provided for @best.
  ///
  /// In en, this message translates to:
  /// **'Best'**
  String get best;

  /// No description provided for @worst.
  ///
  /// In en, this message translates to:
  /// **'Worst'**
  String get worst;

  /// No description provided for @better.
  ///
  /// In en, this message translates to:
  /// **'Better'**
  String get better;

  /// No description provided for @worse.
  ///
  /// In en, this message translates to:
  /// **'Worse'**
  String get worse;

  /// No description provided for @same.
  ///
  /// In en, this message translates to:
  /// **'Same'**
  String get same;

  /// No description provided for @different.
  ///
  /// In en, this message translates to:
  /// **'Different'**
  String get different;

  /// No description provided for @similar.
  ///
  /// In en, this message translates to:
  /// **'Similar'**
  String get similar;

  /// No description provided for @unique.
  ///
  /// In en, this message translates to:
  /// **'Unique'**
  String get unique;

  /// No description provided for @common.
  ///
  /// In en, this message translates to:
  /// **'Common'**
  String get common;

  /// No description provided for @rare.
  ///
  /// In en, this message translates to:
  /// **'Rare'**
  String get rare;

  /// No description provided for @frequent.
  ///
  /// In en, this message translates to:
  /// **'Frequent'**
  String get frequent;

  /// No description provided for @occasional.
  ///
  /// In en, this message translates to:
  /// **'Occasional'**
  String get occasional;

  /// No description provided for @regular.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get regular;

  /// No description provided for @irregular.
  ///
  /// In en, this message translates to:
  /// **'Irregular'**
  String get irregular;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// No description provided for @abnormal.
  ///
  /// In en, this message translates to:
  /// **'Abnormal'**
  String get abnormal;

  /// No description provided for @standardType.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get standardType;

  /// No description provided for @customType.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get customType;

  /// No description provided for @defaultValue.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultValue;

  /// No description provided for @automaticMode.
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get automaticMode;

  /// No description provided for @manualMode.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get manualMode;

  /// No description provided for @automatic.
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get automatic;

  /// No description provided for @semiAutomatic.
  ///
  /// In en, this message translates to:
  /// **'Semi-Automatic'**
  String get semiAutomatic;

  /// No description provided for @fullyAutomatic.
  ///
  /// In en, this message translates to:
  /// **'Fully Automatic'**
  String get fullyAutomatic;

  /// No description provided for @partiallyAutomatic.
  ///
  /// In en, this message translates to:
  /// **'Partially Automatic'**
  String get partiallyAutomatic;

  /// No description provided for @completelyAutomatic.
  ///
  /// In en, this message translates to:
  /// **'Completely Automatic'**
  String get completelyAutomatic;

  /// No description provided for @notAutomatic.
  ///
  /// In en, this message translates to:
  /// **'Not Automatic'**
  String get notAutomatic;

  /// No description provided for @semiManual.
  ///
  /// In en, this message translates to:
  /// **'Semi-Manual'**
  String get semiManual;

  /// No description provided for @fullyManual.
  ///
  /// In en, this message translates to:
  /// **'Fully Manual'**
  String get fullyManual;

  /// No description provided for @partiallyManual.
  ///
  /// In en, this message translates to:
  /// **'Partially Manual'**
  String get partiallyManual;

  /// No description provided for @completelyManual.
  ///
  /// In en, this message translates to:
  /// **'Completely Manual'**
  String get completelyManual;

  /// No description provided for @notManual.
  ///
  /// In en, this message translates to:
  /// **'Not Manual'**
  String get notManual;

  /// No description provided for @semiCustom.
  ///
  /// In en, this message translates to:
  /// **'Semi-Custom'**
  String get semiCustom;

  /// No description provided for @fullyCustom.
  ///
  /// In en, this message translates to:
  /// **'Fully Custom'**
  String get fullyCustom;

  /// No description provided for @partiallyCustom.
  ///
  /// In en, this message translates to:
  /// **'Partially Custom'**
  String get partiallyCustom;

  /// No description provided for @completelyCustom.
  ///
  /// In en, this message translates to:
  /// **'Completely Custom'**
  String get completelyCustom;

  /// No description provided for @notCustom.
  ///
  /// In en, this message translates to:
  /// **'Not Custom'**
  String get notCustom;

  /// No description provided for @semiStandard.
  ///
  /// In en, this message translates to:
  /// **'Semi-Standard'**
  String get semiStandard;

  /// No description provided for @fullyStandard.
  ///
  /// In en, this message translates to:
  /// **'Fully Standard'**
  String get fullyStandard;

  /// No description provided for @partiallyStandard.
  ///
  /// In en, this message translates to:
  /// **'Partially Standard'**
  String get partiallyStandard;

  /// No description provided for @completelyStandard.
  ///
  /// In en, this message translates to:
  /// **'Completely Standard'**
  String get completelyStandard;

  /// No description provided for @notStandard.
  ///
  /// In en, this message translates to:
  /// **'Not Standard'**
  String get notStandard;

  /// No description provided for @semiDefault.
  ///
  /// In en, this message translates to:
  /// **'Semi-Default'**
  String get semiDefault;

  /// No description provided for @fullyDefault.
  ///
  /// In en, this message translates to:
  /// **'Fully Default'**
  String get fullyDefault;

  /// No description provided for @partiallyDefault.
  ///
  /// In en, this message translates to:
  /// **'Partially Default'**
  String get partiallyDefault;

  /// No description provided for @completelyDefault.
  ///
  /// In en, this message translates to:
  /// **'Completely Default'**
  String get completelyDefault;

  /// No description provided for @notDefault.
  ///
  /// In en, this message translates to:
  /// **'Not Default'**
  String get notDefault;

  /// No description provided for @semiNormal.
  ///
  /// In en, this message translates to:
  /// **'Semi-Normal'**
  String get semiNormal;

  /// No description provided for @fullyNormal.
  ///
  /// In en, this message translates to:
  /// **'Fully Normal'**
  String get fullyNormal;

  /// No description provided for @partiallyNormal.
  ///
  /// In en, this message translates to:
  /// **'Partially Normal'**
  String get partiallyNormal;

  /// No description provided for @completelyNormal.
  ///
  /// In en, this message translates to:
  /// **'Completely Normal'**
  String get completelyNormal;

  /// No description provided for @notNormal.
  ///
  /// In en, this message translates to:
  /// **'Not Normal'**
  String get notNormal;

  /// No description provided for @semiAbnormal.
  ///
  /// In en, this message translates to:
  /// **'Semi-Abnormal'**
  String get semiAbnormal;

  /// No description provided for @fullyAbnormal.
  ///
  /// In en, this message translates to:
  /// **'Fully Abnormal'**
  String get fullyAbnormal;

  /// No description provided for @partiallyAbnormal.
  ///
  /// In en, this message translates to:
  /// **'Partially Abnormal'**
  String get partiallyAbnormal;

  /// No description provided for @completelyAbnormal.
  ///
  /// In en, this message translates to:
  /// **'Completely Abnormal'**
  String get completelyAbnormal;

  /// No description provided for @notAbnormal.
  ///
  /// In en, this message translates to:
  /// **'Not Abnormal'**
  String get notAbnormal;

  /// No description provided for @semiRegular.
  ///
  /// In en, this message translates to:
  /// **'Semi-Regular'**
  String get semiRegular;

  /// No description provided for @fullyRegular.
  ///
  /// In en, this message translates to:
  /// **'Fully Regular'**
  String get fullyRegular;

  /// No description provided for @partiallyRegular.
  ///
  /// In en, this message translates to:
  /// **'Partially Regular'**
  String get partiallyRegular;

  /// No description provided for @completelyRegular.
  ///
  /// In en, this message translates to:
  /// **'Completely Regular'**
  String get completelyRegular;

  /// No description provided for @notRegular.
  ///
  /// In en, this message translates to:
  /// **'Not Regular'**
  String get notRegular;

  /// No description provided for @semiIrregular.
  ///
  /// In en, this message translates to:
  /// **'Semi-Irregular'**
  String get semiIrregular;

  /// No description provided for @fullyIrregular.
  ///
  /// In en, this message translates to:
  /// **'Fully Irregular'**
  String get fullyIrregular;

  /// No description provided for @partiallyIrregular.
  ///
  /// In en, this message translates to:
  /// **'Partially Irregular'**
  String get partiallyIrregular;

  /// No description provided for @completelyIrregular.
  ///
  /// In en, this message translates to:
  /// **'Completely Irregular'**
  String get completelyIrregular;

  /// No description provided for @notIrregular.
  ///
  /// In en, this message translates to:
  /// **'Not Irregular'**
  String get notIrregular;

  /// No description provided for @semiFrequent.
  ///
  /// In en, this message translates to:
  /// **'Semi-Frequent'**
  String get semiFrequent;

  /// No description provided for @fullyFrequent.
  ///
  /// In en, this message translates to:
  /// **'Fully Frequent'**
  String get fullyFrequent;

  /// No description provided for @partiallyFrequent.
  ///
  /// In en, this message translates to:
  /// **'Partially Frequent'**
  String get partiallyFrequent;

  /// No description provided for @completelyFrequent.
  ///
  /// In en, this message translates to:
  /// **'Completely Frequent'**
  String get completelyFrequent;

  /// No description provided for @notFrequent.
  ///
  /// In en, this message translates to:
  /// **'Not Frequent'**
  String get notFrequent;

  /// No description provided for @semiOccasional.
  ///
  /// In en, this message translates to:
  /// **'Semi-Occasional'**
  String get semiOccasional;

  /// No description provided for @fullyOccasional.
  ///
  /// In en, this message translates to:
  /// **'Fully Occasional'**
  String get fullyOccasional;

  /// No description provided for @partiallyOccasional.
  ///
  /// In en, this message translates to:
  /// **'Partially Occasional'**
  String get partiallyOccasional;

  /// No description provided for @completelyOccasional.
  ///
  /// In en, this message translates to:
  /// **'Completely Occasional'**
  String get completelyOccasional;

  /// No description provided for @notOccasional.
  ///
  /// In en, this message translates to:
  /// **'Not Occasional'**
  String get notOccasional;

  /// No description provided for @semiRare.
  ///
  /// In en, this message translates to:
  /// **'Semi-Rare'**
  String get semiRare;

  /// No description provided for @fullyRare.
  ///
  /// In en, this message translates to:
  /// **'Fully Rare'**
  String get fullyRare;

  /// No description provided for @partiallyRare.
  ///
  /// In en, this message translates to:
  /// **'Partially Rare'**
  String get partiallyRare;

  /// No description provided for @completelyRare.
  ///
  /// In en, this message translates to:
  /// **'Completely Rare'**
  String get completelyRare;

  /// No description provided for @notRare.
  ///
  /// In en, this message translates to:
  /// **'Not Rare'**
  String get notRare;

  /// No description provided for @semiCommon.
  ///
  /// In en, this message translates to:
  /// **'Semi-Common'**
  String get semiCommon;

  /// No description provided for @fullyCommon.
  ///
  /// In en, this message translates to:
  /// **'Fully Common'**
  String get fullyCommon;

  /// No description provided for @partiallyCommon.
  ///
  /// In en, this message translates to:
  /// **'Partially Common'**
  String get partiallyCommon;

  /// No description provided for @completelyCommon.
  ///
  /// In en, this message translates to:
  /// **'Completely Common'**
  String get completelyCommon;

  /// No description provided for @notCommon.
  ///
  /// In en, this message translates to:
  /// **'Not Common'**
  String get notCommon;

  /// No description provided for @semiUnique.
  ///
  /// In en, this message translates to:
  /// **'Semi-Unique'**
  String get semiUnique;

  /// No description provided for @fullyUnique.
  ///
  /// In en, this message translates to:
  /// **'Fully Unique'**
  String get fullyUnique;

  /// No description provided for @partiallyUnique.
  ///
  /// In en, this message translates to:
  /// **'Partially Unique'**
  String get partiallyUnique;

  /// No description provided for @completelyUnique.
  ///
  /// In en, this message translates to:
  /// **'Completely Unique'**
  String get completelyUnique;

  /// No description provided for @notUnique.
  ///
  /// In en, this message translates to:
  /// **'Not Unique'**
  String get notUnique;

  /// No description provided for @semiSimilar.
  ///
  /// In en, this message translates to:
  /// **'Semi-Similar'**
  String get semiSimilar;

  /// No description provided for @fullySimilar.
  ///
  /// In en, this message translates to:
  /// **'Fully Similar'**
  String get fullySimilar;

  /// No description provided for @partiallySimilar.
  ///
  /// In en, this message translates to:
  /// **'Partially Similar'**
  String get partiallySimilar;

  /// No description provided for @completelySimilar.
  ///
  /// In en, this message translates to:
  /// **'Completely Similar'**
  String get completelySimilar;

  /// No description provided for @notSimilar.
  ///
  /// In en, this message translates to:
  /// **'Not Similar'**
  String get notSimilar;

  /// No description provided for @semiDifferent.
  ///
  /// In en, this message translates to:
  /// **'Semi-Different'**
  String get semiDifferent;

  /// No description provided for @fullyDifferent.
  ///
  /// In en, this message translates to:
  /// **'Fully Different'**
  String get fullyDifferent;

  /// No description provided for @partiallyDifferent.
  ///
  /// In en, this message translates to:
  /// **'Partially Different'**
  String get partiallyDifferent;

  /// No description provided for @completelyDifferent.
  ///
  /// In en, this message translates to:
  /// **'Completely Different'**
  String get completelyDifferent;

  /// No description provided for @notDifferent.
  ///
  /// In en, this message translates to:
  /// **'Not Different'**
  String get notDifferent;

  /// No description provided for @semiSame.
  ///
  /// In en, this message translates to:
  /// **'Semi-Same'**
  String get semiSame;

  /// No description provided for @fullySame.
  ///
  /// In en, this message translates to:
  /// **'Fully Same'**
  String get fullySame;

  /// No description provided for @partiallySame.
  ///
  /// In en, this message translates to:
  /// **'Partially Same'**
  String get partiallySame;

  /// No description provided for @completelySame.
  ///
  /// In en, this message translates to:
  /// **'Completely Same'**
  String get completelySame;

  /// No description provided for @notSame.
  ///
  /// In en, this message translates to:
  /// **'Not Same'**
  String get notSame;

  /// No description provided for @semiWorse.
  ///
  /// In en, this message translates to:
  /// **'Semi-Worse'**
  String get semiWorse;

  /// No description provided for @fullyWorse.
  ///
  /// In en, this message translates to:
  /// **'Fully Worse'**
  String get fullyWorse;

  /// No description provided for @partiallyWorse.
  ///
  /// In en, this message translates to:
  /// **'Partially Worse'**
  String get partiallyWorse;

  /// No description provided for @completelyWorse.
  ///
  /// In en, this message translates to:
  /// **'Completely Worse'**
  String get completelyWorse;

  /// No description provided for @notWorse.
  ///
  /// In en, this message translates to:
  /// **'Not Worse'**
  String get notWorse;

  /// No description provided for @semiBetter.
  ///
  /// In en, this message translates to:
  /// **'Semi-Better'**
  String get semiBetter;

  /// No description provided for @fullyBetter.
  ///
  /// In en, this message translates to:
  /// **'Fully Better'**
  String get fullyBetter;

  /// No description provided for @partiallyBetter.
  ///
  /// In en, this message translates to:
  /// **'Partially Better'**
  String get partiallyBetter;

  /// No description provided for @completelyBetter.
  ///
  /// In en, this message translates to:
  /// **'Completely Better'**
  String get completelyBetter;

  /// No description provided for @notBetter.
  ///
  /// In en, this message translates to:
  /// **'Not Better'**
  String get notBetter;

  /// No description provided for @semiWorst.
  ///
  /// In en, this message translates to:
  /// **'Semi-Worst'**
  String get semiWorst;

  /// No description provided for @fullyWorst.
  ///
  /// In en, this message translates to:
  /// **'Fully Worst'**
  String get fullyWorst;

  /// No description provided for @partiallyWorst.
  ///
  /// In en, this message translates to:
  /// **'Partially Worst'**
  String get partiallyWorst;

  /// No description provided for @completelyWorst.
  ///
  /// In en, this message translates to:
  /// **'Completely Worst'**
  String get completelyWorst;

  /// No description provided for @notWorst.
  ///
  /// In en, this message translates to:
  /// **'Not Worst'**
  String get notWorst;

  /// No description provided for @semiBest.
  ///
  /// In en, this message translates to:
  /// **'Semi-Best'**
  String get semiBest;

  /// No description provided for @fullyBest.
  ///
  /// In en, this message translates to:
  /// **'Fully Best'**
  String get fullyBest;

  /// No description provided for @partiallyBest.
  ///
  /// In en, this message translates to:
  /// **'Partially Best'**
  String get partiallyBest;

  /// No description provided for @completelyBest.
  ///
  /// In en, this message translates to:
  /// **'Completely Best'**
  String get completelyBest;

  /// No description provided for @notBest.
  ///
  /// In en, this message translates to:
  /// **'Not Best'**
  String get notBest;

  /// No description provided for @semiLeast.
  ///
  /// In en, this message translates to:
  /// **'Semi-Least'**
  String get semiLeast;

  /// No description provided for @fullyLeast.
  ///
  /// In en, this message translates to:
  /// **'Fully Least'**
  String get fullyLeast;

  /// No description provided for @partiallyLeast.
  ///
  /// In en, this message translates to:
  /// **'Partially Least'**
  String get partiallyLeast;

  /// No description provided for @completelyLeast.
  ///
  /// In en, this message translates to:
  /// **'Completely Least'**
  String get completelyLeast;

  /// No description provided for @notLeast.
  ///
  /// In en, this message translates to:
  /// **'Not Least'**
  String get notLeast;

  /// No description provided for @semiMost.
  ///
  /// In en, this message translates to:
  /// **'Semi-Most'**
  String get semiMost;

  /// No description provided for @fullyMost.
  ///
  /// In en, this message translates to:
  /// **'Fully Most'**
  String get fullyMost;

  /// No description provided for @partiallyMost.
  ///
  /// In en, this message translates to:
  /// **'Partially Most'**
  String get partiallyMost;

  /// No description provided for @completelyMost.
  ///
  /// In en, this message translates to:
  /// **'Completely Most'**
  String get completelyMost;

  /// No description provided for @notMost.
  ///
  /// In en, this message translates to:
  /// **'Not Most'**
  String get notMost;

  /// No description provided for @semiMany.
  ///
  /// In en, this message translates to:
  /// **'Semi-Many'**
  String get semiMany;

  /// No description provided for @fullyMany.
  ///
  /// In en, this message translates to:
  /// **'Fully Many'**
  String get fullyMany;

  /// No description provided for @partiallyMany.
  ///
  /// In en, this message translates to:
  /// **'Partially Many'**
  String get partiallyMany;

  /// No description provided for @completelyMany.
  ///
  /// In en, this message translates to:
  /// **'Completely Many'**
  String get completelyMany;

  /// No description provided for @notMany.
  ///
  /// In en, this message translates to:
  /// **'Not Many'**
  String get notMany;

  /// No description provided for @semiFew.
  ///
  /// In en, this message translates to:
  /// **'Semi-Few'**
  String get semiFew;

  /// No description provided for @fullyFew.
  ///
  /// In en, this message translates to:
  /// **'Fully Few'**
  String get fullyFew;

  /// No description provided for @partiallyFew.
  ///
  /// In en, this message translates to:
  /// **'Partially Few'**
  String get partiallyFew;

  /// No description provided for @completelyFew.
  ///
  /// In en, this message translates to:
  /// **'Completely Few'**
  String get completelyFew;

  /// No description provided for @notFew.
  ///
  /// In en, this message translates to:
  /// **'Not Few'**
  String get notFew;

  /// No description provided for @semiSome.
  ///
  /// In en, this message translates to:
  /// **'Semi-Some'**
  String get semiSome;

  /// No description provided for @fullySome.
  ///
  /// In en, this message translates to:
  /// **'Fully Some'**
  String get fullySome;

  /// No description provided for @partiallySome.
  ///
  /// In en, this message translates to:
  /// **'Partially Some'**
  String get partiallySome;

  /// No description provided for @completelySome.
  ///
  /// In en, this message translates to:
  /// **'Completely Some'**
  String get completelySome;

  /// No description provided for @notSome.
  ///
  /// In en, this message translates to:
  /// **'Not Some'**
  String get notSome;

  /// No description provided for @semiAll.
  ///
  /// In en, this message translates to:
  /// **'Semi-All'**
  String get semiAll;

  /// No description provided for @fullyAll.
  ///
  /// In en, this message translates to:
  /// **'Fully All'**
  String get fullyAll;

  /// No description provided for @partiallyAll.
  ///
  /// In en, this message translates to:
  /// **'Partially All'**
  String get partiallyAll;

  /// No description provided for @completelyAll.
  ///
  /// In en, this message translates to:
  /// **'Completely All'**
  String get completelyAll;

  /// No description provided for @notAll.
  ///
  /// In en, this message translates to:
  /// **'Not All'**
  String get notAll;

  /// No description provided for @semiNone.
  ///
  /// In en, this message translates to:
  /// **'Semi-None'**
  String get semiNone;

  /// No description provided for @fullyNone.
  ///
  /// In en, this message translates to:
  /// **'Fully None'**
  String get fullyNone;

  /// No description provided for @partiallyNone.
  ///
  /// In en, this message translates to:
  /// **'Partially None'**
  String get partiallyNone;

  /// No description provided for @completelyNone.
  ///
  /// In en, this message translates to:
  /// **'Completely None'**
  String get completelyNone;

  /// No description provided for @notNone.
  ///
  /// In en, this message translates to:
  /// **'Not None'**
  String get notNone;

  /// No description provided for @semiLow.
  ///
  /// In en, this message translates to:
  /// **'Semi-Low'**
  String get semiLow;

  /// No description provided for @fullyLow.
  ///
  /// In en, this message translates to:
  /// **'Fully Low'**
  String get fullyLow;

  /// No description provided for @partiallyLow.
  ///
  /// In en, this message translates to:
  /// **'Partially Low'**
  String get partiallyLow;

  /// No description provided for @completelyLow.
  ///
  /// In en, this message translates to:
  /// **'Completely Low'**
  String get completelyLow;

  /// No description provided for @notLow.
  ///
  /// In en, this message translates to:
  /// **'Not Low'**
  String get notLow;

  /// No description provided for @semiMedium.
  ///
  /// In en, this message translates to:
  /// **'Semi-Medium'**
  String get semiMedium;

  /// No description provided for @fullyMedium.
  ///
  /// In en, this message translates to:
  /// **'Fully Medium'**
  String get fullyMedium;

  /// No description provided for @partiallyMedium.
  ///
  /// In en, this message translates to:
  /// **'Partially Medium'**
  String get partiallyMedium;

  /// No description provided for @completelyMedium.
  ///
  /// In en, this message translates to:
  /// **'Completely Medium'**
  String get completelyMedium;

  /// No description provided for @notMedium.
  ///
  /// In en, this message translates to:
  /// **'Not Medium'**
  String get notMedium;

  /// No description provided for @semiHigh.
  ///
  /// In en, this message translates to:
  /// **'Semi-High'**
  String get semiHigh;

  /// No description provided for @fullyHigh.
  ///
  /// In en, this message translates to:
  /// **'Fully High'**
  String get fullyHigh;

  /// No description provided for @partiallyHigh.
  ///
  /// In en, this message translates to:
  /// **'Partially High'**
  String get partiallyHigh;

  /// No description provided for @completelyHigh.
  ///
  /// In en, this message translates to:
  /// **'Completely High'**
  String get completelyHigh;

  /// No description provided for @notHigh.
  ///
  /// In en, this message translates to:
  /// **'Not High'**
  String get notHigh;

  /// No description provided for @semiCritical.
  ///
  /// In en, this message translates to:
  /// **'Semi-Critical'**
  String get semiCritical;

  /// No description provided for @fullyCritical.
  ///
  /// In en, this message translates to:
  /// **'Fully Critical'**
  String get fullyCritical;

  /// No description provided for @partiallyCritical.
  ///
  /// In en, this message translates to:
  /// **'Partially Critical'**
  String get partiallyCritical;

  /// No description provided for @completelyCritical.
  ///
  /// In en, this message translates to:
  /// **'Completely Critical'**
  String get completelyCritical;

  /// No description provided for @notCritical.
  ///
  /// In en, this message translates to:
  /// **'Not Critical'**
  String get notCritical;

  /// No description provided for @semiFatal.
  ///
  /// In en, this message translates to:
  /// **'Semi-Fatal'**
  String get semiFatal;

  /// No description provided for @fullyFatal.
  ///
  /// In en, this message translates to:
  /// **'Fully Fatal'**
  String get fullyFatal;

  /// No description provided for @partiallyFatal.
  ///
  /// In en, this message translates to:
  /// **'Partially Fatal'**
  String get partiallyFatal;

  /// No description provided for @completelyFatal.
  ///
  /// In en, this message translates to:
  /// **'Completely Fatal'**
  String get completelyFatal;

  /// No description provided for @notFatal.
  ///
  /// In en, this message translates to:
  /// **'Not Fatal'**
  String get notFatal;

  /// No description provided for @semiTrace.
  ///
  /// In en, this message translates to:
  /// **'Semi-Trace'**
  String get semiTrace;

  /// No description provided for @fullyTrace.
  ///
  /// In en, this message translates to:
  /// **'Fully Trace'**
  String get fullyTrace;

  /// No description provided for @partiallyTrace.
  ///
  /// In en, this message translates to:
  /// **'Partially Trace'**
  String get partiallyTrace;

  /// No description provided for @completelyTrace.
  ///
  /// In en, this message translates to:
  /// **'Completely Trace'**
  String get completelyTrace;

  /// No description provided for @notTrace.
  ///
  /// In en, this message translates to:
  /// **'Not Trace'**
  String get notTrace;

  /// No description provided for @semiDebug.
  ///
  /// In en, this message translates to:
  /// **'Semi-Debug'**
  String get semiDebug;

  /// No description provided for @fullyDebug.
  ///
  /// In en, this message translates to:
  /// **'Fully Debug'**
  String get fullyDebug;

  /// No description provided for @partiallyDebug.
  ///
  /// In en, this message translates to:
  /// **'Partially Debug'**
  String get partiallyDebug;

  /// No description provided for @completelyDebug.
  ///
  /// In en, this message translates to:
  /// **'Completely Debug'**
  String get completelyDebug;

  /// No description provided for @notDebug.
  ///
  /// In en, this message translates to:
  /// **'Not Debug'**
  String get notDebug;

  /// No description provided for @semiInfo.
  ///
  /// In en, this message translates to:
  /// **'Semi-Info'**
  String get semiInfo;

  /// No description provided for @fullyInfo.
  ///
  /// In en, this message translates to:
  /// **'Fully Info'**
  String get fullyInfo;

  /// No description provided for @partiallyInfo.
  ///
  /// In en, this message translates to:
  /// **'Partially Info'**
  String get partiallyInfo;

  /// No description provided for @completelyInfo.
  ///
  /// In en, this message translates to:
  /// **'Completely Info'**
  String get completelyInfo;

  /// No description provided for @notInfo.
  ///
  /// In en, this message translates to:
  /// **'Not Info'**
  String get notInfo;

  /// No description provided for @semiWarning.
  ///
  /// In en, this message translates to:
  /// **'Semi-Warning'**
  String get semiWarning;

  /// No description provided for @fullyWarning.
  ///
  /// In en, this message translates to:
  /// **'Fully Warning'**
  String get fullyWarning;

  /// No description provided for @partiallyWarning.
  ///
  /// In en, this message translates to:
  /// **'Partially Warning'**
  String get partiallyWarning;

  /// No description provided for @completelyWarning.
  ///
  /// In en, this message translates to:
  /// **'Completely Warning'**
  String get completelyWarning;

  /// No description provided for @notWarning.
  ///
  /// In en, this message translates to:
  /// **'Not Warning'**
  String get notWarning;

  /// No description provided for @semiError.
  ///
  /// In en, this message translates to:
  /// **'Semi-Error'**
  String get semiError;

  /// No description provided for @fullyError.
  ///
  /// In en, this message translates to:
  /// **'Fully Error'**
  String get fullyError;

  /// No description provided for @partiallyError.
  ///
  /// In en, this message translates to:
  /// **'Partially Error'**
  String get partiallyError;

  /// No description provided for @completelyError.
  ///
  /// In en, this message translates to:
  /// **'Completely Error'**
  String get completelyError;

  /// No description provided for @notError.
  ///
  /// In en, this message translates to:
  /// **'Not Error'**
  String get notError;

  /// No description provided for @semiFailed.
  ///
  /// In en, this message translates to:
  /// **'Semi-Failed'**
  String get semiFailed;

  /// No description provided for @fullyFailed.
  ///
  /// In en, this message translates to:
  /// **'Fully Failed'**
  String get fullyFailed;

  /// No description provided for @partiallyFailed.
  ///
  /// In en, this message translates to:
  /// **'Partially Failed'**
  String get partiallyFailed;

  /// No description provided for @completelyFailed.
  ///
  /// In en, this message translates to:
  /// **'Completely Failed'**
  String get completelyFailed;

  /// No description provided for @notFailed.
  ///
  /// In en, this message translates to:
  /// **'Not Failed'**
  String get notFailed;

  /// No description provided for @semiSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Semi-Successful'**
  String get semiSuccessful;

  /// No description provided for @fullySuccessful.
  ///
  /// In en, this message translates to:
  /// **'Fully Successful'**
  String get fullySuccessful;

  /// No description provided for @partiallySuccessful.
  ///
  /// In en, this message translates to:
  /// **'Partially Successful'**
  String get partiallySuccessful;

  /// No description provided for @completelySuccessful.
  ///
  /// In en, this message translates to:
  /// **'Completely Successful'**
  String get completelySuccessful;

  /// No description provided for @notSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Not Successful'**
  String get notSuccessful;

  /// No description provided for @semiInvalid.
  ///
  /// In en, this message translates to:
  /// **'Semi-Invalid'**
  String get semiInvalid;

  /// No description provided for @fullyInvalid.
  ///
  /// In en, this message translates to:
  /// **'Fully Invalid'**
  String get fullyInvalid;

  /// No description provided for @partiallyInvalid.
  ///
  /// In en, this message translates to:
  /// **'Partially Invalid'**
  String get partiallyInvalid;

  /// No description provided for @completelyInvalid.
  ///
  /// In en, this message translates to:
  /// **'Completely Invalid'**
  String get completelyInvalid;

  /// No description provided for @notInvalid.
  ///
  /// In en, this message translates to:
  /// **'Not Invalid'**
  String get notInvalid;

  /// No description provided for @semiValid.
  ///
  /// In en, this message translates to:
  /// **'Semi-Valid'**
  String get semiValid;

  /// No description provided for @fullyValid.
  ///
  /// In en, this message translates to:
  /// **'Fully Valid'**
  String get fullyValid;

  /// No description provided for @partiallyValid.
  ///
  /// In en, this message translates to:
  /// **'Partially Valid'**
  String get partiallyValid;

  /// No description provided for @completelyValid.
  ///
  /// In en, this message translates to:
  /// **'Completely Valid'**
  String get completelyValid;

  /// No description provided for @notValid.
  ///
  /// In en, this message translates to:
  /// **'Not Valid'**
  String get notValid;

  /// No description provided for @semiUnverified.
  ///
  /// In en, this message translates to:
  /// **'Semi-Unverified'**
  String get semiUnverified;

  /// No description provided for @fullyUnverified.
  ///
  /// In en, this message translates to:
  /// **'Fully Unverified'**
  String get fullyUnverified;

  /// No description provided for @partiallyUnverified.
  ///
  /// In en, this message translates to:
  /// **'Partially Unverified'**
  String get partiallyUnverified;

  /// No description provided for @completelyUnverified.
  ///
  /// In en, this message translates to:
  /// **'Completely Unverified'**
  String get completelyUnverified;

  /// No description provided for @notUnverified.
  ///
  /// In en, this message translates to:
  /// **'Not Unverified'**
  String get notUnverified;

  /// No description provided for @semiVerified.
  ///
  /// In en, this message translates to:
  /// **'Semi-Verified'**
  String get semiVerified;

  /// No description provided for @fullyVerified.
  ///
  /// In en, this message translates to:
  /// **'Fully Verified'**
  String get fullyVerified;

  /// No description provided for @partiallyVerified.
  ///
  /// In en, this message translates to:
  /// **'Partially Verified'**
  String get partiallyVerified;

  /// No description provided for @completelyVerified.
  ///
  /// In en, this message translates to:
  /// **'Completely Verified'**
  String get completelyVerified;

  /// No description provided for @notVerified.
  ///
  /// In en, this message translates to:
  /// **'Not Verified'**
  String get notVerified;

  /// No description provided for @semiUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Semi-Unlocked'**
  String get semiUnlocked;

  /// No description provided for @fullyUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Fully Unlocked'**
  String get fullyUnlocked;

  /// No description provided for @partiallyUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Partially Unlocked'**
  String get partiallyUnlocked;

  /// No description provided for @completelyUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Completely Unlocked'**
  String get completelyUnlocked;

  /// No description provided for @notUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Not Unlocked'**
  String get notUnlocked;

  /// No description provided for @semiLocked.
  ///
  /// In en, this message translates to:
  /// **'Semi-Locked'**
  String get semiLocked;

  /// No description provided for @fullyLocked.
  ///
  /// In en, this message translates to:
  /// **'Fully Locked'**
  String get fullyLocked;

  /// No description provided for @partiallyLocked.
  ///
  /// In en, this message translates to:
  /// **'Partially Locked'**
  String get partiallyLocked;

  /// No description provided for @completelyLocked.
  ///
  /// In en, this message translates to:
  /// **'Completely Locked'**
  String get completelyLocked;

  /// No description provided for @notLocked.
  ///
  /// In en, this message translates to:
  /// **'Not Locked'**
  String get notLocked;

  /// No description provided for @semiUnshared.
  ///
  /// In en, this message translates to:
  /// **'Semi-Unshared'**
  String get semiUnshared;

  /// No description provided for @fullyUnshared.
  ///
  /// In en, this message translates to:
  /// **'Fully Unshared'**
  String get fullyUnshared;

  /// No description provided for @partiallyUnshared.
  ///
  /// In en, this message translates to:
  /// **'Partially Unshared'**
  String get partiallyUnshared;

  /// No description provided for @completelyUnshared.
  ///
  /// In en, this message translates to:
  /// **'Completely Unshared'**
  String get completelyUnshared;

  /// No description provided for @notUnshared.
  ///
  /// In en, this message translates to:
  /// **'Not Unshared'**
  String get notUnshared;

  /// No description provided for @semiShared.
  ///
  /// In en, this message translates to:
  /// **'Semi-Shared'**
  String get semiShared;

  /// No description provided for @fullyShared.
  ///
  /// In en, this message translates to:
  /// **'Fully Shared'**
  String get fullyShared;

  /// No description provided for @partiallyShared.
  ///
  /// In en, this message translates to:
  /// **'Partially Shared'**
  String get partiallyShared;

  /// No description provided for @completelyShared.
  ///
  /// In en, this message translates to:
  /// **'Completely Shared'**
  String get completelyShared;

  /// No description provided for @notShared.
  ///
  /// In en, this message translates to:
  /// **'Not Shared'**
  String get notShared;

  /// No description provided for @semiCopied.
  ///
  /// In en, this message translates to:
  /// **'Semi-Copied'**
  String get semiCopied;

  /// No description provided for @fullyCopied.
  ///
  /// In en, this message translates to:
  /// **'Fully Copied'**
  String get fullyCopied;

  /// No description provided for @partiallyCopied.
  ///
  /// In en, this message translates to:
  /// **'Partially Copied'**
  String get partiallyCopied;

  /// No description provided for @completelyCopied.
  ///
  /// In en, this message translates to:
  /// **'Completely Copied'**
  String get completelyCopied;

  /// No description provided for @notCopied.
  ///
  /// In en, this message translates to:
  /// **'Not Copied'**
  String get notCopied;

  /// No description provided for @semiMoved.
  ///
  /// In en, this message translates to:
  /// **'Semi-Moved'**
  String get semiMoved;

  /// No description provided for @fullyMoved.
  ///
  /// In en, this message translates to:
  /// **'Fully Moved'**
  String get fullyMoved;

  /// No description provided for @partiallyMoved.
  ///
  /// In en, this message translates to:
  /// **'Partially Moved'**
  String get partiallyMoved;

  /// No description provided for @completelyMoved.
  ///
  /// In en, this message translates to:
  /// **'Completely Moved'**
  String get completelyMoved;

  /// No description provided for @notMoved.
  ///
  /// In en, this message translates to:
  /// **'Not Moved'**
  String get notMoved;

  /// No description provided for @semiRestored.
  ///
  /// In en, this message translates to:
  /// **'Semi-Restored'**
  String get semiRestored;

  /// No description provided for @fullyRestored.
  ///
  /// In en, this message translates to:
  /// **'Fully Restored'**
  String get fullyRestored;

  /// No description provided for @partiallyRestored.
  ///
  /// In en, this message translates to:
  /// **'Partially Restored'**
  String get partiallyRestored;

  /// No description provided for @completelyRestored.
  ///
  /// In en, this message translates to:
  /// **'Completely Restored'**
  String get completelyRestored;

  /// No description provided for @notRestored.
  ///
  /// In en, this message translates to:
  /// **'Not Restored'**
  String get notRestored;

  /// No description provided for @semiDeleted.
  ///
  /// In en, this message translates to:
  /// **'Semi-Deleted'**
  String get semiDeleted;

  /// No description provided for @fullyDeleted.
  ///
  /// In en, this message translates to:
  /// **'Fully Deleted'**
  String get fullyDeleted;

  /// No description provided for @partiallyDeleted.
  ///
  /// In en, this message translates to:
  /// **'Partially Deleted'**
  String get partiallyDeleted;

  /// No description provided for @completelyDeleted.
  ///
  /// In en, this message translates to:
  /// **'Completely Deleted'**
  String get completelyDeleted;

  /// No description provided for @notDeleted.
  ///
  /// In en, this message translates to:
  /// **'Not Deleted'**
  String get notDeleted;

  /// No description provided for @semiArchived.
  ///
  /// In en, this message translates to:
  /// **'Semi-Archived'**
  String get semiArchived;

  /// No description provided for @fullyArchived.
  ///
  /// In en, this message translates to:
  /// **'Fully Archived'**
  String get fullyArchived;

  /// No description provided for @partiallyArchived.
  ///
  /// In en, this message translates to:
  /// **'Partially Archived'**
  String get partiallyArchived;

  /// No description provided for @completelyArchived.
  ///
  /// In en, this message translates to:
  /// **'Completely Archived'**
  String get completelyArchived;

  /// No description provided for @notArchived.
  ///
  /// In en, this message translates to:
  /// **'Not Archived'**
  String get notArchived;

  /// No description provided for @semiPublished.
  ///
  /// In en, this message translates to:
  /// **'Semi-Published'**
  String get semiPublished;

  /// No description provided for @fullyPublished.
  ///
  /// In en, this message translates to:
  /// **'Fully Published'**
  String get fullyPublished;

  /// No description provided for @partiallyPublished.
  ///
  /// In en, this message translates to:
  /// **'Partially Published'**
  String get partiallyPublished;

  /// No description provided for @completelyPublished.
  ///
  /// In en, this message translates to:
  /// **'Completely Published'**
  String get completelyPublished;

  /// No description provided for @notPublished.
  ///
  /// In en, this message translates to:
  /// **'Not Published'**
  String get notPublished;

  /// No description provided for @semiDraft.
  ///
  /// In en, this message translates to:
  /// **'Semi-Draft'**
  String get semiDraft;

  /// No description provided for @fullyDraft.
  ///
  /// In en, this message translates to:
  /// **'Fully Draft'**
  String get fullyDraft;

  /// No description provided for @partiallyDraft.
  ///
  /// In en, this message translates to:
  /// **'Partially Draft'**
  String get partiallyDraft;

  /// No description provided for @completelyDraft.
  ///
  /// In en, this message translates to:
  /// **'Completely Draft'**
  String get completelyDraft;

  /// No description provided for @notDraft.
  ///
  /// In en, this message translates to:
  /// **'Not Draft'**
  String get notDraft;

  /// No description provided for @semiPrivate.
  ///
  /// In en, this message translates to:
  /// **'Semi-Private'**
  String get semiPrivate;

  /// No description provided for @fullyPrivate.
  ///
  /// In en, this message translates to:
  /// **'Fully Private'**
  String get fullyPrivate;

  /// No description provided for @partiallyPrivate.
  ///
  /// In en, this message translates to:
  /// **'Partially Private'**
  String get partiallyPrivate;

  /// No description provided for @completelyPrivate.
  ///
  /// In en, this message translates to:
  /// **'Completely Private'**
  String get completelyPrivate;

  /// No description provided for @notPrivate.
  ///
  /// In en, this message translates to:
  /// **'Not Private'**
  String get notPrivate;

  /// No description provided for @semiPublic.
  ///
  /// In en, this message translates to:
  /// **'Semi-Public'**
  String get semiPublic;

  /// No description provided for @fullyPublic.
  ///
  /// In en, this message translates to:
  /// **'Fully Public'**
  String get fullyPublic;

  /// No description provided for @partiallyPublic.
  ///
  /// In en, this message translates to:
  /// **'Partially Public'**
  String get partiallyPublic;

  /// No description provided for @completelyPublic.
  ///
  /// In en, this message translates to:
  /// **'Completely Public'**
  String get completelyPublic;

  /// No description provided for @notPublic.
  ///
  /// In en, this message translates to:
  /// **'Not Public'**
  String get notPublic;

  /// No description provided for @semiHidden.
  ///
  /// In en, this message translates to:
  /// **'Semi-Hidden'**
  String get semiHidden;

  /// No description provided for @fullyHidden.
  ///
  /// In en, this message translates to:
  /// **'Fully Hidden'**
  String get fullyHidden;

  /// No description provided for @partiallyHidden.
  ///
  /// In en, this message translates to:
  /// **'Partially Hidden'**
  String get partiallyHidden;

  /// No description provided for @completelyHidden.
  ///
  /// In en, this message translates to:
  /// **'Completely Hidden'**
  String get completelyHidden;

  /// No description provided for @notHidden.
  ///
  /// In en, this message translates to:
  /// **'Not Hidden'**
  String get notHidden;

  /// No description provided for @semiVisible.
  ///
  /// In en, this message translates to:
  /// **'Semi-Visible'**
  String get semiVisible;

  /// No description provided for @fullyVisible.
  ///
  /// In en, this message translates to:
  /// **'Fully Visible'**
  String get fullyVisible;

  /// No description provided for @partiallyVisible.
  ///
  /// In en, this message translates to:
  /// **'Partially Visible'**
  String get partiallyVisible;

  /// No description provided for @completelyVisible.
  ///
  /// In en, this message translates to:
  /// **'Completely Visible'**
  String get completelyVisible;

  /// No description provided for @notVisible.
  ///
  /// In en, this message translates to:
  /// **'Not Visible'**
  String get notVisible;

  /// No description provided for @semiDisabled.
  ///
  /// In en, this message translates to:
  /// **'Semi-Disabled'**
  String get semiDisabled;

  /// No description provided for @fullyDisabled.
  ///
  /// In en, this message translates to:
  /// **'Fully Disabled'**
  String get fullyDisabled;

  /// No description provided for @partiallyDisabled.
  ///
  /// In en, this message translates to:
  /// **'Partially Disabled'**
  String get partiallyDisabled;

  /// No description provided for @completelyDisabled.
  ///
  /// In en, this message translates to:
  /// **'Completely Disabled'**
  String get completelyDisabled;

  /// No description provided for @notDisabled.
  ///
  /// In en, this message translates to:
  /// **'Not Disabled'**
  String get notDisabled;

  /// No description provided for @semiEnabled.
  ///
  /// In en, this message translates to:
  /// **'Semi-Enabled'**
  String get semiEnabled;

  /// No description provided for @fullyEnabled.
  ///
  /// In en, this message translates to:
  /// **'Fully Enabled'**
  String get fullyEnabled;

  /// No description provided for @partiallyEnabled.
  ///
  /// In en, this message translates to:
  /// **'Partially Enabled'**
  String get partiallyEnabled;

  /// No description provided for @completelyEnabled.
  ///
  /// In en, this message translates to:
  /// **'Completely Enabled'**
  String get completelyEnabled;

  /// No description provided for @notEnabled.
  ///
  /// In en, this message translates to:
  /// **'Not Enabled'**
  String get notEnabled;

  /// No description provided for @semiInactive.
  ///
  /// In en, this message translates to:
  /// **'Semi-Inactive'**
  String get semiInactive;

  /// No description provided for @fullyInactive.
  ///
  /// In en, this message translates to:
  /// **'Fully Inactive'**
  String get fullyInactive;

  /// No description provided for @partiallyInactive.
  ///
  /// In en, this message translates to:
  /// **'Partially Inactive'**
  String get partiallyInactive;

  /// No description provided for @completelyInactive.
  ///
  /// In en, this message translates to:
  /// **'Completely Inactive'**
  String get completelyInactive;

  /// No description provided for @notInactive.
  ///
  /// In en, this message translates to:
  /// **'Not Inactive'**
  String get notInactive;

  /// No description provided for @semiActive.
  ///
  /// In en, this message translates to:
  /// **'Semi-Active'**
  String get semiActive;

  /// No description provided for @fullyActive.
  ///
  /// In en, this message translates to:
  /// **'Fully Active'**
  String get fullyActive;

  /// No description provided for @partiallyActive.
  ///
  /// In en, this message translates to:
  /// **'Partially Active'**
  String get partiallyActive;

  /// No description provided for @completelyActive.
  ///
  /// In en, this message translates to:
  /// **'Completely Active'**
  String get completelyActive;

  /// No description provided for @notActive.
  ///
  /// In en, this message translates to:
  /// **'Not Active'**
  String get notActive;

  /// No description provided for @semiExpired.
  ///
  /// In en, this message translates to:
  /// **'Semi-Expired'**
  String get semiExpired;

  /// No description provided for @fullyExpired.
  ///
  /// In en, this message translates to:
  /// **'Fully Expired'**
  String get fullyExpired;

  /// No description provided for @partiallyExpired.
  ///
  /// In en, this message translates to:
  /// **'Partially Expired'**
  String get partiallyExpired;

  /// No description provided for @completelyExpired.
  ///
  /// In en, this message translates to:
  /// **'Completely Expired'**
  String get completelyExpired;

  /// No description provided for @notExpired.
  ///
  /// In en, this message translates to:
  /// **'Not Expired'**
  String get notExpired;

  /// No description provided for @semiCancelled.
  ///
  /// In en, this message translates to:
  /// **'Semi-Cancelled'**
  String get semiCancelled;

  /// No description provided for @fullyCancelled.
  ///
  /// In en, this message translates to:
  /// **'Fully Cancelled'**
  String get fullyCancelled;

  /// No description provided for @partiallyCancelled.
  ///
  /// In en, this message translates to:
  /// **'Partially Cancelled'**
  String get partiallyCancelled;

  /// No description provided for @completelyCancelled.
  ///
  /// In en, this message translates to:
  /// **'Completely Cancelled'**
  String get completelyCancelled;

  /// No description provided for @notCancelled.
  ///
  /// In en, this message translates to:
  /// **'Not Cancelled'**
  String get notCancelled;

  /// No description provided for @semiScheduled.
  ///
  /// In en, this message translates to:
  /// **'Semi-Scheduled'**
  String get semiScheduled;

  /// No description provided for @fullyScheduled.
  ///
  /// In en, this message translates to:
  /// **'Fully Scheduled'**
  String get fullyScheduled;

  /// No description provided for @partiallyScheduled.
  ///
  /// In en, this message translates to:
  /// **'Partially Scheduled'**
  String get partiallyScheduled;

  /// No description provided for @completelyScheduled.
  ///
  /// In en, this message translates to:
  /// **'Completely Scheduled'**
  String get completelyScheduled;

  /// No description provided for @notScheduled.
  ///
  /// In en, this message translates to:
  /// **'Not Scheduled'**
  String get notScheduled;

  /// No description provided for @semiInProgress.
  ///
  /// In en, this message translates to:
  /// **'Semi-In Progress'**
  String get semiInProgress;

  /// No description provided for @fullyInProgress.
  ///
  /// In en, this message translates to:
  /// **'Fully In Progress'**
  String get fullyInProgress;

  /// No description provided for @partiallyInProgress.
  ///
  /// In en, this message translates to:
  /// **'Partially In Progress'**
  String get partiallyInProgress;

  /// No description provided for @completelyInProgress.
  ///
  /// In en, this message translates to:
  /// **'Completely In Progress'**
  String get completelyInProgress;

  /// No description provided for @notInProgress.
  ///
  /// In en, this message translates to:
  /// **'Not In Progress'**
  String get notInProgress;

  /// No description provided for @semiCompleted.
  ///
  /// In en, this message translates to:
  /// **'Semi-Completed'**
  String get semiCompleted;

  /// No description provided for @fullyCompleted.
  ///
  /// In en, this message translates to:
  /// **'Fully Completed'**
  String get fullyCompleted;

  /// No description provided for @partiallyCompleted.
  ///
  /// In en, this message translates to:
  /// **'Partially Completed'**
  String get partiallyCompleted;

  /// No description provided for @completelyCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completely Completed'**
  String get completelyCompleted;

  /// No description provided for @notCompleted.
  ///
  /// In en, this message translates to:
  /// **'Not Completed'**
  String get notCompleted;

  /// No description provided for @semiRejected.
  ///
  /// In en, this message translates to:
  /// **'Semi-Rejected'**
  String get semiRejected;

  /// No description provided for @fullyRejected.
  ///
  /// In en, this message translates to:
  /// **'Fully Rejected'**
  String get fullyRejected;

  /// No description provided for @partiallyRejected.
  ///
  /// In en, this message translates to:
  /// **'Partially Rejected'**
  String get partiallyRejected;

  /// No description provided for @completelyRejected.
  ///
  /// In en, this message translates to:
  /// **'Completely Rejected'**
  String get completelyRejected;

  /// No description provided for @notRejected.
  ///
  /// In en, this message translates to:
  /// **'Not Rejected'**
  String get notRejected;

  /// No description provided for @semiApproved.
  ///
  /// In en, this message translates to:
  /// **'Semi-Approved'**
  String get semiApproved;

  /// No description provided for @fullyApproved.
  ///
  /// In en, this message translates to:
  /// **'Fully Approved'**
  String get fullyApproved;

  /// No description provided for @partiallyApproved.
  ///
  /// In en, this message translates to:
  /// **'Partially Approved'**
  String get partiallyApproved;

  /// No description provided for @completelyApproved.
  ///
  /// In en, this message translates to:
  /// **'Completely Approved'**
  String get completelyApproved;

  /// No description provided for @notApproved.
  ///
  /// In en, this message translates to:
  /// **'Not Approved'**
  String get notApproved;

  /// No description provided for @semiDecline.
  ///
  /// In en, this message translates to:
  /// **'Semi-Decline'**
  String get semiDecline;

  /// No description provided for @fullyDecline.
  ///
  /// In en, this message translates to:
  /// **'Fully Decline'**
  String get fullyDecline;

  /// No description provided for @partiallyDecline.
  ///
  /// In en, this message translates to:
  /// **'Partially Decline'**
  String get partiallyDecline;

  /// No description provided for @completelyDecline.
  ///
  /// In en, this message translates to:
  /// **'Completely Decline'**
  String get completelyDecline;

  /// No description provided for @notDecline.
  ///
  /// In en, this message translates to:
  /// **'Not Decline'**
  String get notDecline;

  /// No description provided for @semiAccept.
  ///
  /// In en, this message translates to:
  /// **'Semi-Accept'**
  String get semiAccept;

  /// No description provided for @fullyAccept.
  ///
  /// In en, this message translates to:
  /// **'Fully Accept'**
  String get fullyAccept;

  /// No description provided for @partiallyAccept.
  ///
  /// In en, this message translates to:
  /// **'Partially Accept'**
  String get partiallyAccept;

  /// No description provided for @completelyAccept.
  ///
  /// In en, this message translates to:
  /// **'Completely Accept'**
  String get completelyAccept;

  /// No description provided for @notAccept.
  ///
  /// In en, this message translates to:
  /// **'Not Accept'**
  String get notAccept;

  /// No description provided for @semiConfirm.
  ///
  /// In en, this message translates to:
  /// **'Semi-Confirm'**
  String get semiConfirm;

  /// No description provided for @fullyConfirm.
  ///
  /// In en, this message translates to:
  /// **'Fully Confirm'**
  String get fullyConfirm;

  /// No description provided for @partiallyConfirm.
  ///
  /// In en, this message translates to:
  /// **'Partially Confirm'**
  String get partiallyConfirm;

  /// No description provided for @completelyConfirm.
  ///
  /// In en, this message translates to:
  /// **'Completely Confirm'**
  String get completelyConfirm;

  /// No description provided for @notConfirm.
  ///
  /// In en, this message translates to:
  /// **'Not Confirm'**
  String get notConfirm;

  /// No description provided for @semiCancel.
  ///
  /// In en, this message translates to:
  /// **'Semi-Cancel'**
  String get semiCancel;

  /// No description provided for @fullyCancel.
  ///
  /// In en, this message translates to:
  /// **'Fully Cancel'**
  String get fullyCancel;

  /// No description provided for @partiallyCancel.
  ///
  /// In en, this message translates to:
  /// **'Partially Cancel'**
  String get partiallyCancel;

  /// No description provided for @completelyCancel.
  ///
  /// In en, this message translates to:
  /// **'Completely Cancel'**
  String get completelyCancel;

  /// No description provided for @notCancel.
  ///
  /// In en, this message translates to:
  /// **'Not Cancel'**
  String get notCancel;

  /// No description provided for @semiAbort.
  ///
  /// In en, this message translates to:
  /// **'Semi-Abort'**
  String get semiAbort;

  /// No description provided for @fullyAbort.
  ///
  /// In en, this message translates to:
  /// **'Fully Abort'**
  String get fullyAbort;

  /// No description provided for @partiallyAbort.
  ///
  /// In en, this message translates to:
  /// **'Partially Abort'**
  String get partiallyAbort;

  /// No description provided for @completelyAbort.
  ///
  /// In en, this message translates to:
  /// **'Completely Abort'**
  String get completelyAbort;

  /// No description provided for @notAbort.
  ///
  /// In en, this message translates to:
  /// **'Not Abort'**
  String get notAbort;

  /// No description provided for @semiRetry.
  ///
  /// In en, this message translates to:
  /// **'Semi-Retry'**
  String get semiRetry;

  /// No description provided for @fullyRetry.
  ///
  /// In en, this message translates to:
  /// **'Fully Retry'**
  String get fullyRetry;

  /// No description provided for @partiallyRetry.
  ///
  /// In en, this message translates to:
  /// **'Partially Retry'**
  String get partiallyRetry;

  /// No description provided for @completelyRetry.
  ///
  /// In en, this message translates to:
  /// **'Completely Retry'**
  String get completelyRetry;

  /// No description provided for @notRetry.
  ///
  /// In en, this message translates to:
  /// **'Not Retry'**
  String get notRetry;

  /// No description provided for @semiResume.
  ///
  /// In en, this message translates to:
  /// **'Semi-Resume'**
  String get semiResume;

  /// No description provided for @fullyResume.
  ///
  /// In en, this message translates to:
  /// **'Fully Resume'**
  String get fullyResume;

  /// No description provided for @partiallyResume.
  ///
  /// In en, this message translates to:
  /// **'Partially Resume'**
  String get partiallyResume;

  /// No description provided for @completelyResume.
  ///
  /// In en, this message translates to:
  /// **'Completely Resume'**
  String get completelyResume;

  /// No description provided for @notResume.
  ///
  /// In en, this message translates to:
  /// **'Not Resume'**
  String get notResume;

  /// No description provided for @semiPause.
  ///
  /// In en, this message translates to:
  /// **'Semi-Pause'**
  String get semiPause;

  /// No description provided for @fullyPause.
  ///
  /// In en, this message translates to:
  /// **'Fully Pause'**
  String get fullyPause;

  /// No description provided for @partiallyPause.
  ///
  /// In en, this message translates to:
  /// **'Partially Pause'**
  String get partiallyPause;

  /// No description provided for @completelyPause.
  ///
  /// In en, this message translates to:
  /// **'Completely Pause'**
  String get completelyPause;

  /// No description provided for @notPause.
  ///
  /// In en, this message translates to:
  /// **'Not Pause'**
  String get notPause;

  /// No description provided for @semiStop.
  ///
  /// In en, this message translates to:
  /// **'Semi-Stop'**
  String get semiStop;

  /// No description provided for @fullyStop.
  ///
  /// In en, this message translates to:
  /// **'Fully Stop'**
  String get fullyStop;

  /// No description provided for @partiallyStop.
  ///
  /// In en, this message translates to:
  /// **'Partially Stop'**
  String get partiallyStop;

  /// No description provided for @completelyStop.
  ///
  /// In en, this message translates to:
  /// **'Completely Stop'**
  String get completelyStop;

  /// No description provided for @notStop.
  ///
  /// In en, this message translates to:
  /// **'Not Stop'**
  String get notStop;

  /// No description provided for @semiStart.
  ///
  /// In en, this message translates to:
  /// **'Semi-Start'**
  String get semiStart;

  /// No description provided for @fullyStart.
  ///
  /// In en, this message translates to:
  /// **'Fully Start'**
  String get fullyStart;

  /// No description provided for @partiallyStart.
  ///
  /// In en, this message translates to:
  /// **'Partially Start'**
  String get partiallyStart;

  /// No description provided for @completelyStart.
  ///
  /// In en, this message translates to:
  /// **'Completely Start'**
  String get completelyStart;

  /// No description provided for @notStart.
  ///
  /// In en, this message translates to:
  /// **'Not Start'**
  String get notStart;

  /// No description provided for @semiFinish.
  ///
  /// In en, this message translates to:
  /// **'Semi-Finish'**
  String get semiFinish;

  /// No description provided for @fullyFinish.
  ///
  /// In en, this message translates to:
  /// **'Fully Finish'**
  String get fullyFinish;

  /// No description provided for @partiallyFinish.
  ///
  /// In en, this message translates to:
  /// **'Partially Finish'**
  String get partiallyFinish;

  /// No description provided for @completelyFinish.
  ///
  /// In en, this message translates to:
  /// **'Completely Finish'**
  String get completelyFinish;

  /// No description provided for @notFinish.
  ///
  /// In en, this message translates to:
  /// **'Not Finish'**
  String get notFinish;

  /// No description provided for @semiContinue.
  ///
  /// In en, this message translates to:
  /// **'Semi-Continue'**
  String get semiContinue;

  /// No description provided for @fullyContinue.
  ///
  /// In en, this message translates to:
  /// **'Fully Continue'**
  String get fullyContinue;

  /// No description provided for @partiallyContinue.
  ///
  /// In en, this message translates to:
  /// **'Partially Continue'**
  String get partiallyContinue;

  /// No description provided for @completelyContinue.
  ///
  /// In en, this message translates to:
  /// **'Completely Continue'**
  String get completelyContinue;

  /// No description provided for @notContinue.
  ///
  /// In en, this message translates to:
  /// **'Not Continue'**
  String get notContinue;

  /// No description provided for @semiSkip.
  ///
  /// In en, this message translates to:
  /// **'Semi-Skip'**
  String get semiSkip;

  /// No description provided for @fullySkip.
  ///
  /// In en, this message translates to:
  /// **'Fully Skip'**
  String get fullySkip;

  /// No description provided for @partiallySkip.
  ///
  /// In en, this message translates to:
  /// **'Partially Skip'**
  String get partiallySkip;

  /// No description provided for @completelySkip.
  ///
  /// In en, this message translates to:
  /// **'Completely Skip'**
  String get completelySkip;

  /// No description provided for @notSkip.
  ///
  /// In en, this message translates to:
  /// **'Not Skip'**
  String get notSkip;

  /// No description provided for @semiDone.
  ///
  /// In en, this message translates to:
  /// **'Semi-Done'**
  String get semiDone;

  /// No description provided for @fullyDone.
  ///
  /// In en, this message translates to:
  /// **'Fully Done'**
  String get fullyDone;

  /// No description provided for @partiallyDone.
  ///
  /// In en, this message translates to:
  /// **'Partially Done'**
  String get partiallyDone;

  /// No description provided for @completelyDone.
  ///
  /// In en, this message translates to:
  /// **'Completely Done'**
  String get completelyDone;

  /// No description provided for @notDone.
  ///
  /// In en, this message translates to:
  /// **'Not Done'**
  String get notDone;

  /// No description provided for @semiOk.
  ///
  /// In en, this message translates to:
  /// **'Semi-OK'**
  String get semiOk;

  /// No description provided for @fullyOk.
  ///
  /// In en, this message translates to:
  /// **'Fully OK'**
  String get fullyOk;

  /// No description provided for @partiallyOk.
  ///
  /// In en, this message translates to:
  /// **'Partially OK'**
  String get partiallyOk;

  /// No description provided for @completelyOk.
  ///
  /// In en, this message translates to:
  /// **'Completely OK'**
  String get completelyOk;

  /// No description provided for @notOk.
  ///
  /// In en, this message translates to:
  /// **'Not OK'**
  String get notOk;

  /// No description provided for @semiNo.
  ///
  /// In en, this message translates to:
  /// **'Semi-No'**
  String get semiNo;

  /// No description provided for @fullyNo.
  ///
  /// In en, this message translates to:
  /// **'Fully No'**
  String get fullyNo;

  /// No description provided for @partiallyNo.
  ///
  /// In en, this message translates to:
  /// **'Partially No'**
  String get partiallyNo;

  /// No description provided for @completelyNo.
  ///
  /// In en, this message translates to:
  /// **'Completely No'**
  String get completelyNo;

  /// No description provided for @notNo.
  ///
  /// In en, this message translates to:
  /// **'Not No'**
  String get notNo;

  /// No description provided for @semiYes.
  ///
  /// In en, this message translates to:
  /// **'Semi-Yes'**
  String get semiYes;

  /// No description provided for @fullyYes.
  ///
  /// In en, this message translates to:
  /// **'Fully Yes'**
  String get fullyYes;

  /// No description provided for @partiallyYes.
  ///
  /// In en, this message translates to:
  /// **'Partially Yes'**
  String get partiallyYes;

  /// No description provided for @completelyYes.
  ///
  /// In en, this message translates to:
  /// **'Completely Yes'**
  String get completelyYes;

  /// No description provided for @notYes.
  ///
  /// In en, this message translates to:
  /// **'Not Yes'**
  String get notYes;

  /// No description provided for @semiOpen.
  ///
  /// In en, this message translates to:
  /// **'Semi-Open'**
  String get semiOpen;

  /// No description provided for @fullyOpen.
  ///
  /// In en, this message translates to:
  /// **'Fully Open'**
  String get fullyOpen;

  /// No description provided for @partiallyOpen.
  ///
  /// In en, this message translates to:
  /// **'Partially Open'**
  String get partiallyOpen;

  /// No description provided for @completelyOpen.
  ///
  /// In en, this message translates to:
  /// **'Completely Open'**
  String get completelyOpen;

  /// No description provided for @notOpen.
  ///
  /// In en, this message translates to:
  /// **'Not Open'**
  String get notOpen;

  /// No description provided for @semiClose.
  ///
  /// In en, this message translates to:
  /// **'Semi-Close'**
  String get semiClose;

  /// No description provided for @fullyClose.
  ///
  /// In en, this message translates to:
  /// **'Fully Close'**
  String get fullyClose;

  /// No description provided for @partiallyClose.
  ///
  /// In en, this message translates to:
  /// **'Partially Close'**
  String get partiallyClose;

  /// No description provided for @completelyClose.
  ///
  /// In en, this message translates to:
  /// **'Completely Close'**
  String get completelyClose;

  /// No description provided for @notClose.
  ///
  /// In en, this message translates to:
  /// **'Not Close'**
  String get notClose;

  /// No description provided for @semiRefresh.
  ///
  /// In en, this message translates to:
  /// **'Semi-Refresh'**
  String get semiRefresh;

  /// No description provided for @fullyRefresh.
  ///
  /// In en, this message translates to:
  /// **'Fully Refresh'**
  String get fullyRefresh;

  /// No description provided for @partiallyRefresh.
  ///
  /// In en, this message translates to:
  /// **'Partially Refresh'**
  String get partiallyRefresh;

  /// No description provided for @completelyRefresh.
  ///
  /// In en, this message translates to:
  /// **'Completely Refresh'**
  String get completelyRefresh;

  /// No description provided for @notRefresh.
  ///
  /// In en, this message translates to:
  /// **'Not Refresh'**
  String get notRefresh;

  /// No description provided for @semiSort.
  ///
  /// In en, this message translates to:
  /// **'Semi-Sort'**
  String get semiSort;

  /// No description provided for @fullySort.
  ///
  /// In en, this message translates to:
  /// **'Fully Sort'**
  String get fullySort;

  /// No description provided for @partiallySort.
  ///
  /// In en, this message translates to:
  /// **'Partially Sort'**
  String get partiallySort;

  /// No description provided for @completelySort.
  ///
  /// In en, this message translates to:
  /// **'Completely Sort'**
  String get completelySort;

  /// No description provided for @notSort.
  ///
  /// In en, this message translates to:
  /// **'Not Sort'**
  String get notSort;

  /// No description provided for @semiFilter.
  ///
  /// In en, this message translates to:
  /// **'Semi-Filter'**
  String get semiFilter;

  /// No description provided for @fullyFilter.
  ///
  /// In en, this message translates to:
  /// **'Fully Filter'**
  String get fullyFilter;

  /// No description provided for @partiallyFilter.
  ///
  /// In en, this message translates to:
  /// **'Partially Filter'**
  String get partiallyFilter;

  /// No description provided for @completelyFilter.
  ///
  /// In en, this message translates to:
  /// **'Completely Filter'**
  String get completelyFilter;

  /// No description provided for @notFilter.
  ///
  /// In en, this message translates to:
  /// **'Not Filter'**
  String get notFilter;

  /// No description provided for @semiSearch.
  ///
  /// In en, this message translates to:
  /// **'Semi-Search'**
  String get semiSearch;

  /// No description provided for @fullySearch.
  ///
  /// In en, this message translates to:
  /// **'Fully Search'**
  String get fullySearch;

  /// No description provided for @partiallySearch.
  ///
  /// In en, this message translates to:
  /// **'Partially Search'**
  String get partiallySearch;

  /// No description provided for @completelySearch.
  ///
  /// In en, this message translates to:
  /// **'Completely Search'**
  String get completelySearch;

  /// No description provided for @notSearch.
  ///
  /// In en, this message translates to:
  /// **'Not Search'**
  String get notSearch;

  /// No description provided for @semiReset.
  ///
  /// In en, this message translates to:
  /// **'Semi-Reset'**
  String get semiReset;

  /// No description provided for @fullyReset.
  ///
  /// In en, this message translates to:
  /// **'Fully Reset'**
  String get fullyReset;

  /// No description provided for @partiallyReset.
  ///
  /// In en, this message translates to:
  /// **'Partially Reset'**
  String get partiallyReset;

  /// No description provided for @completelyReset.
  ///
  /// In en, this message translates to:
  /// **'Completely Reset'**
  String get completelyReset;

  /// No description provided for @notReset.
  ///
  /// In en, this message translates to:
  /// **'Not Reset'**
  String get notReset;

  /// No description provided for @semiSubmit.
  ///
  /// In en, this message translates to:
  /// **'Semi-Submit'**
  String get semiSubmit;

  /// No description provided for @fullySubmit.
  ///
  /// In en, this message translates to:
  /// **'Fully Submit'**
  String get fullySubmit;

  /// No description provided for @partiallySubmit.
  ///
  /// In en, this message translates to:
  /// **'Partially Submit'**
  String get partiallySubmit;

  /// No description provided for @completelySubmit.
  ///
  /// In en, this message translates to:
  /// **'Completely Submit'**
  String get completelySubmit;

  /// No description provided for @notSubmit.
  ///
  /// In en, this message translates to:
  /// **'Not Submit'**
  String get notSubmit;

  /// No description provided for @semiPrevious.
  ///
  /// In en, this message translates to:
  /// **'Semi-Previous'**
  String get semiPrevious;

  /// No description provided for @fullyPrevious.
  ///
  /// In en, this message translates to:
  /// **'Fully Previous'**
  String get fullyPrevious;

  /// No description provided for @partiallyPrevious.
  ///
  /// In en, this message translates to:
  /// **'Partially Previous'**
  String get partiallyPrevious;

  /// No description provided for @completelyPrevious.
  ///
  /// In en, this message translates to:
  /// **'Completely Previous'**
  String get completelyPrevious;

  /// No description provided for @notPrevious.
  ///
  /// In en, this message translates to:
  /// **'Not Previous'**
  String get notPrevious;

  /// No description provided for @semiNext.
  ///
  /// In en, this message translates to:
  /// **'Semi-Next'**
  String get semiNext;

  /// No description provided for @fullyNext.
  ///
  /// In en, this message translates to:
  /// **'Fully Next'**
  String get fullyNext;

  /// No description provided for @partiallyNext.
  ///
  /// In en, this message translates to:
  /// **'Partially Next'**
  String get partiallyNext;

  /// No description provided for @completelyNext.
  ///
  /// In en, this message translates to:
  /// **'Completely Next'**
  String get completelyNext;

  /// No description provided for @notNext.
  ///
  /// In en, this message translates to:
  /// **'Not Next'**
  String get notNext;

  /// No description provided for @semiBack.
  ///
  /// In en, this message translates to:
  /// **'Semi-Back'**
  String get semiBack;

  /// No description provided for @fullyBack.
  ///
  /// In en, this message translates to:
  /// **'Fully Back'**
  String get fullyBack;

  /// No description provided for @partiallyBack.
  ///
  /// In en, this message translates to:
  /// **'Partially Back'**
  String get partiallyBack;

  /// No description provided for @completelyBack.
  ///
  /// In en, this message translates to:
  /// **'Completely Back'**
  String get completelyBack;

  /// No description provided for @notBack.
  ///
  /// In en, this message translates to:
  /// **'Not Back'**
  String get notBack;

  /// No description provided for @semiUpdate.
  ///
  /// In en, this message translates to:
  /// **'Semi-Update'**
  String get semiUpdate;

  /// No description provided for @fullyUpdate.
  ///
  /// In en, this message translates to:
  /// **'Fully Update'**
  String get fullyUpdate;

  /// No description provided for @partiallyUpdate.
  ///
  /// In en, this message translates to:
  /// **'Partially Update'**
  String get partiallyUpdate;

  /// No description provided for @completelyUpdate.
  ///
  /// In en, this message translates to:
  /// **'Completely Update'**
  String get completelyUpdate;

  /// No description provided for @notUpdate.
  ///
  /// In en, this message translates to:
  /// **'Not Update'**
  String get notUpdate;

  /// No description provided for @semiCreate.
  ///
  /// In en, this message translates to:
  /// **'Semi-Create'**
  String get semiCreate;

  /// No description provided for @fullyCreate.
  ///
  /// In en, this message translates to:
  /// **'Fully Create'**
  String get fullyCreate;

  /// No description provided for @partiallyCreate.
  ///
  /// In en, this message translates to:
  /// **'Partially Create'**
  String get partiallyCreate;

  /// No description provided for @completelyCreate.
  ///
  /// In en, this message translates to:
  /// **'Completely Create'**
  String get completelyCreate;

  /// No description provided for @notCreate.
  ///
  /// In en, this message translates to:
  /// **'Not Create'**
  String get notCreate;

  /// No description provided for @semiEdit.
  ///
  /// In en, this message translates to:
  /// **'Semi-Edit'**
  String get semiEdit;

  /// No description provided for @fullyEdit.
  ///
  /// In en, this message translates to:
  /// **'Fully Edit'**
  String get fullyEdit;

  /// No description provided for @partiallyEdit.
  ///
  /// In en, this message translates to:
  /// **'Partially Edit'**
  String get partiallyEdit;

  /// No description provided for @completelyEdit.
  ///
  /// In en, this message translates to:
  /// **'Completely Edit'**
  String get completelyEdit;

  /// No description provided for @notEdit.
  ///
  /// In en, this message translates to:
  /// **'Not Edit'**
  String get notEdit;

  /// No description provided for @semiDelete.
  ///
  /// In en, this message translates to:
  /// **'Semi-Delete'**
  String get semiDelete;

  /// No description provided for @fullyDelete.
  ///
  /// In en, this message translates to:
  /// **'Fully Delete'**
  String get fullyDelete;

  /// No description provided for @partiallyDelete.
  ///
  /// In en, this message translates to:
  /// **'Partially Delete'**
  String get partiallyDelete;

  /// No description provided for @completelyDelete.
  ///
  /// In en, this message translates to:
  /// **'Completely Delete'**
  String get completelyDelete;

  /// No description provided for @notDelete.
  ///
  /// In en, this message translates to:
  /// **'Not Delete'**
  String get notDelete;

  /// No description provided for @semiSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Semi-Save Changes'**
  String get semiSaveChanges;

  /// No description provided for @fullySaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Fully Save Changes'**
  String get fullySaveChanges;

  /// No description provided for @partiallySaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Partially Save Changes'**
  String get partiallySaveChanges;

  /// No description provided for @completelySaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Completely Save Changes'**
  String get completelySaveChanges;

  /// No description provided for @notSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Not Save Changes'**
  String get notSaveChanges;

  /// No description provided for @semiWelcomeToBloodDonation.
  ///
  /// In en, this message translates to:
  /// **'Semi-Welcome to Blood Donation'**
  String get semiWelcomeToBloodDonation;

  /// No description provided for @fullyWelcomeToBloodDonation.
  ///
  /// In en, this message translates to:
  /// **'Fully Welcome to Blood Donation'**
  String get fullyWelcomeToBloodDonation;

  /// No description provided for @partiallyWelcomeToBloodDonation.
  ///
  /// In en, this message translates to:
  /// **'Partially Welcome to Blood Donation'**
  String get partiallyWelcomeToBloodDonation;

  /// No description provided for @completelyWelcomeToBloodDonation.
  ///
  /// In en, this message translates to:
  /// **'Completely Welcome to Blood Donation'**
  String get completelyWelcomeToBloodDonation;

  /// No description provided for @notWelcomeToBloodDonation.
  ///
  /// In en, this message translates to:
  /// **'Not Welcome to Blood Donation'**
  String get notWelcomeToBloodDonation;

  /// No description provided for @bloodType.
  ///
  /// In en, this message translates to:
  /// **'Blood Type'**
  String get bloodType;

  /// No description provided for @bloodGroup.
  ///
  /// In en, this message translates to:
  /// **'Blood Group'**
  String get bloodGroup;

  /// No description provided for @donor.
  ///
  /// In en, this message translates to:
  /// **'Donor'**
  String get donor;

  /// No description provided for @recipient.
  ///
  /// In en, this message translates to:
  /// **'Recipient'**
  String get recipient;

  /// No description provided for @hospital.
  ///
  /// In en, this message translates to:
  /// **'Hospital'**
  String get hospital;

  /// No description provided for @clinic.
  ///
  /// In en, this message translates to:
  /// **'Clinic'**
  String get clinic;

  /// No description provided for @medicalCenter.
  ///
  /// In en, this message translates to:
  /// **'Medical Center'**
  String get medicalCenter;

  /// No description provided for @healthCenter.
  ///
  /// In en, this message translates to:
  /// **'Health Center'**
  String get healthCenter;

  /// No description provided for @emergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get emergency;

  /// No description provided for @urgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get urgent;

  /// No description provided for @stable.
  ///
  /// In en, this message translates to:
  /// **'Stable'**
  String get stable;

  /// No description provided for @unstable.
  ///
  /// In en, this message translates to:
  /// **'Unstable'**
  String get unstable;

  /// No description provided for @healthy.
  ///
  /// In en, this message translates to:
  /// **'Healthy'**
  String get healthy;

  /// No description provided for @sick.
  ///
  /// In en, this message translates to:
  /// **'Sick'**
  String get sick;

  /// No description provided for @recovered.
  ///
  /// In en, this message translates to:
  /// **'Recovered'**
  String get recovered;

  /// No description provided for @healing.
  ///
  /// In en, this message translates to:
  /// **'Healing'**
  String get healing;

  /// No description provided for @treatment.
  ///
  /// In en, this message translates to:
  /// **'Treatment'**
  String get treatment;

  /// No description provided for @medication.
  ///
  /// In en, this message translates to:
  /// **'Medication'**
  String get medication;

  /// No description provided for @prescription.
  ///
  /// In en, this message translates to:
  /// **'Prescription'**
  String get prescription;

  /// No description provided for @diagnosis.
  ///
  /// In en, this message translates to:
  /// **'Diagnosis'**
  String get diagnosis;

  /// No description provided for @symptoms.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get symptoms;

  /// No description provided for @condition.
  ///
  /// In en, this message translates to:
  /// **'Condition'**
  String get condition;

  /// No description provided for @disease.
  ///
  /// In en, this message translates to:
  /// **'Disease'**
  String get disease;

  /// No description provided for @infection.
  ///
  /// In en, this message translates to:
  /// **'Infection'**
  String get infection;

  /// No description provided for @injury.
  ///
  /// In en, this message translates to:
  /// **'Injury'**
  String get injury;

  /// No description provided for @wound.
  ///
  /// In en, this message translates to:
  /// **'Wound'**
  String get wound;

  /// No description provided for @pain.
  ///
  /// In en, this message translates to:
  /// **'Pain'**
  String get pain;

  /// No description provided for @fever.
  ///
  /// In en, this message translates to:
  /// **'Fever'**
  String get fever;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @pressure.
  ///
  /// In en, this message translates to:
  /// **'Pressure'**
  String get pressure;

  /// No description provided for @heartRate.
  ///
  /// In en, this message translates to:
  /// **'Heart Rate'**
  String get heartRate;

  /// No description provided for @bloodPressure.
  ///
  /// In en, this message translates to:
  /// **'Blood Pressure'**
  String get bloodPressure;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @postalCode.
  ///
  /// In en, this message translates to:
  /// **'Postal Code'**
  String get postalCode;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// No description provided for @landline.
  ///
  /// In en, this message translates to:
  /// **'Landline'**
  String get landline;

  /// No description provided for @emergencyContact.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contact'**
  String get emergencyContact;

  /// No description provided for @relationship.
  ///
  /// In en, this message translates to:
  /// **'Relationship'**
  String get relationship;

  /// No description provided for @spouse.
  ///
  /// In en, this message translates to:
  /// **'Spouse'**
  String get spouse;

  /// No description provided for @parent.
  ///
  /// In en, this message translates to:
  /// **'Parent'**
  String get parent;

  /// No description provided for @child.
  ///
  /// In en, this message translates to:
  /// **'Child'**
  String get child;

  /// No description provided for @sibling.
  ///
  /// In en, this message translates to:
  /// **'Sibling'**
  String get sibling;

  /// No description provided for @friend.
  ///
  /// In en, this message translates to:
  /// **'Friend'**
  String get friend;

  /// No description provided for @colleague.
  ///
  /// In en, this message translates to:
  /// **'Colleague'**
  String get colleague;

  /// No description provided for @neighbor.
  ///
  /// In en, this message translates to:
  /// **'Neighbor'**
  String get neighbor;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @middleName.
  ///
  /// In en, this message translates to:
  /// **'Middle Name'**
  String get middleName;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @nationalId.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get nationalId;

  /// No description provided for @passportNumber.
  ///
  /// In en, this message translates to:
  /// **'Passport Number'**
  String get passportNumber;

  /// No description provided for @driversLicense.
  ///
  /// In en, this message translates to:
  /// **'Driver\'s License'**
  String get driversLicense;

  /// No description provided for @occupation.
  ///
  /// In en, this message translates to:
  /// **'Occupation'**
  String get occupation;

  /// No description provided for @employer.
  ///
  /// In en, this message translates to:
  /// **'Employer'**
  String get employer;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @maritalStatus.
  ///
  /// In en, this message translates to:
  /// **'Marital Status'**
  String get maritalStatus;

  /// No description provided for @single.
  ///
  /// In en, this message translates to:
  /// **'Single'**
  String get single;

  /// No description provided for @married.
  ///
  /// In en, this message translates to:
  /// **'Married'**
  String get married;

  /// No description provided for @divorced.
  ///
  /// In en, this message translates to:
  /// **'Divorced'**
  String get divorced;

  /// No description provided for @widowed.
  ///
  /// In en, this message translates to:
  /// **'Widowed'**
  String get widowed;

  /// No description provided for @separated.
  ///
  /// In en, this message translates to:
  /// **'Separated'**
  String get separated;

  /// No description provided for @bloodDonationHistory.
  ///
  /// In en, this message translates to:
  /// **'Blood Donation History'**
  String get bloodDonationHistory;

  /// No description provided for @lastDonation.
  ///
  /// In en, this message translates to:
  /// **'Last Donation'**
  String get lastDonation;

  /// No description provided for @donationCount.
  ///
  /// In en, this message translates to:
  /// **'Donation Count'**
  String get donationCount;

  /// No description provided for @eligibilityStatus.
  ///
  /// In en, this message translates to:
  /// **'Eligibility Status'**
  String get eligibilityStatus;

  /// No description provided for @eligible.
  ///
  /// In en, this message translates to:
  /// **'Eligible'**
  String get eligible;

  /// No description provided for @notEligible.
  ///
  /// In en, this message translates to:
  /// **'Not Eligible'**
  String get notEligible;

  /// No description provided for @temporarilyIneligible.
  ///
  /// In en, this message translates to:
  /// **'Temporarily Ineligible'**
  String get temporarilyIneligible;

  /// No description provided for @permanentlyIneligible.
  ///
  /// In en, this message translates to:
  /// **'Permanently Ineligible'**
  String get permanentlyIneligible;

  /// No description provided for @medicalConditions.
  ///
  /// In en, this message translates to:
  /// **'Medical Conditions'**
  String get medicalConditions;

  /// No description provided for @allergies.
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get allergies;

  /// No description provided for @medications.
  ///
  /// In en, this message translates to:
  /// **'Medications'**
  String get medications;

  /// No description provided for @pregnancyStatus.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy Status'**
  String get pregnancyStatus;

  /// No description provided for @pregnant.
  ///
  /// In en, this message translates to:
  /// **'Pregnant'**
  String get pregnant;

  /// No description provided for @notPregnant.
  ///
  /// In en, this message translates to:
  /// **'Not Pregnant'**
  String get notPregnant;

  /// No description provided for @recentSurgery.
  ///
  /// In en, this message translates to:
  /// **'Recent Surgery'**
  String get recentSurgery;

  /// No description provided for @tattooOrPiercing.
  ///
  /// In en, this message translates to:
  /// **'Tattoo or Piercing'**
  String get tattooOrPiercing;

  /// No description provided for @travelHistory.
  ///
  /// In en, this message translates to:
  /// **'Travel History'**
  String get travelHistory;

  /// No description provided for @recentTravel.
  ///
  /// In en, this message translates to:
  /// **'Recent Travel'**
  String get recentTravel;

  /// No description provided for @noRecentTravel.
  ///
  /// In en, this message translates to:
  /// **'No Recent Travel'**
  String get noRecentTravel;

  /// No description provided for @appointmentDetails.
  ///
  /// In en, this message translates to:
  /// **'Appointment Details'**
  String get appointmentDetails;

  /// No description provided for @appointmentStatus.
  ///
  /// In en, this message translates to:
  /// **'Appointment Status'**
  String get appointmentStatus;

  /// No description provided for @appointmentLocation.
  ///
  /// In en, this message translates to:
  /// **'Appointment Location'**
  String get appointmentLocation;

  /// No description provided for @appointmentNotes.
  ///
  /// In en, this message translates to:
  /// **'Appointment Notes'**
  String get appointmentNotes;

  /// No description provided for @eventDetails.
  ///
  /// In en, this message translates to:
  /// **'Event Details'**
  String get eventDetails;

  /// No description provided for @eventType.
  ///
  /// In en, this message translates to:
  /// **'Event Type'**
  String get eventType;

  /// No description provided for @eventOrganizer.
  ///
  /// In en, this message translates to:
  /// **'Event Organizer'**
  String get eventOrganizer;

  /// No description provided for @eventCapacity.
  ///
  /// In en, this message translates to:
  /// **'Event Capacity'**
  String get eventCapacity;

  /// No description provided for @eventAttendees.
  ///
  /// In en, this message translates to:
  /// **'Event Attendees'**
  String get eventAttendees;

  /// No description provided for @eventRegistration.
  ///
  /// In en, this message translates to:
  /// **'Event Registration'**
  String get eventRegistration;

  /// No description provided for @eventRegistrationRequired.
  ///
  /// In en, this message translates to:
  /// **'Registration Required'**
  String get eventRegistrationRequired;

  /// No description provided for @eventRegistrationOptional.
  ///
  /// In en, this message translates to:
  /// **'Registration Optional'**
  String get eventRegistrationOptional;

  /// No description provided for @eventRegistrationClosed.
  ///
  /// In en, this message translates to:
  /// **'Registration Closed'**
  String get eventRegistrationClosed;

  /// No description provided for @eventRegistrationOpen.
  ///
  /// In en, this message translates to:
  /// **'Registration Open'**
  String get eventRegistrationOpen;

  /// No description provided for @eventRegistrationFull.
  ///
  /// In en, this message translates to:
  /// **'Registration Full'**
  String get eventRegistrationFull;

  /// No description provided for @eventRegistrationLimited.
  ///
  /// In en, this message translates to:
  /// **'Registration Limited'**
  String get eventRegistrationLimited;

  /// No description provided for @eventRegistrationUnlimited.
  ///
  /// In en, this message translates to:
  /// **'Registration Unlimited'**
  String get eventRegistrationUnlimited;

  /// No description provided for @eventRegistrationDeadline.
  ///
  /// In en, this message translates to:
  /// **'Registration Deadline'**
  String get eventRegistrationDeadline;

  /// No description provided for @eventRegistrationStart.
  ///
  /// In en, this message translates to:
  /// **'Registration Start'**
  String get eventRegistrationStart;

  /// No description provided for @eventRegistrationEnd.
  ///
  /// In en, this message translates to:
  /// **'Registration End'**
  String get eventRegistrationEnd;

  /// No description provided for @eventRegistrationFee.
  ///
  /// In en, this message translates to:
  /// **'Registration Fee'**
  String get eventRegistrationFee;

  /// No description provided for @eventRegistrationFree.
  ///
  /// In en, this message translates to:
  /// **'Registration Free'**
  String get eventRegistrationFree;

  /// No description provided for @eventRegistrationPaid.
  ///
  /// In en, this message translates to:
  /// **'Registration Paid'**
  String get eventRegistrationPaid;

  /// No description provided for @eventRegistrationDiscount.
  ///
  /// In en, this message translates to:
  /// **'Registration Discount'**
  String get eventRegistrationDiscount;

  /// No description provided for @eventRegistrationEarlyBird.
  ///
  /// In en, this message translates to:
  /// **'Early Bird Registration'**
  String get eventRegistrationEarlyBird;

  /// No description provided for @eventRegistrationLate.
  ///
  /// In en, this message translates to:
  /// **'Late Registration'**
  String get eventRegistrationLate;

  /// No description provided for @eventRegistrationOnSite.
  ///
  /// In en, this message translates to:
  /// **'On-Site Registration'**
  String get eventRegistrationOnSite;

  /// No description provided for @eventRegistrationOnline.
  ///
  /// In en, this message translates to:
  /// **'Online Registration'**
  String get eventRegistrationOnline;

  /// No description provided for @eventRegistrationPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Registration'**
  String get eventRegistrationPhone;

  /// No description provided for @eventRegistrationEmail.
  ///
  /// In en, this message translates to:
  /// **'Email Registration'**
  String get eventRegistrationEmail;

  /// No description provided for @eventRegistrationInPerson.
  ///
  /// In en, this message translates to:
  /// **'In-Person Registration'**
  String get eventRegistrationInPerson;

  /// No description provided for @eventRegistrationMail.
  ///
  /// In en, this message translates to:
  /// **'Mail Registration'**
  String get eventRegistrationMail;

  /// No description provided for @eventRegistrationFax.
  ///
  /// In en, this message translates to:
  /// **'Fax Registration'**
  String get eventRegistrationFax;

  /// No description provided for @eventRegistrationWeb.
  ///
  /// In en, this message translates to:
  /// **'Web Registration'**
  String get eventRegistrationWeb;

  /// No description provided for @eventRegistrationMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile Registration'**
  String get eventRegistrationMobile;

  /// No description provided for @eventRegistrationApp.
  ///
  /// In en, this message translates to:
  /// **'App Registration'**
  String get eventRegistrationApp;

  /// No description provided for @eventRegistrationPortal.
  ///
  /// In en, this message translates to:
  /// **'Portal Registration'**
  String get eventRegistrationPortal;

  /// No description provided for @eventRegistrationSystem.
  ///
  /// In en, this message translates to:
  /// **'System Registration'**
  String get eventRegistrationSystem;

  /// No description provided for @eventRegistrationPlatform.
  ///
  /// In en, this message translates to:
  /// **'Platform Registration'**
  String get eventRegistrationPlatform;

  /// No description provided for @eventRegistrationService.
  ///
  /// In en, this message translates to:
  /// **'Service Registration'**
  String get eventRegistrationService;

  /// No description provided for @eventRegistrationProvider.
  ///
  /// In en, this message translates to:
  /// **'Provider Registration'**
  String get eventRegistrationProvider;

  /// No description provided for @eventRegistrationVendor.
  ///
  /// In en, this message translates to:
  /// **'Vendor Registration'**
  String get eventRegistrationVendor;

  /// No description provided for @eventRegistrationPartner.
  ///
  /// In en, this message translates to:
  /// **'Partner Registration'**
  String get eventRegistrationPartner;

  /// No description provided for @eventRegistrationSponsor.
  ///
  /// In en, this message translates to:
  /// **'Sponsor Registration'**
  String get eventRegistrationSponsor;

  /// No description provided for @eventRegistrationHost.
  ///
  /// In en, this message translates to:
  /// **'Host Registration'**
  String get eventRegistrationHost;

  /// No description provided for @eventRegistrationCoordinator.
  ///
  /// In en, this message translates to:
  /// **'Coordinator Registration'**
  String get eventRegistrationCoordinator;

  /// No description provided for @eventRegistrationManager.
  ///
  /// In en, this message translates to:
  /// **'Manager Registration'**
  String get eventRegistrationManager;

  /// No description provided for @eventRegistrationAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin Registration'**
  String get eventRegistrationAdmin;

  /// No description provided for @eventRegistrationStaff.
  ///
  /// In en, this message translates to:
  /// **'Staff Registration'**
  String get eventRegistrationStaff;

  /// No description provided for @eventRegistrationVolunteer.
  ///
  /// In en, this message translates to:
  /// **'Volunteer Registration'**
  String get eventRegistrationVolunteer;

  /// No description provided for @eventRegistrationParticipant.
  ///
  /// In en, this message translates to:
  /// **'Participant Registration'**
  String get eventRegistrationParticipant;

  /// No description provided for @eventRegistrationGuest.
  ///
  /// In en, this message translates to:
  /// **'Guest Registration'**
  String get eventRegistrationGuest;

  /// No description provided for @eventRegistrationVisitor.
  ///
  /// In en, this message translates to:
  /// **'Visitor Registration'**
  String get eventRegistrationVisitor;

  /// No description provided for @eventRegistrationMember.
  ///
  /// In en, this message translates to:
  /// **'Member Registration'**
  String get eventRegistrationMember;

  /// No description provided for @eventRegistrationUser.
  ///
  /// In en, this message translates to:
  /// **'User Registration'**
  String get eventRegistrationUser;

  /// No description provided for @eventRegistrationClient.
  ///
  /// In en, this message translates to:
  /// **'Client Registration'**
  String get eventRegistrationClient;

  /// No description provided for @eventRegistrationCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer Registration'**
  String get eventRegistrationCustomer;

  /// No description provided for @eventRegistrationPatient.
  ///
  /// In en, this message translates to:
  /// **'Patient Registration'**
  String get eventRegistrationPatient;

  /// No description provided for @eventRegistrationDonor.
  ///
  /// In en, this message translates to:
  /// **'Donor Registration'**
  String get eventRegistrationDonor;

  /// No description provided for @eventRegistrationRecipient.
  ///
  /// In en, this message translates to:
  /// **'Recipient Registration'**
  String get eventRegistrationRecipient;

  /// No description provided for @eventRegistrationBeneficiary.
  ///
  /// In en, this message translates to:
  /// **'Beneficiary Registration'**
  String get eventRegistrationBeneficiary;

  /// No description provided for @eventRegistrationStakeholder.
  ///
  /// In en, this message translates to:
  /// **'Stakeholder Registration'**
  String get eventRegistrationStakeholder;

  /// No description provided for @eventRegistrationShareholder.
  ///
  /// In en, this message translates to:
  /// **'Shareholder Registration'**
  String get eventRegistrationShareholder;

  /// No description provided for @eventRegistrationInvestor.
  ///
  /// In en, this message translates to:
  /// **'Investor Registration'**
  String get eventRegistrationInvestor;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr', 'rw'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
    case 'rw': return AppLocalizationsRw();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
