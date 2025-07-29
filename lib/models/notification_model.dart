import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String title;
  final String time;
  final String details;
  final DateTime date;

  NotificationModel({
    required this.title,
    required this.time,
    required this.details,
    required this.date,
  });

  factory NotificationModel.fromFirestore(Map<String, dynamic> data) {
    final Timestamp timestamp = data['appointmentDate'];
    final date = timestamp.toDate();

    return NotificationModel(
      title: 'Appointment Reminder',
      time: data['appointmentTime'] ?? '',
      details: 'Location: ${data['hospitalName'] ?? 'Unknown'}\nReminder: Bring ID.',
      date: date,
    );
  }
}
