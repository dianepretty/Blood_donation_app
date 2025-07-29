import 'package:blood_system/widgets/red_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ViewEventScreen extends StatelessWidget {
  final Map<String, dynamic> event;
  const ViewEventScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 400;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.delete),
        onPressed: () async {
          final docId = event['id'];
          await FirebaseFirestore.instance
              .collection('events')
              .doc(docId)
              .delete();
          if (context.mounted) Navigator.of(context).pop();
        },
        tooltip: 'Delete Event',
      ),
      body: Column(
        children: [
          RedHeader(
            title: 'Event Details',
            onBack: () => Navigator.of(context).pop(),
            showBack: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Enhanced Event Image with Hero Animation
                      Hero(
                        tag: 'event_${event['title']}',
                        child: Container(
                          width: double.infinity,
                          height: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFFD7263D).withOpacity(0.9),
                                const Color(0xFFE53E3E).withOpacity(0.7),
                                const Color(0xFFFF6B6B).withOpacity(0.5),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFD7263D).withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: [
                                // Animated background pattern
                                Positioned.fill(
                                  child: CustomPaint(
                                    painter: _EventPatternPainter(),
                                  ),
                                ),
                                // Main content
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.event,
                                          color: Colors.white,
                                          size: 48,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Event Details',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Enhanced badges
                                Positioned(
                                  bottom: 16,
                                  left: 16,
                                  child: _buildTimeBadge(
                                    '${event['timeFrom'] ?? ''} - ${event['timeTo'] ?? ''}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Enhanced Event Title with animation
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          event['title'] ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 24 : 28,
                            color: const Color(0xFF1A1A1A),
                            height: 1.2,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Enhanced Event Info Cards with staggered animation
                      ..._buildInfoCards(context),

                      const SizedBox(height: 32),
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



  Widget _buildTimeBadge(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.people_rounded, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildInfoCards(BuildContext context) {
    final infoItems = [
      {
        'icon': Icons.calendar_today_rounded,
        'label': 'Date',
        'value': DateFormat('MMM d, yyyy').format(event['date']),
      },
      {
        'icon': Icons.location_on_rounded,
        'label': 'Location',
        'value': event['location'] ?? '',
      },

      {
        'icon': Icons.schedule_rounded,
        'label': 'Time',
        'value': '${event['timeFrom'] ?? ''} - ${event['timeTo'] ?? ''}',
      },
      {
        'icon': Icons.info_outline_rounded,
        'label': 'Status',
        'value': (event['status'] ?? '').toString().toUpperCase(),
      },
    ];

    return infoItems.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      return AnimatedContainer(
        duration: Duration(milliseconds: 300 + (index * 100)),
        margin: const EdgeInsets.only(bottom: 16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                // Haptic feedback for better UX
                HapticFeedback.lightImpact();
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _getIconColor(
                          item['icon'] as IconData,
                        ).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: _getIconColor(item['icon'] as IconData),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['label'] as String,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['value'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1A1A),
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey[400],
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }



  Color _getIconColor(IconData icon) {
    if (icon == Icons.calendar_today_rounded) return const Color(0xFF3B82F6);
    if (icon == Icons.location_on_rounded) return const Color(0xFF10B981);
    if (icon == Icons.schedule_rounded) return const Color(0xFFF59E0B);
    if (icon == Icons.info_outline_rounded) return const Color(0xFF8B5CF6);
    return const Color(0xFFD7263D);
  }
}

// Custom painter for background pattern
class _EventPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.1)
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke;

    // Draw subtle geometric pattern
    for (int i = 0; i < 20; i++) {
      for (int j = 0; j < 20; j++) {
        final x = (i * size.width / 20);
        final y = (j * size.height / 20);

        if ((i + j) % 4 == 0) {
          canvas.drawCircle(Offset(x, y), 2, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
