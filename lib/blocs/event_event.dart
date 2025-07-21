import 'package:equatable/equatable.dart';
import '../models/event_model.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class LoadEvents extends EventEvent {}

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