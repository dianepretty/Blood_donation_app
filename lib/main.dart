import 'package:blood_system/blocs/hospital/bloc.dart';
import 'package:blood_system/screens/appointments/book_appointment.dart';
import 'package:blood_system/screens/home.dart';
import 'package:blood_system/screens/hospitalAdminRegister.dart';
import 'package:blood_system/screens/landing.dart';
import 'package:blood_system/screens/welcomepage.dart';
import 'package:blood_system/service/hospital_service.dart';
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
      ],
      child: MaterialApp(
        title: 'Blood Donation App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/landing',
        routes: {
          '/landing': (context) => const LandingPage(),
          '/home': (context) => const HomePage(),
          '/hospitalAdminRegister': (context) => const HospitalAdminRegister(),
          '/appointments': (context) => const BookAppointmentScreen(),
        },
      ),
    );
  }
}