import 'package:equatable/equatable.dart';
import '../models/event_model.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<Event> events;

  const EventLoaded({this.events = const []});

  @override
  List<Object> get props => [events];
}

class EventError extends EventState {
  final String message;

  const EventError(this.message);

  @override
  List<Object> get props => [message];
}

class EventOperationInProgress extends EventState {}

class EventOperationSuccess extends EventState {
  final String message;

  const EventOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}
