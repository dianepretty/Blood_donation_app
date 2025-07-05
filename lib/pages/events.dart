import 'package:flutter/material.dart';
// import 'create_event.dart'; // Uncomment when create_event.dart is available

class EventsScreen extends StatelessWidget {
  EventsScreen({super.key});

  final List<String> dates = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final List<Map<String, String>> events = [
    {
      'title': 'Blood Drive',
      'location': 'City Hospital',
      'date': 'Mon, 10:00 AM',
      'type': 'Medical',
    },
    {
      'title': 'Community Health Fair',
      'location': 'Community Center',
      'date': 'Wed, 2:00 PM',
      'type': 'Community',
    },
    {
      'title': 'Staff Appreciation',
      'location': 'Main Hall',
      'date': 'Fri, 1:00 PM',
      'type': 'Internal',
    },
    {
      'title': 'Charity Fundraiser',
      'location': 'Hospital Auditorium',
      'date': 'Sat, 6:00 PM',
      'type': 'Fundraising',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double headerHeight = screenSize.height * 0.25;
    final bool isSmallScreen = screenSize.width < 400;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header Section
          _buildHeader(context, headerHeight, isSmallScreen),

          // Content Section
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16.0 : 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Filter Section
                  _buildDateFilter(isSmallScreen),
                  SizedBox(height: 24),

                  // Events List
                  Expanded(child: _buildEventsList(isSmallScreen)),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(context, isSmallScreen),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    double headerHeight,
    bool isSmallScreen,
  ) {
    return Container(
      width: double.infinity,
      height: headerHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE53E3E), Color(0xFFD53F8C)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // Background overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                color: Colors.black.withOpacity(0.1),
              ),
            ),

            // Header content
            Positioned(
              left: isSmallScreen ? 16 : 24,
              top: headerHeight * 0.35,
              child: Text(
                'Events',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 24 : 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Search icon
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
                  Icons.search,
                  color: Colors.white,
                  size: isSmallScreen ? 24 : 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateFilter(bool isSmallScreen) {
    return SizedBox(
      height: isSmallScreen ? 44 : 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        separatorBuilder: (_, __) => SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isSelected = index == 0; // First item selected by default
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 16 : 20,
              vertical: isSmallScreen ? 8 : 10,
            ),
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFFE53E3E) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                dates[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: isSmallScreen ? 13 : 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEventsList(bool isSmallScreen) {
    return ListView.separated(
      itemCount: events.length,
      separatorBuilder: (_, __) => SizedBox(height: 16),
      itemBuilder: (context, index) {
        final event = events[index];
        return _buildEventCard(event, isSmallScreen);
      },
    );
  }

  Widget _buildEventCard(Map<String, String> event, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFE53E3E).withOpacity(0.1),
                      Color(0xFFD53F8C).withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getEventIcon(event['type'] ?? ''),
                  color: Color(0xFFE53E3E),
                  size: isSmallScreen ? 20 : 24,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event['title']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isSmallScreen ? 16 : 18,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: isSmallScreen ? 14 : 16,
                          color: Colors.grey[500],
                        ),
                        SizedBox(width: 4),
                        Text(
                          event['location']!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: isSmallScreen ? 13 : 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: isSmallScreen ? 14 : 16,
                          color: Colors.grey[500],
                        ),
                        SizedBox(width: 4),
                        Text(
                          event['date']!,
                          style: TextStyle(
                            color: Color(0xFFE53E3E),
                            fontSize: isSmallScreen ? 13 : 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getEventTypeColor(
                    event['type'] ?? '',
                  ).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  event['type'] ?? '',
                  style: TextStyle(
                    color: _getEventTypeColor(event['type'] ?? ''),
                    fontSize: isSmallScreen ? 10 : 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getEventIcon(String type) {
    switch (type) {
      case 'Medical':
        return Icons.medical_services;
      case 'Community':
        return Icons.people;
      case 'Internal':
        return Icons.business;
      case 'Fundraising':
        return Icons.volunteer_activism;
      default:
        return Icons.event;
    }
  }

  Color _getEventTypeColor(String type) {
    switch (type) {
      case 'Medical':
        return Colors.blue;
      case 'Community':
        return Colors.green;
      case 'Internal':
        return Colors.orange;
      case 'Fundraising':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Widget _buildFloatingActionButton(BuildContext context, bool isSmallScreen) {
    return FloatingActionButton(
      backgroundColor: Color(0xFFE53E3E),
      elevation: 8,
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: isSmallScreen ? 24 : 28,
      ),
      onPressed: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => CreateEventScreen())
        // );
        // Show snackbar for demo purposes
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Create Event functionality would go here'),
            backgroundColor: Color(0xFFE53E3E),
          ),
        );
      },
    );
  }
}
