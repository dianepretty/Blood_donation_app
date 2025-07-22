import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../models/event_model.dart';
import 'event_event.dart';
import 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  // In-memory list to simulate data storage
  final List<Event> _events = [];
  final Uuid _uuid = const Uuid();

  EventBloc() : super(EventLoading()) {
    on<LoadEvents>(_onLoadEvents);
    on<AddEvent>(_onAddEvent);
    on<UpdateEvent>(_onUpdateEvent);
    on<DeleteEvent>(_onDeleteEvent);
    on<RefreshEvents>(_onRefreshEvents);

    // Simulate initial data loading
    _addInitialEvents();
  }

  void _addInitialEvents() {
    _events.add(
      Event(
        id: _uuid.v4(),
        date: DateTime.now().add(const Duration(days: 7)),
        timeFrom: '10:00 AM',
        timeTo: '12:00 PM',
        location: 'Kigali Convention Centre',
        description: 'Annual Tech Conference 2025',
      ),
    );
    _events.add(
      Event(
        id: _uuid.v4(),
        date: DateTime.now().add(const Duration(days: 14)),
        timeFrom: '09:00 AM',
        timeTo: '05:00 PM',
        location: 'Amahoro Stadium',
        description: 'National Blood Donation Drive',
      ),
    );
    _events.add(
      Event(
        id: _uuid.v4(),
        date: DateTime.now().add(const Duration(days: 21)),
        timeFrom: '02:00 PM',
        timeTo: '04:00 PM',
        location: 'Serena Hotel',
        description: 'Healthcare Innovation Workshop',
      ),
    );
  }

  Future<void> _onLoadEvents(LoadEvents event, Emitter<EventState> emit) async {
    emit(EventLoading());
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      // Sort events by date for display
      _events.sort((a, b) => a.date.compareTo(b.date));
      emit(EventLoaded(events: List.from(_events)));
    } catch (e) {
      emit(EventError('Failed to load events: ${e.toString()}'));
    }
  }

  Future<void> _onAddEvent(AddEvent event, Emitter<EventState> emit) async {
    try {
      // Assign a unique ID
      final newEvent = event.event.copyWith(id: _uuid.v4());
      _events.add(newEvent);
      // Sort events after adding
      _events.sort((a, b) => a.date.compareTo(b.date));
      emit(EventOperationSuccess('Event added successfully!', events: List.from(_events)));
      emit(EventLoaded(events: List.from(_events))); // Re-emit loaded state to update UI
    } catch (e) {
      emit(EventError('Failed to add event: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateEvent(UpdateEvent event, Emitter<EventState> emit) async {
    try {
      final index = _events.indexWhere((e) => e.id == event.event.id);
      if (index != -1) {
        _events[index] = event.event;
        // Sort events after updating
        _events.sort((a, b) => a.date.compareTo(b.date));
        emit(EventOperationSuccess('Event updated successfully!', events: List.from(_events)));
        emit(EventLoaded(events: List.from(_events))); // Re-emit loaded state to update UI
      } else {
        emit(EventError('Event not found for update.'));
      }
    } catch (e) {
      emit(EventError('Failed to update event: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteEvent(DeleteEvent event, Emitter<EventState> emit) async {
    try {
      _events.removeWhere((e) => e.id == event.id);
      // Sort events after deleting
      _events.sort((a, b) => a.date.compareTo(b.date));
      emit(EventOperationSuccess('Event deleted successfully!', events: List.from(_events)));
      emit(EventLoaded(events: List.from(_events))); // Re-emit loaded state to update UI
    } catch (e) {
      emit(EventError('Failed to delete event: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshEvents(RefreshEvents event, Emitter<EventState> emit) async {
    // This is similar to LoadEvents, but might be triggered by a pull-to-refresh
    emit(EventLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _events.sort((a, b) => a.date.compareTo(b.date));
      emit(EventLoaded(events: List.from(_events)));
    } catch (e) {
      emit(EventError('Failed to refresh events: ${e.toString()}'));
    }
  }
}
