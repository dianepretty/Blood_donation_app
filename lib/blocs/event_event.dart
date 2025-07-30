import 'package:equatable/equatable.dart';
import '../models/event_model.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class LoadEvents extends EventEvent {}

class LoadEventsByHospital extends EventEvent {
  final String hospitalId;

  const LoadEventsByHospital(this.hospitalId);

  @override
  List<Object> get props => [hospitalId];
}

class LoadEventsByDateRange extends EventEvent {
  final DateTime startDate;
  final DateTime endDate;

  const LoadEventsByDateRange(this.startDate, this.endDate);

  @override
  List<Object> get props => [startDate, endDate];
}

class LoadEventsByHospitalAndDateRange extends EventEvent {
  final String hospitalId;
  final DateTime startDate;
  final DateTime endDate;

  const LoadEventsByHospitalAndDateRange(
    this.hospitalId,
    this.startDate,
    this.endDate,
  );

  @override
  List<Object> get props => [hospitalId, startDate, endDate];
}

class AddEvent extends EventEvent {
  final Event event;

  const AddEvent(this.event);

  @override
  List<Object> get props => [event];
}

class UpdateEvent extends EventEvent {
  final Event event;

  const UpdateEvent(this.event);

  @override
  List<Object> get props => [event];
}

class DeleteEvent extends EventEvent {
  final String id;

  const DeleteEvent(this.id);

  @override
  List<Object> get props => [id];
}

class RefreshEvents extends EventEvent {}

// Internal events for handling stream updates
class EventsUpdated extends EventEvent {
  final List<Event> events;

  const EventsUpdated(this.events);

  @override
  List<Object> get props => [events];
}

class EventErrorOccurred extends EventEvent {
  final String message;

  const EventErrorOccurred(this.message);

  @override
  List<Object> get props => [message];
}
