// lib/screens/user/user_appointment_details.dart
import 'package:blood_system/screens/appointments/rescheduleAppointment.dart';
import 'package:blood_system/widgets/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserAppointmentDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> appointment;

  const UserAppointmentDetailsScreen({super.key, required this.appointment});

  @override
  State<UserAppointmentDetailsScreen> createState() =>
      _UserAppointmentDetailsScreenState();
}

class _UserAppointmentDetailsScreenState
    extends State<UserAppointmentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final appointmentDate =
        widget.appointment['appointmentDate'] ??
        widget.appointment['date'] ??
        DateTime.now();
    final isUpcoming = appointmentDate.isAfter(DateTime.now());

    return MainNavigationWrapper(
      currentPage: '/userAppointmentDetails',
      pageTitle: 'Appointment Details',
      backgroundColor: const Color(0xFFF8F9FA),
      child: Column(
        children: [
          // _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAppointmentCard(),
                    const SizedBox(height: 20),
                    _buildAppointmentDetails(),
                    const SizedBox(height: 20),
                    _buildPreparationInstructions(),
                    const SizedBox(height: 20),
                    if (isUpcoming) _buildActionButtons(),
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
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Appointment Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentCard() {
    final appointmentDate =
        widget.appointment['appointmentDate'] ??
        widget.appointment['date'] ??
        DateTime.now();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade200,
                ),
                child: const Icon(
                  Icons.local_hospital,
                  color: Color(0xFFD7263D),
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Blood Donation',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.appointment['hospitalName'] ?? 'Unknown Hospital',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('EEEE, MMMM d, yyyy').format(appointmentDate),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Time',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.appointment['appointmentTime'] ?? 'Unknown Time',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetails() {
    final appointmentDate =
        widget.appointment['appointmentDate'] ??
        widget.appointment['date'] ??
        DateTime.now();

    return Container(
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Appointment',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            'Date',
            DateFormat('EEEE, MMMM d, yyyy').format(appointmentDate),
          ),
          _buildDetailRow(
            'Time',
            widget.appointment['appointmentTime'] ?? 'Unknown Time',
          ),
          _buildDetailRow(
            'Location',
            widget.appointment['hospitalName'] ?? 'Unknown Hospital',
          ),
          _buildDetailRow('Donation Type', 'Blood Donation'),
          _buildDetailRow('Status', 'Scheduled'),
        ],
      ),
    );
  }

  Widget _buildPreparationInstructions() {
    // Default preparation instructions since they're not in the model
    final defaultInstructions = [
      'Get a good night\'s sleep before your appointment',
      'Eat a healthy meal 3 hours before donating',
      'Stay hydrated by drinking plenty of water',
      'Avoid alcohol 24 hours before donating',
      'Bring a valid ID and any required documents',
      'Wear comfortable clothing with sleeves that can be rolled up',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How to prepare',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          ...defaultInstructions
              .map<Widget>(
                (instruction) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(top: 6, right: 12),
                        decoration: const BoxDecoration(
                          color: Color(0xFFD7263D),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          instruction,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (context) => RescheduleAppointmentScreen(
                        appointment: widget.appointment,
                      ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD7263D),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Reschedule',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        // const SizedBox(height: 12),
        // SizedBox(
        //   width: double.infinity,
        //   child: TextButton(
        //     onPressed: () {
        //       _showCancelDialog();
        //     },
        //     child: const Text(
        //       'Cancel',
        //       style: TextStyle(
        //         color: Colors.black87,
        //         fontSize: 16,
        //         fontWeight: FontWeight.w500,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Cancel Appointment'),
            content: const Text(
              'Are you sure you want to cancel this appointment?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _cancelAppointment();
                },
                child: const Text('Yes, Cancel'),
              ),
            ],
          ),
    );
  }

  void _cancelAppointment() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Appointment cancelled successfully'),
        backgroundColor: Colors.red,
      ),
    );

    Navigator.pop(context);
  }
}
