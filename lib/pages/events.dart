import 'package:flutter/material.dart';
import 'create_event.dart';

class EventsScreen extends StatelessWidget {
  EventsScreen({super.key});

  final List<String> dates = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final List<Map<String, String>> events = [
    {
      'title': 'Blood Drive',
      'location': 'City Hospital',
      'date': 'Mon, 10:00 AM',
    },
    {
      'title': 'Community Health Fair',
      'location': 'Community Center',
      'date': 'Wed, 2:00 PM',
    },
    {
      'title': 'Staff Appreciation',
      'location': 'Main Hall',
      'date': 'Fri, 1:00 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double headerHeight = MediaQuery.of(context).size.height * 0.16;
    final bool isSmallScreen = MediaQuery.of(context).size.width < 400;
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
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
                // Background image
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
                // Semi-transparent red overlay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    color: Color(0xFFD7263D).withOpacity(0.4),
                  ),
                ),
                // Title and add button
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
                Positioned(
                  right: isSmallScreen ? 16 : 24,
                  top: headerHeight * 0.32,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CreateEventScreen()),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16.0 : 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  SizedBox(
                    height: 48,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: dates.length,
                      separatorBuilder: (_, __) => SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: index == 0 ? Color(0xFFD7263D) : Color(0xFFF2F3F7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            dates[index],
                            style: TextStyle(
                              color: index == 0 ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                      itemCount: events.length,
                      separatorBuilder: (_, __) => SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final event = events[index];
                        return Container(
                          padding: EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.08),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event['title']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isSmallScreen ? 16 : 18,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                event['location']!,
                                style: TextStyle(
                                  color: Colors.blueGrey[400],
                                  fontSize: isSmallScreen ? 13 : 15,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                event['date']!,
                                style: TextStyle(
                                  color: Colors.red[300],
                                  fontSize: isSmallScreen ? 13 : 15,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
