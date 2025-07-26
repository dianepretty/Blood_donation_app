import 'package:blood_system/blocs/auth/bloc.dart';
import 'package:blood_system/blocs/auth/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/appointment_bloc.dart';
import '../blocs/appointment_event.dart';
import '../blocs/appointment_state.dart';
import '../models/appointment_model.dart';
import '../blocs/event_bloc.dart'; // Import EventBloc
import '../blocs/event_event.dart'; // Import EventEvent
import '../blocs/event_state.dart'; // Import EventState
import '../models/event_model.dart'; // Import EventModel
import '../widgets/app_bar.dart';
import '../widgets/bottom_navigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppointmentBloc()..add(LoadAppointments()),
        ),
        BlocProvider(
          create:
              (context) => EventBloc()..add(LoadEvents()), // Provide EventBloc
        ),
      ],
      child: const HomePageContent(),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Header Section
          CustomAppBar(
            pageName: 'Home',
            onMenuPressed: () {
              // Handle menu press
              print('Menu pressed');
            },
            onNotificationPressed: () {
              // Handle notification press
              // print('Notification pressed');

              //navigate to login page
              Navigator.of(context).pushNamed('/login');
              context.read<AuthBloc>().add(AuthSignOutRequested());
            },
          ),

          // Content Section
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<AppointmentBloc>().add(RefreshAppointments());
                context.read<EventBloc>().add(
                  RefreshEvents(),
                ); // Refresh events
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
                            Text(
                              'view more',
                              style: TextStyle(
                                color: Color(0xFFB83A3A),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward,
                              color: Color(0xFFB83A3A),
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Appointment cards
                    BlocBuilder<AppointmentBloc, AppointmentState>(
                      builder: (context, state) {
                        if (state is AppointmentLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFFB83A3A),
                            ),
                          );
                        }

                        if (state is AppointmentError) {
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
                                    context.read<AppointmentBloc>().add(
                                      LoadAppointments(),
                                    );
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

                        if (state is AppointmentLoaded ||
                            state is AppointmentOperationSuccess) {
                          // Access upcomingAppointments from both states
                          final appointments =
                              state is AppointmentLoaded
                                  ? state.upcomingAppointments
                                  : (state as AppointmentOperationSuccess)
                                      .upcomingAppointments;

                          if (appointments.isEmpty) {
                            return _buildEmptyState('No upcoming appointments');
                          } else {
                            return Column(
                              children:
                                  appointments
                                      .take(2)
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
                        }
                        return const SizedBox.shrink();
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
                            Text(
                              'view more',
                              style: TextStyle(
                                color: Color(0xFFB83A3A),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
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

                        if (state is EventLoaded ||
                            state is EventOperationSuccess) {
                          final events =
                              state is EventLoaded
                                  ? state.events
                                  : (state as EventOperationSuccess).events;

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

      // Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavigation(
        currentPage: 'home',
        onTap: (index) {
          // Handle navigation based on index
          switch (index) {
            case 0:
              print('Navigate to Home');
              break;
            case 1:
              print('Navigate to History');
              break;
            case 2:
              print('Navigate to Profile');
              break;
          }
        },
      ),
    );
  }

  Widget _buildAppointmentCard(Appointment appointment) {
    final dateFormatter = DateFormat('M/d/yyyy');
    final formattedDate = dateFormatter.format(appointment.date);

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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.type,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    appointment.hospital,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF666666),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$formattedDate from ${appointment.timeFrom} to ${appointment.timeTo}', // Updated to use timeFrom and timeTo
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F4FD),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.local_hospital,
                color: Color(0xFF4A90E2),
                size: 32,
              ),
            ),
          ],
        ),
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
          Icon(
            Icons.calendar_today_outlined,
            size: 48,
            color: Colors.grey[400],
          ),
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

  // Removed _buildAppointmentCardOld as it's no longer used
  // Widget _buildAppointmentCardOld(String title, String hospital, String date) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(12),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 8,
  //           offset: const Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   title,
  //                   style: const TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w600,
  //                     color: Color(0xFF333333),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 4),
  //                 Text(
  //                   hospital,
  //                   style: const TextStyle(
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.w600,
  //                     color: Color(0xFF666666),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 4),
  //                 Text(
  //                   date,
  //                   style: const TextStyle(
  //                     fontSize: 14,
  //                     color: Color(0xFF888888),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             width: 80,
  //             height: 60,
  //             decoration: BoxDecoration(
  //               color: const Color(0xFFE8F4FD),
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             child: const Icon(
  //               Icons.local_hospital,
  //               color: Color(0xFF4A90E2),
  //               size: 32,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildEventCard(Event event) {
    // Updated to accept an Event object
    final dateFormatter = DateFormat('M/d/yyyy');
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
                    event.description, // Using description as the main title
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
                Text(
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
                  '${event.timeFrom} - ${event.timeTo}', // Displaying timeFrom and timeTo
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
