
import 'package:blood_system/screens/appointments/appointments.dart';
import 'package:blood_system/screens/appointments/user_appointments.dart';
import 'package:flutter/material.dart';

class AppointmentsRouter extends StatelessWidget {
  const AppointmentsRouter({super.key});

  @override
  Widget build(BuildContext context) {
    // Simple dummy user - change this to test different screens
    String userRole = 'ADMIN'; // Change to 'ADMIN' to test admin screen
    
    // Simple condition to route to correct screen
    return userRole == 'VOLUNTEER' 
        ? const UserAppointmentsScreen() 
        : const AppointmentsScreen();
  }
}

// class AppointmentsRouter extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         if (state is AuthAuthenticated) {
//           return state.user.role == 'ADMIN' 
//             ? AdminAppointments() 
//             : UserAppointments();
//         }
//         return LoginScreen(); // If not authenticated
//       },
//     );
//   }