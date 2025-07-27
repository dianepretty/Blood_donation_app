import 'package:flutter/material.dart';
import '../widgets/red_header.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final List<Map<String, String>> events = [
    {
      'title': 'Hospital Gala',
      'desc': 'Join us for a night of celebration and fundraising.',
    },
    {
      'title': 'Community Health Fair',
      'desc': 'Promoting health and wellness in our community.',
    },
    {
      'title': 'Staff Appreciation Day',
      'desc': 'Recognizing the hard work of our staff.',
    },
  ];

  final List<Map<String, String>> appointments = [
    {'name': 'Dr. Anya Sharma', 'specialty': 'Cardiology', 'time': '10:00 AM'},
    {'name': 'Dr. Ben Carter', 'specialty': 'Neurology', 'time': '2:30 PM'},
    {'name': 'Dr. Chloe Davis', 'specialty': 'Pediatrics', 'time': '4:00 PM'},
  ];

  final List<Map<String, dynamic>> statistics = [
    {
      'label': 'Events',
      'value': '12',
      'color': Colors.blue,
      'icon': Icons.event,
    },
    {
      'label': 'Appointments',
      'value': '8',
      'color': Colors.orange,
      'icon': Icons.calendar_today,
    },
    {
      'label': 'Donors',
      'value': '150',
      'color': Colors.green,
      'icon': Icons.people,
    },
    {
      'label': 'Patients',
      'value': '245',
      'color': Colors.purple,
      'icon': Icons.person,
    },
    {
      'label': 'Revenue',
      'value': '12K',
      'color': Colors.teal,
      'icon': Icons.attach_money,
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
          RedHeader(
            title: 'Dashboard',
            height: headerHeight,
            showSettings: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 16.0 : 24.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Overview', isSmallScreen),
                    SizedBox(height: 16),
                    _buildStatisticsSection(context, isSmallScreen),
                    SizedBox(height: 32),
                    _buildSectionTitle('Upcoming Events', isSmallScreen),
                    SizedBox(height: 16),
                    _buildEventsSection(isSmallScreen),
                    SizedBox(height: 32),
                    _buildSectionTitle(
                      'Pending Appointment Requests',
                      isSmallScreen,
                    ),
                    SizedBox(height: 16),
                    _buildAppointmentsSection(isSmallScreen),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  

  Widget _buildSectionTitle(String title, bool isSmallScreen) {
    return Text(
      title,
      style: TextStyle(
        fontSize: isSmallScreen ? 20 : 24,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildStatisticsSection(BuildContext context, bool isSmallScreen) {
    return SizedBox(
      height: isSmallScreen ? 130 : 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: statistics.length,
        separatorBuilder: (_, __) => SizedBox(width: 16),
        itemBuilder: (context, index) {
          final stat = statistics[index];
          return _buildStatCard(
            stat['label'],
            stat['value'],
            stat['color'],
            stat['icon'],
            isSmallScreen,
          );
        },
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    Color color,
    IconData icon,
    bool isSmallScreen,
  ) {
    return Container(
      width: isSmallScreen ? 120 : 140,
      padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 16 : 20),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: isSmallScreen ? 20 : 24),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isSmallScreen ? 18 : 20,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: isSmallScreen ? 12 : 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsSection(bool isSmallScreen) {
    return SizedBox(
      height: isSmallScreen ? 140 : 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        separatorBuilder: (_, __) => SizedBox(width: 16),
        itemBuilder: (context, index) {
          final event = events[index];
          return Container(
            width: isSmallScreen ? 240 : 280,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE53E3E).withOpacity(0.1),
                  Color(0xFFD53F8C).withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xFFE53E3E).withOpacity(0.2)),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFE53E3E).withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.event,
                        color: Color(0xFFE53E3E),
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        event['title']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen ? 16 : 18,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  event['desc']!,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: isSmallScreen ? 13 : 14,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppointmentsSection(bool isSmallScreen) {
    return Column(
      children:
          appointments.map((appointment) {
            return Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFE53E3E), Color(0xFFD53F8C)],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: isSmallScreen ? 24 : 28,
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: isSmallScreen ? 24 : 28,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment['name']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 15 : 16,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          appointment['specialty']!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: isSmallScreen ? 13 : 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFFE53E3E).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      appointment['time']!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: isSmallScreen ? 12 : 13,
                        color: Color(0xFFE53E3E),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
