import 'package:equatable/equatable.dart';
import '../models/appointment_model.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object?> get props => [];
}

class LoadAppointments extends AppointmentEvent {}

class AddAppointment extends AppointmentEvent {
  final Appointment appointment;

  const AddAppointment(this.appointment);

  @override
  List<Object?> get props => [appointment];
}

class UpdateAppointment extends AppointmentEvent {
  final Appointment appointment;

  const UpdateAppointment(this.appointment);

  @override
  List<Object?> get props => [appointment];
}

class DeleteAppointment extends AppointmentEvent {
  final String id; // Changed from appointmentId to id

  const DeleteAppointment(this.id); // Changed from appointmentId to id

  @override
  List<Object?> get props => [id]; // Changed from appointmentId to id
}

class RefreshAppointments extends AppointmentEvent {}
