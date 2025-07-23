// bloc/appointment_event.dart
import 'package:equatable/equatable.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object?> get props => [];
}

// Load user's appointments
class LoadUserAppointments extends AppointmentEvent {
  final String userId;

  const LoadUserAppointments(this.userId);

  @override
  List<Object?> get props => [userId];
}

// Load hospitals
class LoadHospitals extends AppointmentEvent {
  const LoadHospitals();
}

// Select date
class SelectAppointmentDate extends AppointmentEvent {
  final DateTime date;

  const SelectAppointmentDate(this.date);

  @override
  List<Object?> get props => [date];
}

// Select hospital
class SelectHospital extends AppointmentEvent {
  final String hospitalName;

  const SelectHospital({
    required this.hospitalName,
  });

  @override
  List<Object?> get props => [hospitalName];
}

// Load available time slots
class LoadAvailableTimeSlots extends AppointmentEvent {
  final String hospitalName;
  final DateTime date;

  const LoadAvailableTimeSlots({
    required this.hospitalName,
    required this.date,
  });

  @override
  List<Object?> get props => [hospitalName, date];
}

// Select time slot
class SelectTimeSlot extends AppointmentEvent {
  final String timeSlot;

  const SelectTimeSlot(this.timeSlot);

  @override
  List<Object?> get props => [timeSlot];
}

// Book appointment
class BookAppointment extends AppointmentEvent {
  final String userId;
  // final String hospitalId;
  final String hospitalName;
  final DateTime appointmentDate;
  final String appointmentTime;

  const BookAppointment({
    required this.userId,
    // required this.hospitalId,
    required this.hospitalName,
    required this.appointmentDate,
    required this.appointmentTime,
  });

  @override
  List<Object?> get props => [
        userId,
        // hospitalId,
        hospitalName,
        appointmentDate,
        appointmentTime,
      ];

  get hospitalId => null;
}

// Cancel appointment
class CancelAppointment extends AppointmentEvent {
  final String appointmentId;

  const CancelAppointment(this.appointmentId);

  @override
  List<Object?> get props => [appointmentId];
}

// Update appointment status
class UpdateAppointmentStatus extends AppointmentEvent {
  final String appointmentId;
  final String status;

  const UpdateAppointmentStatus({
    required this.appointmentId,
    required this.status,
  });

  @override
  List<Object?> get props => [appointmentId, status];
}

// Reset form
class ResetAppointmentForm extends AppointmentEvent {
  const ResetAppointmentForm();
}

// Clear error
class ClearAppointmentError extends AppointmentEvent {
  const ClearAppointmentError();
}