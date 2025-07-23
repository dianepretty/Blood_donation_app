import 'package:blood_system/blocs/auth/bloc.dart';
import 'package:blood_system/blocs/auth/event.dart';
import 'package:blood_system/blocs/hospital/bloc.dart';
import 'package:blood_system/screens/login.dart';
import 'package:blood_system/screens/userDetails.dart';
import 'package:blood_system/screens/appointments/book_appointment.dart';
import 'package:blood_system/screens/home.dart';
import 'package:blood_system/screens/hospitalAdminRegister.dart';
import 'package:blood_system/screens/landing.dart';
import 'package:blood_system/screens/volunteerRegister.dart';
import 'package:blood_system/screens/welcomepage.dart';
import 'package:blood_system/service/hospital_service.dart';
import 'package:blood_system/service/user_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

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
      ],
      child: MaterialApp(
        title: 'Blood Donation App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/landing',
        routes: {
          '/landing': (context) => const LandingPage(),
          '/home': (context) => const HomePage(),
          '/hospitalAdminRegister': (context) => const HospitalAdminRegister(),
          '/volunteerRegister': (context) => const VolunteerRegister(),
          '/userDetails': (context) => const UserDetailsPage(),
          '/appointments': (context) => const BookAppointmentScreen(),
          '/login': (context) => const LoginPage(),
        },
      ),
    );
  }
}
