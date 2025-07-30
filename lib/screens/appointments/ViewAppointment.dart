import 'package:blood_system/widgets/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> appointment;

  const AppointmentDetailsScreen({super.key, required this.appointment});

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return MainNavigationWrapper(
      backgroundColor: const Color(0xFFF8F9FA),
      currentPage: '/appointmentDetails',
      pageTitle: 'Appointment Details',
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPatientInfo(),
                  const SizedBox(height: 20),
                  _buildAppointmentDetails(),
                  const SizedBox(height: 20),
                  _buildPatientInformation(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientInfo() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Icon(Icons.person, color: Color(0xFFD7263D), size: 24),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patient',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              'Blood Donor',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAppointmentDetails() {
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
            'Appointment Details',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          _buildDetailRow('Appointment ID', widget.appointment['id'] ?? 'N/A'),
          _buildDetailRow(
            'Date',
            _formatDate(widget.appointment['appointmentDate']),
          ),
          _buildDetailRow(
            'Time',
            widget.appointment['appointmentTime'] ?? 'N/A',
          ),
          _buildDetailRow(
            'Hospital',
            widget.appointment['hospitalName'] ?? 'N/A',
          ),
          _buildDetailRow('Type', 'Blood Donation'),
        ],
      ),
    );
  }

  Widget _buildPatientInformation() {
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
            'Patient Information',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          _buildDetailRow('User ID', widget.appointment['userId'] ?? 'N/A'),
          _buildDetailRow(
            'Email',
            widget.appointment['userId'] ?? 'N/A',
          ), // Using userId as email identifier
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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

  String _formatDate(dynamic date) {
    if (date == null) return 'N/A';

    try {
      if (date is DateTime) {
        return DateFormat('MMM d, yyyy').format(date);
      } else if (date is String) {
        final parsedDate = DateTime.tryParse(date);
        return parsedDate != null
            ? DateFormat('MMM d, yyyy').format(parsedDate)
            : date;
      }
      return date.toString();
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
