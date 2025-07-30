import 'package:blood_system/blocs/appointment/bloc.dart';
import 'package:blood_system/blocs/appointment/event.dart';
import 'package:blood_system/blocs/appointment/state.dart';
import 'package:blood_system/blocs/auth/bloc.dart';
import 'package:blood_system/blocs/auth/event.dart';
import 'package:blood_system/blocs/auth/state.dart';
import 'package:blood_system/screens/appointments/ViewAppointment.dart';
import 'package:blood_system/widgets/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  DateTime? fromDate;
  DateTime? toDate;
  Map<String, Map<String, dynamic>> userDataCache = {};

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekStart = today.subtract(Duration(days: today.weekday - 1));
    final weekEnd = weekStart.add(Duration(days: 6));
    fromDate = weekStart;
    toDate = weekEnd;

    // Load appointments when screen initializes
    _loadAppointments();
  }

  void _loadAppointments() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated && authState.userData != null) {
      // For hospital admin, use the district name as hospital name
      print("user hospital name: ${authState.userData?.hospital}");
      final hospitalName = authState.userData!.hospital;

      // Use the date filter event instead of the basic load event
      context.read<AppointmentBloc>().add(
        LoadAdminAppointmentsWithDateFilter(
          hospitalName: hospitalName,
          fromDate: fromDate,
          toDate: toDate,
        ),
      );
    }
  }

  // Remove the local filtering method since we're now filtering at the bloc level
  Map<String, dynamic> _appointmentToMap(dynamic appointment) {
    return {
      'id': appointment.id,
      'userId': appointment.userId,
      'hospitalName': appointment.hospitalName,
      'appointmentDate': appointment.appointmentDate,
      'appointmentTime': appointment.appointmentTime,
    };
  }

  @override
  Widget build(BuildContext context) {
    return MainNavigationWrapper(
      currentPage: 'appointments',
      pageTitle: 'Appointments',
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateSelector(),
                  const SizedBox(height: 20),
                  _buildAppointmentsList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select dates',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildDateField('From', fromDate)),
            const SizedBox(width: 12),
            Expanded(child: _buildDateField('To', toDate)),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _loadAppointments,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD7263D),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Apply Filter',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(String label, DateTime? date) {
    return GestureDetector(
      onTap: () => _selectDate(label.toLowerCase()),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    date != null
                        ? DateFormat('MMM d, yyyy').format(date)
                        : 'Select date',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          date != null ? Colors.black87 : Colors.grey.shade500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate(String type) async {
    final date = await showDatePicker(
      context: context,
      initialDate:
          type == 'from'
              ? (fromDate ?? DateTime.now())
              : (toDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFD7263D),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        if (type == 'from') {
          fromDate = date;
          if (toDate != null && toDate!.isBefore(date)) {
            toDate = date;
          }
        } else {
          toDate = date;
          if (fromDate != null && fromDate!.isAfter(date)) {
            fromDate = date;
          }
        }
      });

      _loadAppointments();
    }
  }

  Widget _buildAppointmentsList() {
    return Expanded(
      child: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          if (state.status == AppointmentStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFD7263D)),
            );
          }

          if (state.status == AppointmentStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading appointments',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.errorMessage ?? 'Unknown error occurred',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadAppointments,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD7263D),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final appointments =
              state.appointments.map((apt) => _appointmentToMap(apt)).toList();

          if (appointments.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No appointments found',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No appointments scheduled for the selected date range',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              _loadAppointments();
            },
            color: const Color(0xFFD7263D),
            child: ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return _buildAppointmentCard(appointment);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    final userId = appointment['userId'] as String;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUserDataLoaded && state.userId == userId) {
          setState(() {
            userDataCache[userId] = {
              'fullName': state.userData?.fullName ?? 'Unknown User',
              'phoneNumber': state.userData?.phoneNumber ?? 'N/A',
              'bloodType': state.userData?.bloodType ?? 'N/A',
              'email': state.userData?.email ?? 'N/A',
            };
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
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
        child: _buildCardContent(appointment, userId),
      ),
    );
  }

  Widget _buildCardContent(Map<String, dynamic> appointment, String userId) {
    // Check if user data is cached
    final userData = userDataCache[userId];

    // If not cached, trigger the event to load user data
    if (userData == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<AuthBloc>().add(AuthGetUserDataRequested(userId));
      });
    }

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.person, color: Color(0xFFD7263D), size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User: ${userData?['fullName'] ?? 'Loading...'}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${appointment['appointmentTime']} - Blood Donation',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
              const SizedBox(height: 2),
              Text(
                appointment['hospitalName'],
                style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
              ),
              const SizedBox(height: 2),
              Text(
                DateFormat(
                  'MMM d, yyyy',
                ).format(appointment['appointmentDate']),
                style: TextStyle(
                  color: const Color(0xFFD7263D),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (userData != null) ...[
                const SizedBox(height: 2),
                Text(
                  'Blood Type: ${userData['bloodType']}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            // Create enhanced appointment data with user info
            final enhancedAppointment = Map<String, dynamic>.from(appointment);
            if (userData != null) {
              enhancedAppointment.addAll(userData);
            }

            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (context) => AppointmentDetailsScreen(
                      appointment: enhancedAppointment,
                    ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFD7263D).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'View Details',
              style: TextStyle(
                color: const Color(0xFFD7263D),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
