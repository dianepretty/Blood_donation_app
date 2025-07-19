import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart'; // Import Uuid for generating unique IDs
import '../models/appointment_model.dart';
import 'appointment_event.dart';
import 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  // In-memory list to simulate data storage
  final List<Appointment> _appointments = [];
  final Uuid _uuid = const Uuid(); // Initialize Uuid

  AppointmentBloc() : super(AppointmentLoading()) { // Changed initial state to AppointmentLoading
    on<LoadAppointments>(_onLoadAppointments);
    on<AddAppointment>(_onAddAppointment);
    on<UpdateAppointment>(_onUpdateAppointment);
    on<DeleteAppointment>(_onDeleteAppointment);
    on<RefreshAppointments>(_onRefreshAppointments);

    // Simulate initial data loading
    _addInitialAppointments();
  }

  // Method to add initial sample appointments
  void _addInitialAppointments() {
    _appointments.add(
      Appointment(
        id: _uuid.v4(), // Generate unique ID
        type: 'General Check-up',
        hospital: 'Kigali Central Hospital',
        date: DateTime.now().add(const Duration(days: 2)),
        timeFrom: '10:00 AM', // Updated to timeFrom
        timeTo: '11:00 AM',   // Added timeTo
        status: 'Upcoming',
      ),
    );
    _appointments.add(
      Appointment(
        id: _uuid.v4(), // Generate unique ID
        type: 'Dental Cleaning',
        hospital: 'Remera Dental Clinic',
        date: DateTime.now().add(const Duration(days: 5)),
        timeFrom: '02:30 PM', // Updated to timeFrom
        timeTo: '03:30 PM',   // Added timeTo
        status: 'Upcoming',
      ),
    );
    _appointments.add(
      Appointment(
        id: _uuid.v4(), // Generate unique ID
        type: 'Vaccination',
        hospital: 'Kininya Hospital',
        date: DateTime.now().subtract(const Duration(days: 10)),
        timeFrom: '09:00 AM', // Updated to timeFrom
        timeTo: '09:30 AM',   // Added timeTo
        status: 'Completed',
      ),
    );
  }

  Future<void> _onLoadAppointments(
      LoadAppointments event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Separate upcoming and past appointments
      final now = DateTime.now();
      final upcoming = _appointments
          .where((a) => a.date.isAfter(now) || a.date.isAtSameMomentAs(now))
          .toList()
        ..sort((a, b) => a.date.compareTo(b.date)); // Sort upcoming by date ascending

      final past = _appointments
          .where((a) => a.date.isBefore(now))
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date)); // Sort past by date descending

      emit(AppointmentLoaded(
        upcomingAppointments: List.from(upcoming),
        pastAppointments: List.from(past),
      ));
    } catch (e) {
      emit(AppointmentError('Failed to load appointments: ${e.toString()}'));
    }
  }

  Future<void> _onAddAppointment(
      AddAppointment event, Emitter<AppointmentState> emit) async {
    try {
      // Assign a unique ID before adding
      final newAppointment = event.appointment.copyWith(id: _uuid.v4());
      _appointments.add(newAppointment);
      // Reload appointments to update the state with sorted and categorized lists
      await _onLoadAppointments(LoadAppointments(), emit);
      // Emit success state with the current lists
      emit(AppointmentOperationSuccess('Appointment added successfully!',
          upcomingAppointments: (state as AppointmentLoaded).upcomingAppointments,
          pastAppointments: (state as AppointmentLoaded).pastAppointments));
    } catch (e) {
      emit(AppointmentError('Failed to add appointment: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateAppointment(
      UpdateAppointment event, Emitter<AppointmentState> emit) async {
    try {
      final index = _appointments.indexWhere((a) => a.id == event.appointment.id);
      if (index != -1) {
        _appointments[index] = event.appointment;
        // Reload appointments to update the state with sorted and categorized lists
        await _onLoadAppointments(LoadAppointments(), emit);
        // Emit success state with the current lists
        emit(AppointmentOperationSuccess('Appointment updated successfully!',
            upcomingAppointments: (state as AppointmentLoaded).upcomingAppointments,
            pastAppointments: (state as AppointmentLoaded).pastAppointments));
      } else {
        emit(const AppointmentError('Appointment not found for update.'));
      }
    } catch (e) {
      emit(AppointmentError('Failed to update appointment: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteAppointment(
      DeleteAppointment event, Emitter<AppointmentState> emit) async {
    try {
      _appointments.removeWhere((a) => a.id == event.id); // Changed from event.appointmentId to event.id
      // Reload appointments to update the state with sorted and categorized lists
      await _onLoadAppointments(LoadAppointments(), emit);
      // Emit success state with the current lists
      emit(AppointmentOperationSuccess('Appointment deleted successfully!',
          upcomingAppointments: (state as AppointmentLoaded).upcomingAppointments,
          pastAppointments: (state as AppointmentLoaded).pastAppointments));
    } catch (e) {
      emit(AppointmentError('Failed to delete appointment: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshAppointments(
      RefreshAppointments event, Emitter<AppointmentState> emit) async {
    // This is similar to LoadAppointments, but might be triggered by a pull-to-refresh
    emit(AppointmentLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      // Re-categorize and sort appointments
      final now = DateTime.now();
      final upcoming = _appointments
          .where((a) => a.date.isAfter(now) || a.date.isAtSameMomentAs(now))
          .toList()
        ..sort((a, b) => a.date.compareTo(b.date));
      final past = _appointments
          .where((a) => a.date.isBefore(now))
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date));

      emit(AppointmentLoaded(
        upcomingAppointments: List.from(upcoming),
        pastAppointments: List.from(past),
      ));
    } catch (e) {
      emit(AppointmentError('Failed to refresh appointments: ${e.toString()}'));
    }
  }
}
