// lib/screens/user/user_appointments_screen.dart
import 'package:blood_system/screens/appointments/rescheduleAppointment.dart';
import 'package:blood_system/screens/appointments/user_appointmentDetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserAppointmentsScreen extends StatefulWidget {
  const UserAppointmentsScreen({super.key});

  @override
  State<UserAppointmentsScreen> createState() => _UserAppointmentsScreenState();
}

class _UserAppointmentsScreenState extends State<UserAppointmentsScreen> {

  // Mock user appointments - in real app, this would come from API
  List<Map<String, dynamic>> get userAppointments => [
    {
      'id': '1',
      'type': 'Blood Donation',
      'location': 'City Hospital',
      'date': DateTime.now().add(Duration(days: 3)),
      'time': '10:00 AM - 4:00 PM',
      'status': 'confirmed',
      'donationType': 'Whole Blood',
      'instructions': [
        'Eat a healthy meal and drink water',
        'Bring a valid photo ID',
        'Avoid caffeine and alcohol for at least 24 hours'
      ],
    },
    {
      'id': '2',
      'type': 'Blood Donation',
      'location': 'Kibagabaga Hospital',
      'date': DateTime.now().add(Duration(days: 10)),
      'time': '2:00 PM - 6:00 PM',
      'status': 'pending',
      'donationType': 'Platelets',
      'instructions': [
        'Eat a healthy meal and drink water',
        'Bring a valid photo ID',
        'Avoid caffeine and alcohol for at least 24 hours'
      ],
    },
    {
      'id': '3',
      'type': 'Blood Donation',
      'location': 'City Hospital',
      'date': DateTime.now().subtract(Duration(days: 30)),
      'time': '10:00 AM - 4:00 PM',
      'status': 'completed',
      'donationType': 'Whole Blood',
      'instructions': [
        'Eat a healthy meal and drink water',
        'Bring a valid photo ID',
        'Avoid caffeine and alcohol for at least 24 hours'
      ],
    },
  ];

  List<Map<String, dynamic>> get upcomingAppointments {
    final now = DateTime.now();
    return userAppointments.where((appointment) {
      final appointmentDate = appointment['date'] as DateTime;
      return appointmentDate.isAfter(now);
    }).toList();
  }

  List<Map<String, dynamic>> get pastAppointments {
    final now = DateTime.now();
    return userAppointments.where((appointment) {
      final appointmentDate = appointment['date'] as DateTime;
      return appointmentDate.isBefore(now);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUpcomingAppointments(),
                    const SizedBox(height: 24),
                    // _buildAppointmentHistory(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 120,
      decoration: const BoxDecoration(
        color: Color(0xFFD7263D),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.event_note,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Upcoming appointments',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingAppointments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming appointments',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        upcomingAppointments.isEmpty
            ? _buildEmptyState('No upcoming appointments')
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: upcomingAppointments.length,
                itemBuilder: (context, index) {
                  final appointment = upcomingAppointments[index];
                  return _buildAppointmentCard(appointment, isUpcoming: true);
                },
              ),
      ],
    );
  }

  Widget _buildAppointmentHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Appointment History',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        pastAppointments.isEmpty
            ? _buildEmptyState('No past appointments')
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pastAppointments.length,
                itemBuilder: (context, index) {
                  final appointment = pastAppointments[index];
                  return _buildAppointmentCard(appointment, isUpcoming: false);
                },
              ),
      ],
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.calendar_today,
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment, {required bool isUpcoming}) {
    final status = appointment['status'];
    Color statusColor = _getStatusColor(status);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/hospital.png', // You can use a hospital image
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.local_hospital,
                      color: Color(0xFFD7263D),
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              appointment['type'],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment['location'],
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('EEEE, MMMM d, yyyy').format(appointment['date']),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            trailing: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UserAppointmentDetailsScreen(
                      appointment: appointment,
                    ),
                  ),
                );
              },
              child: const Text(
                'see details...',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          if (isUpcoming) _buildAppointmentActions(appointment),
        ],
      ),
    );
  }

  Widget _buildAppointmentActions(Map<String, dynamic> appointment) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RescheduleAppointmentScreen(
                      appointment: appointment,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD7263D),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Reschedule',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextButton(
              onPressed: () {
                _showCancelDialog(appointment);
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showCancelDialog(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content: const Text('Are you sure you want to cancel this appointment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _cancelAppointment(appointment);
            },
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  void _cancelAppointment(Map<String, dynamic> appointment) {
    setState(() {
      appointment['status'] = 'cancelled';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Appointment cancelled successfully'),
        backgroundColor: Colors.red,
      ),
    );
  }
}