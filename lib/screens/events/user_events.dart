import 'package:blood_system/blocs/event_bloc.dart';
import 'package:blood_system/blocs/event_event.dart';
import 'package:blood_system/blocs/event_state.dart';
import 'package:blood_system/models/event_model.dart';
import 'package:blood_system/widgets/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'view_event.dart';

class UserEventsScreen extends StatefulWidget {
  const UserEventsScreen({super.key});

  @override
  State<UserEventsScreen> createState() => _UserEventsScreenState();
}

class _UserEventsScreenState extends State<UserEventsScreen> {
  PickerDateRange? selectedDateRange;
  String? selectedHospitalId;

  @override
  void initState() {
    super.initState();
    // Set initial date range to one year
    final now = DateTime.now();
    final yearStart = DateTime(now.year, 1, 1);
    final yearEnd = DateTime(now.year, 12, 31);
    selectedDateRange = PickerDateRange(yearStart, yearEnd);

    // Load events based on initial date range
    _loadEvents();
  }

  void _loadEvents() {
    final eventBloc = context.read<EventBloc>();

    if (selectedHospitalId != null && selectedDateRange != null) {
      // Load by hospital and date range
      eventBloc.add(
        LoadEventsByHospitalAndDateRange(
          selectedHospitalId!,
          selectedDateRange!.startDate!,
          selectedDateRange!.endDate ?? selectedDateRange!.startDate!,
        ),
      );
    } else if (selectedHospitalId != null) {
      // Load by hospital only
      eventBloc.add(LoadEventsByHospital(selectedHospitalId!));
    } else if (selectedDateRange != null) {
      // Load by date range only
      eventBloc.add(
        LoadEventsByDateRange(
          selectedDateRange!.startDate!,
          selectedDateRange!.endDate ?? selectedDateRange!.startDate!,
        ),
      );
    } else {
      // Load all events
      eventBloc.add(LoadEvents());
    }
  }

  void onDateRangeChanged(PickerDateRange? newDateRange) {
    setState(() {
      selectedDateRange = newDateRange;
    });
    _loadEvents();
  }

  void _clearDateFilter() {
    setState(() {
      selectedDateRange = null;
    });
    _loadEvents();
  }

  void _refreshEvents() {
    context.read<EventBloc>().add(RefreshEvents());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return MainNavigationWrapper(
      currentPage: 'events',
      pageTitle: 'Events',
      child: BlocConsumer<EventBloc, EventState>(
        listener: (context, state) {
          if (state is EventError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
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
                      // Filter Controls
                      Row(
                        children: [
                          Expanded(
                            child: _buildDateRangeSelector(isSmallScreen),
                          ),
                          if (selectedDateRange != null)
                            IconButton(
                              onPressed: _clearDateFilter,
                              icon: const Icon(Icons.clear),
                              tooltip: 'Clear date filter',
                            ),
                          IconButton(
                            onPressed: _refreshEvents,
                            icon: const Icon(Icons.refresh),
                            tooltip: 'Refresh events',
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Events List
                      _buildEventsContent(state, isSmallScreen),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEventsContent(EventState state, bool isSmallScreen) {
    if (state is EventLoading) {
      return const Expanded(child: Center(child: CircularProgressIndicator()));
    }

    if (state is EventError) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
              const SizedBox(height: 16),
              Text(
                'Error loading events',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                state.message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _loadEvents,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD7263D),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (state is EventLoaded) {
      return _buildEventsList(state.events, isSmallScreen);
    }

    // Handle other states or show empty state
    return const Expanded(child: Center(child: Text('No events available')));
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
                        onSelectionChanged: (
                          DateRangePickerSelectionChangedArgs args,
                        ) {
                          if (args.value is PickerDateRange) {
                            onDateRangeChanged(args.value);
                            Navigator.of(context).pop();
                          }
                        },
                        showActionButtons: true,
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
                const Icon(
                  Icons.date_range,
                  color: Color(0xFFD7263D),
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
                      'Try adjusting your date range filter',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
              )
              : RefreshIndicator(
                onRefresh: () async {
                  _refreshEvents();
                },
                child: ListView.separated(
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
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
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
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'upcoming':
        return Colors.orange;
      case 'ongoing':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
