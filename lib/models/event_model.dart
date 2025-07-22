import 'package:flutter/foundation.dart';

class Event {
  final String id;
  final DateTime date;
  final String timeFrom;
  final String timeTo;
  final String location;
  final String description;

  Event({
    required this.id,
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.location,
    required this.description,
  });

  Event copyWith({
    String? id,
    DateTime? date,
    String? timeFrom,
    String? timeTo,
    String? location,
    String? description,
  }) {
    return Event(
      id: id ?? this.id,
      date: date ?? this.date,
      timeFrom: timeFrom ?? this.timeFrom,
      timeTo: timeTo ?? this.timeTo,
      location: location ?? this.location,
      description: description ?? this.description,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Event &&
        other.id == id &&
        other.date == date &&
        other.timeFrom == timeFrom &&
        other.timeTo == timeTo &&
        other.location == location &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    date.hashCode ^
    timeFrom.hashCode ^
    timeTo.hashCode ^
    location.hashCode ^
    description.hashCode;
  }

  @override
  String toString() {
    return 'Event(id: $id, date: $date, timeFrom: $timeFrom, timeTo: $timeTo, location: $location, description: $description)';
  }
}