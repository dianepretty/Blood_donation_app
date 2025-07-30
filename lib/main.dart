import 'package:blood_system/blocs/appointment/bloc.dart';
import 'package:blood_system/blocs/appointment/event.dart';
import 'package:blood_system/blocs/auth/bloc.dart';
import 'package:blood_system/blocs/auth/event.dart';
import 'package:blood_system/blocs/auth/state.dart';
import 'package:blood_system/blocs/event_bloc.dart';
import 'package:blood_system/blocs/event_event.dart';
import 'package:blood_system/blocs/hospital/bloc.dart';
import 'package:blood_system/blocs/language/bloc.dart';
import 'package:blood_system/screens/FAQScreen.dart';
import 'package:blood_system/screens/appointments_router.dart';
import 'package:blood_system/screens/email_verification.dart';
import 'package:blood_system/screens/events/events.dart';
import 'package:blood_system/screens/history.dart';
import 'package:blood_system/screens/notificationScreen.dart';
import 'package:blood_system/screens/profile.dart';
import 'package:blood_system/screens/securityScreen.dart';
import 'package:blood_system/screens/language_selection.dart';
import 'package:blood_system/screens/events_router.dart';
import 'package:blood_system/screens/userDetails.dart';
import 'package:blood_system/screens/appointments/book_appointment.dart';
import 'package:blood_system/screens/hospitalAdminRegister.dart';
import 'package:blood_system/screens/landing.dart';
import 'package:blood_system/screens/volunteerRegister.dart';
import 'package:blood_system/screens/welcomepage.dart';
import 'package:blood_system/service/appointment_service.dart';
import 'package:blood_system/service/event_service.dart';
import 'package:blood_system/service/hospital_service.dart';
import 'package:blood_system/service/user_service.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:blood_system/l10n/app_localizations.dart';
import 'package:blood_system/l10n/kinyarwanda_localizations.dart';
import 'package:blood_system/l10n/comprehensive_localizations.dart';
import 'package:blood_system/l10n/custom_material_delegate.dart';
import 'firebase_options.dart';
import 'package:blood_system/screens/home.dart';
import 'package:blood_system/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final EventService _eventService = EventService();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HospitalBloc(hospitalService: HospitalService()),
        ),
        BlocProvider(
          create:
              (context) =>
                  AuthBloc(authService: AuthService())..add(AuthStarted()),
        ),
        BlocProvider(
          create:
              (context) => AppointmentBloc(
                appointmentService: AppointmentService(),
                hospitalService: HospitalService(),
              ),
        ),
        BlocProvider(
          create:
              (context) =>
                  EventBloc(_eventService, eventService: _eventService)
                    ..add(LoadEvents()),
        ),
        BlocProvider(
          create: (context) => LanguageBloc()..add(LanguageLoaded()),
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, languageState) {
          return MaterialApp(
            title: 'Blood Donation App',
            debugShowCheckedModeBanner: false,
            locale:
                languageState is LanguageLoadedState
                    ? languageState.locale
                    : const Locale('en'),
            supportedLocales: const [
              Locale('en'), // English
              Locale('fr'), // French
              Locale('rw'), // Kinyarwanda
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              // Check if the current device locale is supported
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode) {
                  return supportedLocale;
                }
              }
              // If the current device locale is not supported, use English as fallback
              return const Locale('en');
            },

            localizationsDelegates: const [
              AppLocalizations.delegate,
              CustomMaterialLocalizationsDelegate(),
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const AuthWrapper(),
            routes: {
              '/landing': (context) => const LandingPage(),
              '/home': (context) => const HomePageContent(),
              '/hospitalAdminRegister':
                  (context) => const HospitalAdminRegister(),
              '/volunteerRegister': (context) => const VolunteerRegister(),
              '/userDetails': (context) => const UserDetailsPage(),
              '/appointments': (context) => const AppointmentsRouter(),
              '/login': (context) => const LoginPage(),
              '/events': (context) => const EventsScreen(),
              '/notifications': (context) => const NotificationsScreen(),
              '/faq': (context) => const FAQScreen(),
              '/settings': (context) => const SecurityScreen(),
              '/language': (context) => const LanguageSelectionScreen(),
              '/events': (context) => const EventsRouter(),
              '/profile': (context) => const ProfilePage(),
              '/history': (context) => const HistoryPage(),
            },
          );
        },
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  Timer? _timeoutTimer;

  @override
  void initState() {
    super.initState();
    // Set a timeout to prevent infinite loading
    _timeoutTimer = Timer(const Duration(seconds: 30), () {
      if (mounted) {
        print(
          'AuthWrapper - Timeout reached, forcing navigation to landing page',
        );
        Navigator.of(context).pushReplacementNamed('/landing');
      }
    });
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // Cancel timeout when we get a definitive state
        if (state is AuthAuthenticated || state is AuthUnauthenticated) {
          _timeoutTimer?.cancel();
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          // Debug: Print the current state
          print('AuthWrapper - Current state: ${state.runtimeType}');

          if (state is AuthAuthenticated) {
            // User is logged in, check role and navigate accordingly
            final userRole = state.userData?.role;
            print('AuthWrapper - User role: "$userRole"');
            print('AuthWrapper - User data: ${state.userData?.toJson()}');

            if (userRole == 'VOLUNTEER') {
              print('AuthWrapper - Navigating to HomePage');
              return const HomePageContent();
            } else if (userRole == 'HOSPITAL_ADMIN') {
              print('AuthWrapper - Navigating to EventsPage');
              return const EventsRouter(); // Events page for hospital admin
            } else {
              // Unknown role, go to landing page
              print(
                'AuthWrapper - Unknown role: "$userRole", navigating to LandingPage',
              );
              return const LandingPage();
            }
          } else if (state is AuthUnauthenticated) {
            // User is not logged in, show landing page
            print(
              'AuthWrapper - User not authenticated, navigating to LandingPage',
            );
            return const LandingPage();
          } else if (state is AuthLoading) {
            // Loading state, show loading indicator with timeout
            print('AuthWrapper - Loading state');
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      'Loading...',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Other states, show loading indicator
            print('AuthWrapper - Other state: ${state.runtimeType}');
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      'Initializing...',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
