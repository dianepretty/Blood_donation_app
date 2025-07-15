import 'package:blood_system/screens/ViewAppointment.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  PickerDateRange? selectedDateRange;
  DateTime? fromDate;
  DateTime? toDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekStart = today.subtract(Duration(days: today.weekday - 1));
    final weekEnd = weekStart.add(Duration(days: 6));
    selectedDateRange = PickerDateRange(weekStart, weekEnd);
    fromDate = weekStart;
    toDate = weekEnd;
  }

  final List<Map<String, dynamic>> appointments = [
    {
      'name': 'Sophia Carter',
      'specialty': 'Cardiology',
      'time': '10:00 AM',
      'date': DateTime.now(),
      'department': 'Cardiology',
      'doctor': 'Dr. Ethan Reinhart',
      'reason': 'Routine Check-up',
      'medicalHistory': 'No significant history',
      'gender': 'Female',
      'age': 25,
    },
    {
      'name': 'John Doe',
      'specialty': 'Neurology',
      'time': '8:00 PM',
      'date': DateTime.now().add(Duration(days: 1)),
      'department': 'Neurology',
      'doctor': 'Dr. Sarah Johnson',
      'reason': 'Consultation',
      'medicalHistory': 'Previous headaches',
      'gender': 'Male',
      'age': 32,
    },
    {
      'name': 'John Baptist',
      'specialty': 'Pediatrics',
      'time': '8:00 PM',
      'date': DateTime.now().add(Duration(days: 2)),
      'department': 'Pediatrics',
      'doctor': 'Dr. Michael Brown',
      'reason': 'Follow-up',
      'medicalHistory': 'Asthma',
      'gender': 'Male',
      'age': 8,
    },
  ];

  List<Map<String, dynamic>> get filteredAppointments {
    if (fromDate == null || toDate == null) return appointments;
    return appointments.where((appointment) {
      final appointmentDate = appointment['date'] as DateTime;
      return !appointmentDate.isBefore(fromDate!) &&
          !appointmentDate.isAfter(toDate!);
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateSelector(),
                  const SizedBox(height: 20),
                  _buildAppointmentsList(),
                ],
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
                'Appointments',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select dates',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildDateField('From', fromDate),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDateField('To', toDate),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateField(String label, DateTime? date) {
    return GestureDetector(
      onTap: () => _selectDate(label.toLowerCase()),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date != null ? DateFormat('MMM d, yyyy').format(date) : 'Select date',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate(String type) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      setState(() {
        if (type == 'from') {
          fromDate = date;
        } else {
          toDate = date;
        }
      });
    }
  }

  Widget _buildAppointmentsList() {
    final filteredList = filteredAppointments;
    
    return Expanded(
      child: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final appointment = filteredList[index];
          return _buildAppointmentCard(appointment);
        },
      ),
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.person,
              color: Color(0xFFD7263D),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${appointment['time']} - ${appointment['specialty']}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AppointmentDetailsScreen(
                    appointment: appointment,
                  ),
                ),
              );
            },
            child: Text(
              'view details',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
