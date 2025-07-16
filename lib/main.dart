<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
import 'package:blood_system/blocs/hospital/bloc.dart';
import 'package:blood_system/screens/home.dart';
import 'package:blood_system/screens/hospitalAdminRegister.dart';
import 'package:blood_system/screens/landing.dart';
import 'package:blood_system/screens/welcomepage.dart';
import 'package:blood_system/service/hospital_service.dart';
=======
import 'package:blood_system/screens/volunteerRegister.dart';
import 'package:blood_system/screens/welcomepage.dart';
>>>>>>> c28ded0 (add: routes)
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
=======
import 'package:blood_system/screens/appointments.dart';
=======
import 'package:blood_system/screens/appointments/appointments.dart';
import 'package:blood_system/screens/appointments_router.dart';
>>>>>>> 2bf3f36 (feat: volunteer appointments)
import 'package:blood_system/screens/volunteerRegister.dart';
import 'package:blood_system/screens/welcomepage.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'firebase_options.dart';
>>>>>>> 4156bc3 (feat: appointments screen admin)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
<<<<<<< HEAD
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
=======
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(MyApp());
>>>>>>> c28ded0 (add: routes)
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
        },
      ),
=======
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false
,
      // home: Placeholder()
      initialRoute: '/appointments',
      routes: {
        '/': (context) => Welcomepage(),
         '/registration': (context) => VolunteerRegister(),
<<<<<<< HEAD
         '/appointments': (context) => AppointmentsScreen(),
      },
>>>>>>> c28ded0 (add: routes)
=======
        '/appointments': (context) => AppointmentsRouter(),      },
>>>>>>> 2bf3f36 (feat: volunteer appointments)
    );
  }
}
