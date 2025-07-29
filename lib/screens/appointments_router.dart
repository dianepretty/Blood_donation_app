// appointments_router.dart
import 'package:blood_system/blocs/appointment/bloc.dart';
import 'package:blood_system/blocs/auth/bloc.dart';
import 'package:blood_system/blocs/auth/state.dart';
import 'package:blood_system/screens/appointments/appointments.dart';
import 'package:blood_system/screens/appointments/user_appointments.dart';
import 'package:blood_system/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentsRouter extends StatelessWidget {
  const AppointmentsRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is AuthAuthenticated) {
          // Get user email and role
          final userEmail = authState.firebaseUser.email ?? '';
          final userRole = authState.userData?.role ?? 'USER'; // Default to USER if no role

          // Load appointments based on role when widget builds
         

          // Route to appropriate screen based on role
          return userRole == 'HOSPITAL_ADMIN'
              ? const AppointmentsScreen() // Admin screen
              : const UserAppointmentsScreen(); // User screen
        }
        
        // If not authenticated, redirect to login
        return const LoginPage();
      },
    );
  }
}