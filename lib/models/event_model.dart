class Event {
  final String id;
  final String name;
  final String type;
  final DateTime date;
  final String timeFrom;
  final String timeTo;
  final String location;
  final String description;
  final int attendees;
  final String status;

  Event({
    required this.id,
    required this.name,
    required this.type,
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.location,
    required this.description,
    required this.attendees,
    required this.status,
  });

  Event copyWith({
    String? id,
    String? name,
    String? type,
    DateTime? date,
    String? timeFrom,
    String? timeTo,
    String? location,
    String? description,
    int? attendees,
    String? status,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      date: date ?? this.date,
      timeFrom: timeFrom ?? this.timeFrom,
      timeTo: timeTo ?? this.timeTo,
      location: location ?? this.location,
      description: description ?? this.description,
      attendees: attendees ?? this.attendees,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Event &&
        other.id == id &&
        other.name == name &&
        other.type == type &&
        other.date == date &&
        other.timeFrom == timeFrom &&
        other.timeTo == timeTo &&
        other.location == location &&
        other.description == description &&
        other.attendees == attendees &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        date.hashCode ^
        timeFrom.hashCode ^
        timeTo.hashCode ^
        location.hashCode ^
        description.hashCode ^
        attendees.hashCode ^
        status.hashCode;
  }

  @override
  String toString() {
    return 'Event(id: $id, name: $name, type: $type, date: $date, timeFrom: $timeFrom, timeTo: $timeTo, location: $location, description: $description, attendees: $attendees, status: $status)';
  }
}
