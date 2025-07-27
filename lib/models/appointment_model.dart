class Appointment {
  final String id;
  final DateTime date;
  final String timeFrom; // Changed from 'time'
  final String timeTo; // Added 'timeTo'
  final String hospital;
  final String type;
  final String status; // e.g., 'Upcoming', 'Completed', 'Cancelled'

  const Appointment({
    required this.id,
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.hospital,
    required this.type,
    this.status = 'Upcoming', // Added status
  });

  // Create a copy with modified fields
  Appointment copyWith({
    String? id,
    DateTime? date,
    String? timeFrom,
    String? timeTo,
    String? hospital,
    String? type,
    String? status,
  }) {
    return Appointment(
      id: id ?? this.id,
      date: date ?? this.date,
      timeFrom: timeFrom ?? this.timeFrom,
      timeTo: timeTo ?? this.timeTo,
      hospital: hospital ?? this.hospital,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'timeFrom': timeFrom,
      'timeTo': timeTo,
      'hospital': hospital,
      'type': type,
      'status': status,
    };
  }

  // Create from JSON
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      date: DateTime.parse(json['date']),
      timeFrom: json['timeFrom'],
      timeTo: json['timeTo'],
      hospital: json['hospital'],
      type: json['type'],
      status: json['status'] ?? 'Upcoming', // Handle status for old data
    );
  }

  @override
  String toString() {
    return 'Appointment{id: $id, date: $date, timeFrom: $timeFrom, timeTo: $timeTo, hospital: $hospital, type: $type, status: $status}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Appointment &&
        other.id == id &&
        other.date == date &&
        other.timeFrom == timeFrom &&
        other.timeTo == timeTo &&
        other.hospital == hospital &&
        other.type == type &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        timeFrom.hashCode ^
        timeTo.hashCode ^
        hospital.hashCode ^
        type.hashCode ^
        status.hashCode;
  }
}
