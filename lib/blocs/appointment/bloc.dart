// bloc/appointment_bloc.dart
import 'dart:async';
import 'package:blood_system/blocs/appointment/event.dart';
import 'package:blood_system/blocs/appointment/state.dart';
import 'package:blood_system/models/appointment_model.dart';
import 'package:blood_system/service/appointment_service.dart';
import 'package:blood_system/service/hospital_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentService _appointmentService;
  final HospitalService _hospitalService;

  StreamSubscription<List<Appointment>>? _appointmentsSubscription;

  AppointmentBloc({
    required AppointmentService appointmentService,
    required HospitalService hospitalService,
  }) : _appointmentService = appointmentService,
       _hospitalService = hospitalService,
       super(const AppointmentState()) {
    // Register event handlers
    on<LoadUserAppointments>(_onLoadUserAppointments);
    on<LoadAdminAppointments>(_onLoadAdminAppointments); // ADD THIS LINE
    on<LoadAdminAppointmentsWithDateFilter>(
      _onLoadAdminAppointmentsWithDateFilter,
    );
    on<LoadHospitals>(_onLoadHospitals);
    on<SelectAppointmentDate>(_onSelectAppointmentDate);
    on<SelectHospital>(_onSelectHospital);
    on<LoadAvailableTimeSlots>(_onLoadAvailableTimeSlots);
    on<SelectTimeSlot>(_onSelectTimeSlot);
    on<BookAppointment>(_onBookAppointment);
    on<UpdateAppointmentStatus>(_onUpdateAppointmentStatus);
    on<ResetAppointmentForm>(_onResetAppointmentForm);
    on<ClearAppointmentError>(_onClearAppointmentError);

    // Add handlers for internal events
    on<_AppointmentsUpdated>(_onInternalAppointmentsUpdated);
    on<_AppointmentsError>(_onInternalAppointmentsError);

    //reschedule appointment logic
    on<RescheduleAppointment>(_onRescheduleAppointment);
  }

  // Reschedule appointment logic
  Future<void> _onRescheduleAppointment(
    RescheduleAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    try {
      emit(state.copyWith(isRescheduling: true));
      // Check if the user has an existing appointment at the new date and time
      final hasExisting = await _appointmentService.hasExistingAppointment(
        userId: event.userId,
        appointmentDate: event.newDate,
        appointmentTime: event.newTime,
      );
      if (hasExisting) {
        emit(
          state.copyWith(
            isRescheduling: false,
            errorMessage: 'You already have an appointment at this time',
          ),
        );
        return;
      }
      // Create the rescheduled appointment
      final rescheduledAppointment = Appointment(
        id: event.appointmentId,
        userId: event.userId,
        hospitalName: event.hospitalName,
        appointmentDate: event.newDate,
        appointmentTime: event.newTime,
      );
      // Update the appointment in the service
      await _appointmentService.rescheduleAppointment(
        id: event.appointmentId,
        appointmentDate: event.newDate,
        appointmentTime: event.newTime,
        hospitalName: event.hospitalName,
      );
      // Emit success state
      emit(
        state.copyWith(
          isRescheduling: false,
          successMessage: 'Appointment rescheduled successfully!',
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isRescheduling: false,
          errorMessage: 'Failed to reschedule appointment: ${e.toString()}',
          successMessage: null,
        ),
      );
    }
  }

  // ADD THIS METHOD to handle LoadAdminAppointments
  // Handle LoadAdminAppointments - Fixed implementation
  Future<void> _onLoadAdminAppointments(
    LoadAdminAppointments event,
    Emitter<AppointmentState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AppointmentStatus.loading));

      // Cancel existing subscription
      await _appointmentsSubscription?.cancel();

      // Listen to appointments stream for the hospital (without date filter)
      _appointmentsSubscription = _appointmentService
          .getAppointmentsByHospitalName(event.hospitalName)
          .listen(
            (appointments) {
              if (!isClosed) {
                add(_AppointmentsUpdated(appointments));
              }
            },
            onError: (error) {
              if (!isClosed) {
                add(_AppointmentsError(error.toString()));
              }
            },
          );
    } catch (e) {
      emit(
        state.copyWith(
          status: AppointmentStatus.error,
          errorMessage: 'Failed to load appointments: ${e.toString()}',
        ),
      );
    }
  }

  // Load user appointments
  Future<void> _onLoadUserAppointments(
    LoadUserAppointments event,
    Emitter<AppointmentState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AppointmentStatus.loading));

      // Cancel existing subscription
      await _appointmentsSubscription?.cancel();

      // Listen to appointments stream
      _appointmentsSubscription = _appointmentService
          .getAppointmentByUser(event.userId)
          .listen(
            (appointments) {
              if (!isClosed) {
                add(_AppointmentsUpdated(appointments));
              }
            },
            onError: (error) {
              if (!isClosed) {
                add(_AppointmentsError(error.toString()));
              }
            },
          );
    } catch (e) {
      emit(
        state.copyWith(
          status: AppointmentStatus.error,
          errorMessage: 'Failed to load appointments: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onLoadAdminAppointmentsWithDateFilter(
    LoadAdminAppointmentsWithDateFilter event,
    Emitter<AppointmentState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AppointmentStatus.loading));

      // Cancel existing subscription
      await _appointmentsSubscription?.cancel();

      // Listen to appointments stream for the hospital with date filter
      _appointmentsSubscription = _appointmentService
          .getAppointmentsByHospitalName(
            event.hospitalName,
            fromDate: event.fromDate,
            toDate: event.toDate,
          )
          .listen(
            (appointments) {
              if (!isClosed) {
                add(_AppointmentsUpdated(appointments));
              }
            },
            onError: (error) {
              if (!isClosed) {
                add(_AppointmentsError(error.toString()));
              }
            },
          );
    } catch (e) {
      emit(
        state.copyWith(
          status: AppointmentStatus.error,
          errorMessage: 'Failed to load appointments: ${e.toString()}',
        ),
      );
    }
  }

  // Load hospitals
  Future<void> _onLoadHospitals(
    LoadHospitals event,
    Emitter<AppointmentState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoadingHospitals: true));

      final hospitals = await _hospitalService.getAllHospitals();

      emit(state.copyWith(hospitals: hospitals, isLoadingHospitals: false));
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingHospitals: false,
          errorMessage: 'Failed to load hospitals: ${e.toString()}',
        ),
      );
    }
  }

  // Select appointment date
  void _onSelectAppointmentDate(
    SelectAppointmentDate event,
    Emitter<AppointmentState> emit,
  ) {
    emit(
      state.copyWith(
        selectedDate: event.date,
        selectedTimeSlot: null, // Reset time slot when date changes
        availableTimeSlots: [], // Clear previous time slots
        errorMessage: null,
        successMessage: null, // Clear success message when selecting new date
      ),
    );

    // Auto-load time slots if hospital is already selected
    if (state.selectedHospitalName != null) {
      add(
        LoadAvailableTimeSlots(
          hospitalName: state.selectedHospitalName!,
          date: event.date,
        ),
      );
    }
  }

  // Select hospital
  void _onSelectHospital(SelectHospital event, Emitter<AppointmentState> emit) {
    emit(
      state.copyWith(
        selectedHospitalName: event.hospitalName,
        selectedTimeSlot: null, // Reset time slot when hospital changes
        availableTimeSlots: [], // Clear previous time slots
        errorMessage: null,
        successMessage:
            null, // Clear success message when selecting new hospital
      ),
    );

    // Auto-load time slots if date is already selected
    if (state.selectedDate != null) {
      add(
        LoadAvailableTimeSlots(
          hospitalName: event.hospitalName,
          date: state.selectedDate!,
        ),
      );
    }
  }

  // Load available time slots
  Future<void> _onLoadAvailableTimeSlots(
    LoadAvailableTimeSlots event,
    Emitter<AppointmentState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoadingTimeSlots: true));

      final availableSlots = await _appointmentService.getAvailableTimeSlots(
        hospitalName: event.hospitalName,
        date: event.date,
      );

      emit(
        state.copyWith(
          availableTimeSlots: availableSlots,
          isLoadingTimeSlots: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingTimeSlots: false,
          errorMessage: 'Failed to load available time slots: ${e.toString()}',
        ),
      );
    }
  }

  // Select time slot
  void _onSelectTimeSlot(SelectTimeSlot event, Emitter<AppointmentState> emit) {
    emit(
      state.copyWith(
        selectedTimeSlot: event.timeSlot,
        errorMessage: null,
        successMessage: null, // Clear success message when selecting time slot
      ),
    );
  }

  // Book appointment - FIXED VERSION
  Future<void> _onBookAppointment(
    BookAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          isBooking: true,
          errorMessage: null,
          successMessage: null,
        ),
      );

      // Check for existing appointment
      final hasExisting = await _appointmentService.hasExistingAppointment(
        userId: event.userId,
        appointmentDate: event.appointmentDate,
        appointmentTime: event.appointmentTime,
      );

      if (hasExisting) {
        emit(
          state.copyWith(
            isBooking: false,
            errorMessage: 'You already have an appointment at this time',
          ),
        );
        return;
      }

      // Create appointment
      final appointment = Appointment(
        userId: event.userId,
        hospitalName: event.hospitalName,
        appointmentDate: event.appointmentDate,
        appointmentTime: event.appointmentTime,
      );

      final appointmentId = await _appointmentService.bookAppointment(
        appointment,
      );

      // First emit the success message WITHOUT clearing the form
      emit(
        state.copyWith(
          isBooking: false,
          successMessage: 'Appointment booked successfully!',
          errorMessage: null,
        ),
      );

      // Optionally schedule form clearing after a delay to allow UI to show success
      // You can remove this if you want to manually clear from UI
      Timer(const Duration(seconds: 2), () {
        if (!isClosed) {
          add(const ResetAppointmentForm());
        }
      });
    } catch (e) {
      emit(
        state.copyWith(
          isBooking: false,
          errorMessage: 'Failed to book appointment: ${e.toString()}',
          successMessage: null,
        ),
      );
    }
  }

  // Update appointment status
  Future<void> _onUpdateAppointmentStatus(
    UpdateAppointmentStatus event,
    Emitter<AppointmentState> emit,
  ) async {
    try {
      await _appointmentService.updateAppointmentStatus(event.appointmentId);

      emit(
        state.copyWith(
          successMessage: 'Appointment status updated',
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to update appointment: ${e.toString()}',
          successMessage: null,
        ),
      );
    }
  }

  // Reset form
  void _onResetAppointmentForm(
    ResetAppointmentForm event,
    Emitter<AppointmentState> emit,
  ) {
    emit(state.clearForm());
  }

  // Clear messages - Updated to clear both error and success messages
  void _onClearAppointmentError(
    ClearAppointmentError event,
    Emitter<AppointmentState> emit,
  ) {
    emit(state.copyWith(errorMessage: null, successMessage: null));
  }

  // Internal event handlers
  void _onInternalAppointmentsUpdated(
    _AppointmentsUpdated event,
    Emitter<AppointmentState> emit,
  ) {
    emit(
      state.copyWith(
        status: AppointmentStatus.success,
        appointments: event.appointments,
      ),
    );
  }

  void _onInternalAppointmentsError(
    _AppointmentsError event,
    Emitter<AppointmentState> emit,
  ) {
    emit(
      state.copyWith(
        status: AppointmentStatus.error,
        errorMessage: event.error,
      ),
    );
  }

  @override
  Future<void> close() {
    _appointmentsSubscription?.cancel();
    return super.close();
  }
}

// Internal events for stream handling
class _AppointmentsUpdated extends AppointmentEvent {
  final List<Appointment> appointments;

  const _AppointmentsUpdated(this.appointments);

  @override
  List<Object?> get props => [appointments];
}

class _AppointmentsError extends AppointmentEvent {
  final String error;

  const _AppointmentsError(this.error);

  @override
  List<Object?> get props => [error];
}
