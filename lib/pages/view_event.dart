import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:blood/pages/events.dart';

class ViewEventScreen extends StatelessWidget {
  final Map<String, dynamic> event;
  const ViewEventScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 400;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          RedHeader(
            title: 'Event Details',
            onBack: () => Navigator.of(context).pop(),
            showBack: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                                             // Event Image
                       ClipRRect(
                         borderRadius: BorderRadius.circular(16),
                         child: Container(
                           width: double.infinity,
                           height: 200,
                           decoration: BoxDecoration(
                             gradient: LinearGradient(
                               begin: Alignment.topLeft,
                               end: Alignment.bottomRight,
                               colors: [
                                 const Color(0xFFD7263D).withOpacity(0.8),
                                 const Color(0xFFE53E3E).withOpacity(0.6),
                               ],
                             ),
                           ),
                           child: Stack(
                             children: [
                               // Background image or icon
                               Center(
                                 child: Icon(
                                   Icons.event,
                                   color: Colors.white,
                                   size: 60,
                                 ),
                               ),
                               // Event type badge
                               Positioned(
                                 top: 12,
                                 right: 12,
                                 child: Container(
                                   padding: const EdgeInsets.symmetric(
                                     horizontal: 8,
                                     vertical: 4,
                                   ),
                                   decoration: BoxDecoration(
                                     color: Colors.white.withOpacity(0.9),
                                     borderRadius: BorderRadius.circular(12),
                                   ),
                                   child: Text(
                                     (event['type'] ?? '').toString().toUpperCase(),
                                     style: const TextStyle(
                                       fontSize: 10,
                                       fontWeight: FontWeight.bold,
                                       color: Color(0xFFD7263D),
                                     ),
                                   ),
                                 ),
                               ),
                               // Attendees badge
                               Positioned(
                                 bottom: 12,
                                 left: 12,
                                 child: Container(
                                   padding: const EdgeInsets.symmetric(
                                     horizontal: 8,
                                     vertical: 4,
                                   ),
                                   decoration: BoxDecoration(
                                     color: Colors.black.withOpacity(0.7),
                                     borderRadius: BorderRadius.circular(12),
                                   ),
                                   child: Row(
                                     mainAxisSize: MainAxisSize.min,
                                     children: [
                                       const Icon(
                                         Icons.people,
                                         color: Colors.white,
                                         size: 14,
                                       ),
                                       const SizedBox(width: 4),
                                       Text(
                                         '${event['attendees']}',
                                         style: const TextStyle(
                                           fontSize: 10,
                                           fontWeight: FontWeight.bold,
                                           color: Colors.white,
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                      const SizedBox(height: 20),

                      // Event Title
                      Text(
                        event['title'] ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen ? 22 : 26,
                          color: const Color(0xFFD7263D),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Event Info Card
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              _infoRow(
                                Icons.calendar_today,
                                'Date',
                                DateFormat('MMM d, yyyy').format(event['date']),
                              ),
                              _infoRow(
                                Icons.location_on,
                                'Location',
                                event['location'] ?? '',
                              ),
                              _infoRow(
                                Icons.category,
                                'Type',
                                (event['type'] ?? '').toString().toUpperCase(),
                              ),
                              _infoRow(
                                Icons.people,
                                'Attendees',
                                '${event['attendees']} people',
                              ),
                              _infoRow(
                                Icons.info_outline,
                                'Status',
                                (event['status'] ?? '')
                                    .toString()
                                    .toUpperCase(),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.red[400]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
