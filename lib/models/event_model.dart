class Event {
  final String id;
  final String name;
  final DateTime date;
  final String timeFrom;
  final String timeTo;
  final String location;
  final String description;
  final String status;
  final String hospitalId;
  final String adminId;

  Event({
    required this.id,
    required this.name,
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.location,
    required this.description,
    required this.status,
    required this.hospitalId,
    required this.adminId,
  });

  Event copyWith({
    String? id,
    String? name,
    DateTime? date,
    String? timeFrom,
    String? timeTo,
    String? location,
    String? description,
    String? status,
    String? hospitalId,
    String? adminId,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      timeFrom: timeFrom ?? this.timeFrom,
      timeTo: timeTo ?? this.timeTo,
      location: location ?? this.location,
      description: description ?? this.description,
      status: status ?? this.status,
      hospitalId: hospitalId ?? this.hospitalId,
      adminId: adminId ?? this.adminId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Event &&
        other.id == id &&
        other.name == name &&
        other.date == date &&
        other.timeFrom == timeFrom &&
        other.timeTo == timeTo &&
        other.location == location &&
        other.description == description &&
        other.status == status &&
        other.hospitalId == hospitalId &&
        other.adminId == adminId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        date.hashCode ^
        timeFrom.hashCode ^
        timeTo.hashCode ^
        location.hashCode ^
        description.hashCode ^
        status.hashCode ^
        hospitalId.hashCode ^
        adminId.hashCode;
  }

  @override
  String toString() {
    return 'Event(id: $id, name: $name, date: $date, timeFrom: $timeFrom, timeTo: $timeTo, location: $location, description: $description, status: $status, hospitalId: $hospitalId, adminId: $adminId)';
  }
}
