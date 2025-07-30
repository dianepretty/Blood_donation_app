import 'package:blood_system/blocs/event_bloc.dart';
import 'package:blood_system/blocs/event_event.dart';
import 'package:blood_system/blocs/event_state.dart';
import 'package:blood_system/models/event_model.dart';
import 'package:blood_system/screens/events/create_event.dart';
import 'package:blood_system/widgets/main_navigation.dart';
import 'package:blood_system/blocs/auth/bloc.dart';
import 'package:blood_system/blocs/auth/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'view_event.dart';
import 'edit_event.dart';

class EventsScreen extends StatefulWidget {
  final VoidCallback? onBackToDashboard;
  const EventsScreen({super.key, this.onBackToDashboard});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  PickerDateRange? selectedDateRange;

  @override
  void initState() {
    super.initState();
    // Set initial date range to one year
    final now = DateTime.now();
    final yearStart = DateTime(now.year, 1, 1); // January 1st of current year
    final yearEnd = DateTime(now.year, 12, 31); // December 31st of current year
    selectedDateRange = PickerDateRange(yearStart, yearEnd);

    // Load events when screen initializes
    _loadEvents();
  }

  void _loadEvents() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      final userRole = authState.userData?.role ?? 'USER';
      final hospitalName = authState.userData?.districtName ?? '';

      if (userRole == 'HOSPITAL_ADMIN' && hospitalName.isNotEmpty) {
        // For hospital admin, only show events for their hospital
        if (selectedDateRange != null &&
            selectedDateRange!.startDate != null &&
            selectedDateRange!.endDate != null) {
          context.read<EventBloc>().add(
            LoadEventsByHospitalAndDateRange(
              hospitalName,
              selectedDateRange!.startDate!,
              selectedDateRange!.endDate!,
            ),
          );
        } else {
          context.read<EventBloc>().add(LoadEventsByHospital(hospitalName));
        }
      } else {
        // For other users, show all events
        if (selectedDateRange != null &&
            selectedDateRange!.startDate != null &&
            selectedDateRange!.endDate != null) {
          context.read<EventBloc>().add(
            LoadEventsByDateRange(
              selectedDateRange!.startDate!,
              selectedDateRange!.endDate!,
            ),
          );
        } else {
          context.read<EventBloc>().add(LoadEvents());
        }
      }
    }
  }

  void onDateRangeChanged(PickerDateRange? newDateRange) {
    setState(() {
      selectedDateRange = newDateRange;
    });
    // Reload events with new date range
    _loadEvents();
  }

  List<Event> _filterEvents(List<Event> events) {
    if (selectedDateRange == null) {
      print(
        'DEBUG: No date range selected, showing all ${events.length} events',
      );
      return events;
    }
    final start = selectedDateRange!.startDate;
    final end = selectedDateRange!.endDate ?? selectedDateRange!.startDate;
    final filtered =
        events.where((event) {
          return !event.date.isBefore(start!) && !event.date.isAfter(end!);
        }).toList();
    print(
      'DEBUG: Filtered ${events.length} events to ${filtered.length} events (range: ${start} to ${end})',
    );
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return MainNavigationWrapper(
      currentPage: 'events',
      pageTitle: 'Events',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateEventScreen()),
          ).then((_) {
            // Refresh events when returning from create screen
            _loadEvents();
          });
        },
        backgroundColor: const Color(0xFFD7263D),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Create Event'),
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState is AuthAuthenticated) {
            return BlocConsumer<EventBloc, EventState>(
              listener: (context, eventState) {
                if (eventState is EventError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(eventState.message),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                } else if (eventState is EventOperationSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(eventState.message),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                  // Refresh events after successful operation
                  _loadEvents();
                }
              },
              builder: (context, eventState) {
                if (eventState is EventLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFFD7263D)),
                  );
                }

                List<Event> events = [];
                if (eventState is EventLoaded) {
                  events = eventState.events;
                } else if (eventState is EventError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error loading events',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          eventState.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: _loadEvents,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retry'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD7263D),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final filteredList = _filterEvents(events);

                return Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 16.0 : 24.0,
                          vertical: 16.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDateRangeSelector(isSmallScreen),
                                ),
                                if (selectedDateRange != null)
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedDateRange = null;
                                      });
                                      _loadEvents();
                                    },
                                    icon: const Icon(Icons.clear),
                                    tooltip: 'Clear filter',
                                  ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Events count and refresh button
                            Row(
                              children: [
                                Text(
                                  '${filteredList.length} event${filteredList.length != 1 ? 's' : ''} found',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: _loadEvents,
                                  icon: const Icon(Icons.refresh),
                                  tooltip: 'Refresh events',
                                  color: const Color(0xFFD7263D),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            _buildEventsList(filteredList, isSmallScreen),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.login, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Please log in to view events',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateRangeSelector(bool isSmallScreen) {
    String rangeText = 'Select Date Range';
    if (selectedDateRange != null && selectedDateRange!.startDate != null) {
      final start = selectedDateRange!.startDate!;
      final end = selectedDateRange!.endDate ?? selectedDateRange!.startDate!;
      final formatter = DateFormat('MMM d, yyyy');

      // Check if it's a full year range
      if (start.year == end.year &&
          start.month == 1 &&
          start.day == 1 &&
          end.month == 12 &&
          end.day == 31) {
        rangeText = '${start.year} (Full Year)';
      } else {
        rangeText = '${formatter.format(start)} - ${formatter.format(end)}';
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date Range',
          style: TextStyle(
            fontSize: isSmallScreen ? 16 : 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            await showDialog(
              context: context,
              builder:
                  (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SfDateRangePicker(
                        view: DateRangePickerView.month,
                        selectionMode: DateRangePickerSelectionMode.range,
                        initialSelectedRange: selectedDateRange,
                        selectionColor: const Color(0xFFD7263D),
                        rangeSelectionColor: const Color(
                          0xFFD7263D,
                        ).withOpacity(0.1),
                        startRangeSelectionColor: const Color(0xFFD7263D),
                        endRangeSelectionColor: const Color(0xFFD7263D),
                        todayHighlightColor: const Color(
                          0xFFD7263D,
                        ).withOpacity(0.3),
                        onSelectionChanged: (
                          DateRangePickerSelectionChangedArgs args,
                        ) {
                          if (args.value is PickerDateRange) {
                            onDateRangeChanged(args.value);
                            Navigator.of(context).pop();
                          }
                        },
                        showActionButtons: true,
                        cancelText: 'Cancel',
                        confirmText: 'Apply',
                        onCancel: () => Navigator.of(context).pop(),
                        onSubmit: (val) {
                          if (val is PickerDateRange) {
                            onDateRangeChanged(val);
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                  ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.date_range,
                  color: const Color(0xFFD7263D),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    rangeText,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(Icons.expand_more, color: Colors.grey[600]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEventsList(List<Event> events, bool isSmallScreen) {
    return Expanded(
      child:
          events.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_busy, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No events found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try adjusting your date range or create a new event',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ),
              )
              : RefreshIndicator(
                onRefresh: () async {
                  _loadEvents();
                },
                color: const Color(0xFFD7263D),
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: events.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return _buildEventCard(event, isSmallScreen);
                  },
                ),
              ),
    );
  }

  Widget _buildEventCard(Event event, bool isSmallScreen) {
    final eventTypeColor = const Color(0xFFD7263D);
    final statusColor = _getStatusColor(event.status);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: eventTypeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.event, color: eventTypeColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isSmallScreen ? 16 : 18,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      event.location,
                      style: TextStyle(
                        color: Colors.blueGrey[400],
                        fontSize: isSmallScreen ? 13 : 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  event.status.toUpperCase(),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 6),
              Text(
                DateFormat('MMM d, yyyy').format(event.date),
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: isSmallScreen ? 12 : 14,
                ),
              ),
              if (event.timeFrom.isNotEmpty && event.timeTo.isNotEmpty) ...[
                const SizedBox(width: 16),
                Icon(Icons.schedule, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 6),
                Text(
                  '${event.timeFrom} - ${event.timeTo}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: isSmallScreen ? 12 : 14,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewEventScreen(event: event),
                      ),
                    );
                  },
                  icon: const Icon(Icons.visibility, size: 16),
                  label: const Text('View Details'),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditEventScreen(event: event),
                      ),
                    ).then((_) {
                      // Refresh events when returning from edit screen
                      _loadEvents();
                    });
                  },
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Edit Event'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD7263D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'upcoming':
        return Colors.blue;
      case 'completed':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
