import 'package:blood_system/blocs/appointment/bloc.dart';
import 'package:blood_system/blocs/auth/bloc.dart';
import 'package:blood_system/blocs/auth/event.dart';
import 'package:blood_system/blocs/auth/state.dart';
import 'package:blood_system/blocs/hospital/bloc.dart';
import 'package:blood_system/screens/appointments_router.dart';
import 'package:blood_system/screens/userDetails.dart';
import 'package:blood_system/screens/appointments/book_appointment.dart';
import 'package:blood_system/screens/hospitalAdminRegister.dart';
import 'package:blood_system/screens/landing.dart';
import 'package:blood_system/screens/volunteerRegister.dart';
import 'package:blood_system/screens/welcomepage.dart';
import 'package:blood_system/service/appointment_service.dart';
import 'package:blood_system/service/hospital_service.dart';
import 'package:blood_system/service/user_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'package:blood_system/screens/home.dart';
import 'package:blood_system/screens/login.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          create: (context) => AppointmentBloc(
              appointmentService: AppointmentService(),
              hospitalService: HospitalService()
            ),
        ),
      ],
      child: MaterialApp(
        title: 'Blood Donation App',
        debugShowCheckedModeBanner: false,
        home: const AuthWrapper(),
        routes: {
          '/landing': (context) => const LandingPage(),
          '/home': (context) => const HomePage(),
          '/hospitalAdminRegister': (context) => const HospitalAdminRegister(),
          '/volunteerRegister': (context) => const VolunteerRegister(),
          '/userDetails': (context) => const UserDetailsPage(),
          '/appointments': (context) => const AppointmentsRouter(),
          '/login': (context) => const LoginPage(),
          '/events': (context) => const Welcomepage(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // Debug: Print the current state
        print('AuthWrapper - Current state: ${state.runtimeType}');

        if (state is AuthAuthenticated) {
          // User is logged in, check role and navigate accordingly
          final userRole = state.userData?.role?.toUpperCase();
          final originalRole = state.userData?.role;
          print('AuthWrapper - Original role: "$originalRole"');
          print('AuthWrapper - Uppercase role: "$userRole"');
          print('AuthWrapper - User data: ${state.userData?.toJson()}');

          if (userRole == 'VOLUNTEER' || originalRole == 'Volunteer') {
            print('AuthWrapper - Navigating to HomePage');
            return const HomePage();
          } else if (userRole == 'HOSPITAL_ADMIN' ||
              originalRole == 'Hospital admin' ||
              originalRole == 'HOSPITAL_ADMIN') {
            print('AuthWrapper - Navigating to UserDetailsPage');
            return const AppointmentsRouter(); // User details page for hospital admin
          } else {
            // Unknown role, go to landing page
            print(
              'AuthWrapper - Unknown role: "$originalRole", navigating to LandingPage',
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
          // Loading state, show loading indicator
          print('AuthWrapper - Loading state');
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          // Other states, show loading indicator
          print('AuthWrapper - Other state: ${state.runtimeType}');
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
