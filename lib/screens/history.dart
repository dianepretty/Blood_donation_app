import 'package:blood_system/blocs/appointment/bloc.dart';
import 'package:blood_system/blocs/appointment/event.dart';
import 'package:blood_system/blocs/appointment/state.dart';
import 'package:blood_system/screens/appointments/user_appointmentDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/auth/bloc.dart';
import '../blocs/auth/state.dart';
import '../widgets/main_navigation.dart';

// class HistoryPage extends StatelessWidget {
//   const HistoryPage({super.key});

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
      currentPage: 'history',
      pageTitle: 'Donation History',
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
        ],
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, Map<String, String> donation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  donation['date']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    donation['status']!,
                    style: const TextStyle(
                      color: Color(0xFF4CAF50),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.local_hospital,
                  color: const Color(0xFFB83A3A),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    donation['hospital']!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.bloodtype, color: const Color(0xFFB83A3A), size: 20),
                const SizedBox(width: 8),
                Text(
                  'Blood Type: ${donation['bloodType']!}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(width: 24),
                Icon(
                  Icons.water_drop,
                  color: const Color(0xFFB83A3A),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Amount: ${donation['amount']!}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    // View donation details
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Donation details coming soon!'),
                        backgroundColor: Color(0xFFB83A3A),
                      ),
                    );
                  },
                  icon: const Icon(Icons.info_outline, size: 16),
                  label: const Text('View Details'),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFB83A3A),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
