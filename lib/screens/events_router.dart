import 'package:blood_system/blocs/auth/bloc.dart';
import 'package:blood_system/blocs/auth/state.dart';
import 'package:blood_system/screens/events/events.dart';
import 'package:blood_system/screens/events/user_events.dart';
import 'package:blood_system/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsRouter extends StatelessWidget {
  const EventsRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is AuthAuthenticated) {
          // Get user email and role
          final userEmail = authState.firebaseUser.email ?? '';
          final userRole = authState.userData?.role ?? 'USER'; // Default to USER if no role

          // Route to appropriate screen based on role
          return userRole == 'HOSPITAL_ADMIN'
              ? const EventsScreen() // Admin screen with full management capabilities
              : const UserEventsScreen(); // User screen with view-only capabilities
        }
        
        // If not authenticated, redirect to login
        return const LoginPage();
      },
    );
  }
} 