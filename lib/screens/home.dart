import 'package:blood_system/screens/appointments/book_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../models/appointment_model.dart';
import '../blocs/appointment/bloc.dart'; // Import AppointmentBloc
import '../blocs/appointment/event.dart'; // Import AppointmentEvent
import '../blocs/appointment/state.dart'; // Import AppointmentState
import '../blocs/event_bloc.dart'; // Import EventBloc
import '../blocs/event_event.dart'; // Import EventEvent
import '../blocs/event_state.dart'; // Import EventState
import '../blocs/auth/bloc.dart'; // Import AuthBloc
import '../blocs/auth/state.dart'; // Import AuthState
import '../models/event_model.dart'; // Import EventModel
import '../widgets/main_navigation.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  void initState() {
    super.initState();
    // Load appointments when the page initializes
    _loadUserAppointments();
  }

  void _loadUserAppointments() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<AppointmentBloc>().add(
        LoadUserAppointments(authState.firebaseUser.uid),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainNavigationWrapper(
      pageTitle: 'Home',
      currentPage: '/home',
      child: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _loadUserAppointments();
                context.read<EventBloc>().add(RefreshEvents());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Upcoming appointments section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Upcoming appointments',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333),
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFFB83A3A),
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              child: const Text('view more'),
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pushNamed('/appointments');
                              },
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.arrow_forward,
                              color: Color(0xFFB83A3A),
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Appointments section with BlocBuilder
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

                        if (state.status == AppointmentStatus.success) {
                          // Filter upcoming appointments (future dates only)
                          final upcomingAppointments =
                              state.appointments
                                  .where(
                                    (appointment) =>
                                        appointment.appointmentDate.isAfter(
                                          DateTime.now(),
                                        ) ||
                                        _isToday(appointment.appointmentDate),
                                  )
                                  .toList();

                          // Sort by date (earliest first)
                          upcomingAppointments.sort(
                            (a, b) =>
                                a.appointmentDate.compareTo(b.appointmentDate),
                          );

                          if (upcomingAppointments.isEmpty) {
                            return _buildEmptyAppointmentsState();
                          }

                          return Column(
                            children:
                                upcomingAppointments
                                    .take(3) // Show only first 3 appointments
                                    .map(
                                      (appointment) => Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 12,
                                        ),
                                        child: _buildAppointmentCard(
                                          appointment,
                                        ),
                                      ),
                                    )
                                    .toList(),
                          );
                        }

                        return _buildEmptyAppointmentsState();
                      },
                    ),

                    const SizedBox(height: 32),

                    // Events section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Events',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333),
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              'view more',
                              style: TextStyle(
                                color: Color(0xFFB83A3A),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.arrow_forward,
                              color: Color(0xFFB83A3A),
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Event cards (using BlocBuilder for events)
                    BlocBuilder<EventBloc, EventState>(
                      builder: (context, state) {
                        if (state is EventLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFFB83A3A),
                            ),
                          );
                        }

                        if (state is EventError) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 64,
                                  color: Colors.red[300],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Error: ${state.message}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<EventBloc>().add(LoadEvents());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFB83A3A),
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          );
                        }

                        if (state is EventLoaded) {
                          final events = state.events;

                          if (events.isEmpty) {
                            return _buildEmptyState('No upcoming events');
                          } else {
                            return Column(
                              children:
                                  events
                                      .take(3)
                                      .map(
                                        (event) => Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 12,
                                          ),
                                          child: _buildEventCard(event),
                                        ),
                                      )
                                      .toList(),
                            );
                          }
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  Widget _buildAppointmentCard(Appointment appointment) {
    final dateFormatter = DateFormat('MMM d, yyyy');
    final timeFormatter = DateFormat('h:mm a');
    final formattedDate = dateFormatter.format(appointment.appointmentDate);

    // Parse appointment time if it's a string, otherwise use it directly
    String displayTime = appointment.appointmentTime;

    // Check if today, tomorrow, or future
    final now = DateTime.now();
    final appointmentDate = appointment.appointmentDate;
    String dateLabel;

    if (_isToday(appointmentDate)) {
      dateLabel = 'Today';
    } else if (_isTomorrow(appointmentDate)) {
      dateLabel = 'Tomorrow';
    } else if (_isThisWeek(appointmentDate)) {
      dateLabel = DateFormat('EEEE').format(appointmentDate); // Day name
    } else {
      dateLabel = formattedDate;
    }

    return Container(
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
        child: Row(
          children: [
            // Hospital icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F4FD),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.local_hospital,
                color: Color(0xFF4A90E2),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),

            // Appointment details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Blood Donation',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    appointment.hospitalName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF666666),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$dateLabel at $displayTime',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Status indicator or action button
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color:
                        _isToday(appointmentDate)
                            ? Colors.orange.withOpacity(0.1)
                            : const Color(0xFFB83A3A).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _isToday(appointmentDate) ? 'Today' : 'Upcoming',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color:
                          _isToday(appointmentDate)
                              ? Colors.orange[700]
                              : const Color(0xFFB83A3A),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/appointments');
                  },
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xFFB83A3A),
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
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

  bool _isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  bool _isThisWeek(DateTime date) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return date.isAfter(startOfWeek) &&
        date.isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  Widget _buildLoadingState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
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
      child: const Center(
        child: CircularProgressIndicator(color: Color(0xFFB83A3A)),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
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
      child: Column(
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: Colors.red[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadUserAppointments,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB83A3A),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyAppointmentsState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
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
      child: Column(
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No upcoming appointments',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Book your next blood donation appointment',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final authState = context.read<AuthBloc>().state;
              if (authState is AuthAuthenticated) {
                final userId = authState.firebaseUser.uid;
                if (userId != null) {
                  // Navigate to booking appointment page
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (context) => BookAppointmentScreen(userId: userId),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB83A3A),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            ),
            child: const Text('Book Appointment'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
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
      child: Column(
        children: [
          Icon(Icons.event_outlined, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Event event) {
    final dateFormatter = DateFormat('MMM d, yyyy');
    final formattedDate = dateFormatter.format(event.date);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.description,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.location,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A90E2),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'view details',
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF888888),
                  ),
                ),
                Text(
                  '${event.timeFrom} - ${event.timeTo}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF888888),
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
