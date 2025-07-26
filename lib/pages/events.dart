import 'package:blood_system/pages/create_event.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'view_event.dart';
import 'edit_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event_model.dart';
import '../widgets/red_header.dart';



class EventsScreen extends StatefulWidget {
  final VoidCallback? onBackToDashboard;
  const EventsScreen({super.key, this.onBackToDashboard});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  PickerDateRange? selectedDateRange;
  bool doubleMonth = false;

  @override
  void initState() {
    super.initState();
    // Set initial date range to current week
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekStart = today.subtract(Duration(days: today.weekday - 1));
    final weekEnd = weekStart.add(Duration(days: 6));
    selectedDateRange = PickerDateRange(weekStart, weekEnd);
  }

  void onDateRangeChanged(PickerDateRange? newDateRange) {
    setState(() {
      selectedDateRange = newDateRange;
    });
  }

  List<Event> _filterEvents(List<Event> events) {
    if (selectedDateRange == null) return events;
    final start = selectedDateRange!.startDate;
    final end = selectedDateRange!.endDate ?? selectedDateRange!.startDate;
    return events.where((event) {
      return !event.date.isBefore(start!) && !event.date.isAfter(end!);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: RedHeader(
          title: 'Events',
          onBack: widget.onBackToDashboard ?? () => Navigator.of(context).pop(),
          showBack: true,
          showSettings: false,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection('events')
                .orderBy('date')
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final docs = snapshot.data?.docs ?? [];
          final events =
              docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return Event(
                  id: doc.id,
                  name: data['name'] ?? '',
                  type: data['type'] ?? 'other',
                  date: (data['date'] as Timestamp).toDate(),
                  timeFrom: data['timeFrom'] ?? '',
                  timeTo: data['timeTo'] ?? '',
                  location: data['location'] ?? '',
                  description: data['description'] ?? '',
                  attendees: data['attendees'] ?? 0,
                  status: data['status'] ?? 'upcoming',
                );
              }).toList();
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
                      _buildDateRangeSelector(isSmallScreen),
                      _buildEventsList(filteredList, isSmallScreen),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateEventScreen()),
          );
        },
        backgroundColor: const Color(0xFFD7263D),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Create Event'),
      ),
    );
  }

  Widget _buildDateRangeSelector(bool isSmallScreen) {
    String rangeText = 'Select Date Range';
    if (selectedDateRange != null && selectedDateRange!.startDate != null) {
      final start = selectedDateRange!.startDate!;
      final end = selectedDateRange!.endDate ?? selectedDateRange!.startDate!;
      final formatter = DateFormat('MMM d, yyyy');
      rangeText = '${formatter.format(start)} - ${formatter.format(end)}';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                        view:
                            doubleMonth
                                ? DateRangePickerView.month
                                : DateRangePickerView.month,
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
              ? const Center(child: Text('No events found.'))
              : ListView.separated(
                itemCount: events.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final event = events[index];
                  return _buildEventCard(event, isSmallScreen);
                },
              ),
    );
  }

  Widget _buildEventCard(Event event, bool isSmallScreen) {
    // You may need to adapt this to your new Event model fields
    final eventTypeColor = const Color(0xFFD7263D);
    final statusColor = Colors.orange; // Placeholder, adapt as needed

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
                  'UPCOMING',
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
              Icon(Icons.people, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 6),
              Text(
                '${event.attendees} attendees',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: isSmallScreen ? 12 : 14,
                ),
              ),
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
                        builder:
                            (context) => ViewEventScreen(
                              event: {
                                'id': event.id,
                                'title': event.name,
                                'location': event.location,
                                'date': event.date,
                                'type': event.type,
                                'attendees': event.attendees,
                                'status': event.status,
                                'description': event.description,
                              },
                            ),
                      ),
                    );
                  },
                  icon: Icon(Icons.visibility, size: 16),
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
                        builder:
                            (context) => EditEventScreen(
                              event: {
                                'id': event.id,
                                'title': event.name,
                                'location': event.location,
                                'date': event.date,
                                'type': event.type,
                                'attendees': event.attendees,
                                'status': event.status,
                                'description': event.description,
                              },
                            ),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit, size: 16),
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

  Color _getEventTypeColor(String type) {
    switch (type) {
      case 'medical':
        return const Color(0xFFD7263D);
      case 'community':
        return Colors.blue;
      case 'social':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return Colors.green;
      case 'upcoming':
        return Colors.orange;
      case 'completed':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  IconData _getEventTypeIcon(String type) {
    switch (type) {
      case 'medical':
        return Icons.local_hospital;
      case 'community':
        return Icons.group;
      case 'social':
        return Icons.celebration;
      default:
        return Icons.event;
    }
  }
}
