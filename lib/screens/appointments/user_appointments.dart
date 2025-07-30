import 'package:blood_system/blocs/appointment/bloc.dart';
import 'package:blood_system/blocs/appointment/event.dart';
import 'package:blood_system/blocs/appointment/state.dart';
import 'package:blood_system/blocs/auth/bloc.dart';
import 'package:blood_system/blocs/auth/state.dart';
import 'package:blood_system/screens/appointments/book_appointment.dart';
import 'package:blood_system/screens/appointments/rescheduleAppointment.dart';
import 'package:blood_system/screens/appointments/user_appointmentDetails.dart';
import 'package:blood_system/widgets/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UserAppointmentsScreen extends StatefulWidget {
  const UserAppointmentsScreen({super.key});

  @override
  State<UserAppointmentsScreen> createState() => _UserAppointmentsScreenState();
}

class _UserAppointmentsScreenState extends State<UserAppointmentsScreen> {
  @override
  void initState() {
    super.initState();
    _loadUserAppointments();
  }

  void _loadUserAppointments() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      // Use the Firebase user ID to load appointments
      final userId = authState.firebaseUser.uid;
      print('UserAppointmentsScreen - User ID: $userId');
      if (userId != null) {
        context.read<AppointmentBloc>().add(LoadUserAppointments(userId));
      }
    }
  }

  // Fixed _appointmentToMap with null safety
  Map<String, dynamic> _appointmentToMap(dynamic appointment) {
    return {
      'id': appointment.id ?? '',
      'userId': appointment.userId ?? '',
      'hospitalName': appointment.hospitalName ?? 'Unknown Hospital',
      'appointmentDate': appointment.appointmentDate ?? DateTime.now(),
      'appointmentTime': appointment.appointmentTime ?? 'Unknown Time',
      // Keep some display-friendly fields for UI
      'type': 'Blood Donation',
      'location': appointment.hospitalName ?? 'Unknown Hospital',
      'date': appointment.appointmentDate ?? DateTime.now(),
      'time': appointment.appointmentTime ?? 'Unknown Time',
      'donationType': 'Blood Donation', // Added for reschedule screen
    };
  }

  @override
  Widget build(BuildContext context) {
    return MainNavigationWrapper(
      backgroundColor: const Color(0xFFF8F9FA),
      currentPage: '/userAppointments',
      pageTitle: 'My Appointments',
      child: Column(
        children: [
          Expanded(
            child: BlocListener<AppointmentBloc, AppointmentState>(
              listener: (context, state) {
                if (state.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage!),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                if (state.successMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.successMessage!),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUpcomingAppointments(),
                      const SizedBox(height: 24),
                      _buildAppointmentHistory(),
                      const SizedBox(
                        height: 80,
                      ), // Add space for floating button
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildBookAppointmentButton(),
    );
  }

  Widget _buildBookAppointmentButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: FloatingActionButton.extended(
        onPressed: () {
          final authState = context.read<AuthBloc>().state;
          if (authState is AuthAuthenticated) {
            final userId = authState.firebaseUser.uid;
            if (userId != null) {
              // Navigate to booking appointment page
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BookAppointmentScreen(userId: userId),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Unable to get user information'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          } else {
            // Handle case where user is not authenticated
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please log in to book an appointment'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        backgroundColor: const Color(0xFFD7263D),
        foregroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        icon: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.add, size: 20),
        ),
        label: const Text(
          'Book New Appointment',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildUpcomingAppointments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming appointments',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        BlocBuilder<AppointmentBloc, AppointmentState>(
          builder: (context, state) {
            if (state.status == AppointmentStatus.loading) {
              return _buildLoadingState();
            }

            if (state.status == AppointmentStatus.error) {
              return _buildErrorState(
                state.errorMessage ?? 'Failed to load appointments',
              );
            }

            final upcomingAppointments =
                state.upcomingAppointments
                    .map((apt) => _appointmentToMap(apt))
                    .toList();
            print(
              'UserAppointmentsScreen - Upcoming Appointments: $upcomingAppointments',
            );

            if (upcomingAppointments.isEmpty) {
              return _buildEmptyState('No upcoming appointments');
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: upcomingAppointments.length,
              itemBuilder: (context, index) {
                final appointment = upcomingAppointments[index];
                return _buildAppointmentCard(appointment, isUpcoming: true);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildAppointmentHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Appointment History',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        BlocBuilder<AppointmentBloc, AppointmentState>(
          builder: (context, state) {
            if (state.status == AppointmentStatus.loading) {
              return _buildLoadingState();
            }

            if (state.status == AppointmentStatus.error) {
              return _buildErrorState(
                state.errorMessage ?? 'Failed to load appointments',
              );
            }

            final pastAppointments =
                state.pastAppointments
                    .map((apt) => _appointmentToMap(apt))
                    .toList();

            if (pastAppointments.isEmpty) {
              return _buildEmptyState('No past appointments');
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pastAppointments.length,
              itemBuilder: (context, index) {
                final appointment = pastAppointments[index];
                return _buildAppointmentCard(appointment, isUpcoming: false);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Color(0xFFD7263D)),
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red.shade400),
            const SizedBox(height: 16),
            Text(
              'Error loading appointments',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadUserAppointments,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD7263D),
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.calendar_today, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(
    Map<String, dynamic> appointment, {
    required bool isUpcoming,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFD7263D).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.local_hospital,
                color: Color(0xFFD7263D),
                size: 30,
              ),
            ),
            title: Text(
              appointment['type'] ?? 'Blood Donation',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment['location'] ?? 'Unknown Hospital',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  appointment['date'] != null
                      ? DateFormat(
                        'EEEE, MMMM d, yyyy',
                      ).format(appointment['date'])
                      : 'Unknown Date',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  'Time: ${appointment['time'] ?? 'Unknown Time'}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                ),
              ],
            ),
            trailing: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => UserAppointmentDetailsScreen(
                          appointment: appointment,
                        ),
                  ),
                );
              },
              child: const Text(
                'see details...',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          if (isUpcoming) _buildAppointmentActions(appointment),
        ],
      ),
    );
  }

  Widget _buildAppointmentActions(Map<String, dynamic> appointment) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => RescheduleAppointmentScreen(
                          appointment: appointment,
                        ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD7263D),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Reschedule',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          // const SizedBox(width: 12),
          // Expanded(
          //   child: TextButton(
          //     onPressed: () {
          //       _showCancelDialog(appointment);
          //     },
          //     style: TextButton.styleFrom(
          //       padding: const EdgeInsets.symmetric(vertical: 12),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //     ),
          //     child: const Text(
          //       'Cancel',
          //       style: TextStyle(
          //         color: Colors.black87,
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void _showCancelDialog(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Cancel Appointment'),
            content: const Text(
              'Are you sure you want to cancel this appointment?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // TODO: Implement cancel appointment functionality
                  // _cancelAppointment(appointment);
                },
                child: const Text('Yes, Cancel'),
              ),
            ],
          ),
    );
  }
}
