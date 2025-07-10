import 'package:blood/pages/create_event.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'view_event.dart';
import 'edit_event.dart';

class RedHeader extends StatelessWidget {
  final String title;
  final double? height;
  final VoidCallback? onBack;
  final bool showBack;
  final bool showSettings;
  const RedHeader({
    super.key,
    required this.title,
    this.height,
    this.onBack,
    this.showBack = false,
    this.showSettings = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = height ?? screenHeight * 0.18;
    final isSmallScreen = MediaQuery.of(context).size.width < 400;
    return Container(
      width: double.infinity,
      height: headerHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            child: Image.asset(
              'assets/images/header_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              color: Color(0xFFD7263D).withOpacity(0.7),
            ),
          ),
          if (showBack && onBack != null)
            Positioned(
              left: 16,
              top: 32,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                onPressed: onBack,
              ),
            ),
          Positioned(
            left: isSmallScreen ? 56 : 64,
            right: isSmallScreen ? 56 : 64,
            top: headerHeight * 0.35,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 24 : 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (showSettings)
            Positioned(
              right: isSmallScreen ? 16 : 24,
              top: headerHeight * 0.35,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                  size: isSmallScreen ? 24 : 28,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

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

  final List<Map<String, dynamic>> events = [
    {
      'title': 'Blood Drive',
      'location': 'City Hospital',
      'date': DateTime.now(),
      'type': 'medical',
      'attendees': 45,
      'status': 'upcoming',
    },
    {
      'title': 'Community Health Fair',
      'location': 'Community Center',
      'date': DateTime.now().add(Duration(days: 2)),
      'type': 'community',
      'attendees': 120,
      'status': 'active',
    },
    {
      'title': 'Staff Appreciation',
      'location': 'Main Hall',
      'date': DateTime.now().add(Duration(days: 4)),
      'type': 'social',
      'attendees': 80,
      'status': 'upcoming',
    },
  ];

  List<Map<String, dynamic>> get filteredEvents {
    if (selectedDateRange == null) return events;
    final start = selectedDateRange!.startDate;
    final end = selectedDateRange!.endDate ?? selectedDateRange!.startDate;
    return events.where((event) {
      final eventDate = event['date'] as DateTime;
      return !eventDate.isBefore(start!) && !eventDate.isAfter(end!);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          RedHeader(
            title: 'Events',
            onBack: widget.onBackToDashboard ?? () => Navigator.of(context).pop(),
            showBack: true,
            showSettings: false,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16.0 : 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildDateRangeSelector(isSmallScreen),
                  const SizedBox(height: 24),
                  _buildEventsList(isSmallScreen),
                ],
              ),
            ),
          ),
        ],
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
        Row(
          children: [
            Text(
              'Date Range',
              style: TextStyle(
                fontSize: isSmallScreen ? 18 : 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            Spacer(),
            Switch(
              value: doubleMonth,
              onChanged: (value) {
                setState(() {
                  doubleMonth = value;
                });
              },
              activeColor: const Color(0xFFD7263D),
            ),
            Text(
              'Double Month',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 12),
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

  Widget _buildEventsList(bool isSmallScreen) {
    final filteredList = filteredEvents;
    return Expanded(
      child: ListView.separated(
        itemCount: filteredList.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final event = filteredList[index];
          return _buildEventCard(event, isSmallScreen);
        },
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event, bool isSmallScreen) {
    final eventTypeColor = _getEventTypeColor(event['type']);
    final statusColor = _getStatusColor(event['status']);

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
                child: Icon(
                  _getEventTypeIcon(event['type']),
                  color: eventTypeColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isSmallScreen ? 16 : 18,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      event['location'],
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
                  event['status'].toString().toUpperCase(),
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
                DateFormat('MMM d, yyyy').format(event['date']),
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: isSmallScreen ? 12 : 14,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.people, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 6),
              Text(
                '${event['attendees']} attendees',
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
                        builder: (context) => ViewEventScreen(event: event),
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
                        builder: (context) => EditEventScreen(event: event),
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
