import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String? id;
  final String userId;
  final String hospitalName;
  final DateTime appointmentDate;
  final String appointmentTime;

  // Optional user details
  final String? fullName;
  final String? phoneNumber;
  final String? bloodGroup;

  const Appointment({
    this.id,
    required this.userId,
    required this.hospitalName,
    required this.appointmentDate,
    required this.appointmentTime,
    this.fullName,
    this.phoneNumber,
    this.bloodGroup,
  });

  // Create from JSON
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      userId: json['userId'] ?? '',
      hospitalName: json['hospitalName'] ?? '',
      appointmentDate: _parseDateTime(json['appointmentDate']),
      appointmentTime: json['appointmentTime'] ?? '',
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      bloodGroup: json['bloodGroup'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'hospitalName': hospitalName,
      'appointmentDate': Timestamp.fromDate(appointmentDate),
      'appointmentTime': appointmentTime,
      // Don't include user details in storage as they're fetched separately
    };
  }

  // Helper method to parse DateTime from various formats
  static DateTime _parseDateTime(dynamic dateTime) {
    if (dateTime == null) return DateTime.now();
    if (dateTime is Timestamp) return dateTime.toDate();
    if (dateTime is DateTime) return dateTime;
    if (dateTime is String)
      return DateTime.tryParse(dateTime) ?? DateTime.now();
    return DateTime.now();
  }

  // Copy with method for updates
  Appointment copyWith({
    String? id,
    String? userId,
    String? hospitalId,
    String? hospitalName,
    DateTime? appointmentDate,
    String? appointmentTime,
    String? fullName,
    String? phoneNumber,
    String? bloodGroup,
  }) {
    return Appointment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      hospitalName: hospitalName ?? this.hospitalName,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bloodGroup: bloodGroup ?? this.bloodGroup,
    );
  }

  @override
  String toString() {
    return 'Appointment(id: $id, hospitalName: $hospitalName, date: $appointmentDate, time: $appointmentTime, fullName: $fullName, phoneNumber: $phoneNumber, bloodGroup: $bloodGroup)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Appointment &&
        other.id == id &&
        other.userId == userId &&
        other.appointmentDate == appointmentDate &&
        other.appointmentTime == appointmentTime &&
        other.fullName == fullName &&
        other.phoneNumber == phoneNumber &&
        other.bloodGroup == bloodGroup;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      userId,
      appointmentDate,
      appointmentTime,
      fullName,
      phoneNumber,
      bloodGroup,
    );
  }
}
