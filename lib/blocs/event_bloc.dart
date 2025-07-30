import 'dart:async';
import 'package:blood_system/service/event_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/event_model.dart';
import 'event_event.dart';
import 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventService _eventService;
  StreamSubscription<List<Event>>? _eventsSubscription;

  EventBloc(this._eventService, {required EventService eventService})
    : super(EventLoading()) {
    on<LoadEvents>(_onLoadEvents);
    on<LoadEventsByHospital>(_onLoadEventsByHospital);
    on<LoadEventsByDateRange>(_onLoadEventsByDateRange);
    on<LoadEventsByHospitalAndDateRange>(_onLoadEventsByHospitalAndDateRange);
    on<AddEvent>(_onAddEvent);
    on<UpdateEvent>(_onUpdateEvent);
    on<DeleteEvent>(_onDeleteEvent);
    on<RefreshEvents>(_onRefreshEvents);
    on<EventsUpdated>(_onEventsUpdated);
  }

  @override
  Future<void> close() {
    _eventsSubscription?.cancel();
    return super.close();
  }

  Future<void> _onLoadEvents(LoadEvents event, Emitter<EventState> emit) async {
    emit(EventLoading());
    try {
      await _eventsSubscription?.cancel();
      _eventsSubscription = _eventService.getAllEvents().listen(
        (events) => add(EventsUpdated(events)),
        onError:
            (error) => add(EventErrorOccurred('Failed to load events: $error')),
      );
    } catch (e) {
      emit(EventError('Failed to load events: ${e.toString()}'));
    }
  }

  Future<void> _onLoadEventsByHospital(
    LoadEventsByHospital event,
    Emitter<EventState> emit,
  ) async {
    emit(EventLoading());
    try {
      await _eventsSubscription?.cancel();
      _eventsSubscription = _eventService
          .getEventsByHospital(event.hospitalId)
          .listen(
            (events) => add(EventsUpdated(events)),
            onError:
                (error) =>
                    add(EventErrorOccurred('Failed to load events: $error')),
          );
    } catch (e) {
      emit(EventError('Failed to load events: ${e.toString()}'));
    }
  }

  Future<void> _onLoadEventsByDateRange(
    LoadEventsByDateRange event,
    Emitter<EventState> emit,
  ) async {
    emit(EventLoading());
    try {
      await _eventsSubscription?.cancel();
      _eventsSubscription = _eventService
          .getEventsByDateRange(event.startDate, event.endDate)
          .listen(
            (events) => add(EventsUpdated(events)),
            onError:
                (error) =>
                    add(EventErrorOccurred('Failed to load events: $error')),
          );
    } catch (e) {
      emit(EventError('Failed to load events: ${e.toString()}'));
    }
  }

  Future<void> _onLoadEventsByHospitalAndDateRange(
    LoadEventsByHospitalAndDateRange event,
    Emitter<EventState> emit,
  ) async {
    emit(EventLoading());
    try {
      await _eventsSubscription?.cancel();
      _eventsSubscription = _eventService
          .getEventsByHospitalAndDateRange(
            event.hospitalId,
            event.startDate,
            event.endDate,
          )
          .listen(
            (events) => add(EventsUpdated(events)),
            onError:
                (error) =>
                    add(EventErrorOccurred('Failed to load events: $error')),
          );
    } catch (e) {
      emit(EventError('Failed to load events: ${e.toString()}'));
    }
  }

  Future<void> _onAddEvent(AddEvent event, Emitter<EventState> emit) async {
    try {
      emit(EventOperationInProgress());
      final eventId = await _eventService.createEvent(event.event);
      emit(EventOperationSuccess('Event created successfully!'));
    } catch (e) {
      emit(EventError('Failed to create event: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateEvent(
    UpdateEvent event,
    Emitter<EventState> emit,
  ) async {
    try {
      emit(EventOperationInProgress());
      await _eventService.updateEvent(event.event);
      emit(EventOperationSuccess('Event updated successfully!'));
    } catch (e) {
      emit(EventError('Failed to update event: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteEvent(
    DeleteEvent event,
    Emitter<EventState> emit,
  ) async {
    try {
      emit(EventOperationInProgress());
      await _eventService.deleteEvent(event.id);
      emit(EventOperationSuccess('Event deleted successfully!'));
    } catch (e) {
      emit(EventError('Failed to delete event: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshEvents(
    RefreshEvents event,
    Emitter<EventState> emit,
  ) async {
    // Refresh will be handled by re-triggering the current subscription
    // We can determine the current filter and re-apply it
    if (state is EventLoaded) {
      // For now, just reload all events
      add(LoadEvents());
    }
  }

  void _onEventsUpdated(EventsUpdated event, Emitter<EventState> emit) {
    emit(EventLoaded(events: event.events));
  }

  void _onEventErrorOccurred(
    EventErrorOccurred event,
    Emitter<EventState> emit,
  ) {
    emit(EventError(event.message));
  }
}
