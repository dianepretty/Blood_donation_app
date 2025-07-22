import 'package:equatable/equatable.dart';
import '../models/appointment_model.dart';


abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object?> get props => [];
}


class AppointmentLoading extends AppointmentState {}

class AppointmentLoaded extends AppointmentState {

  final List<Appointment> upcomingAppointments;
  final List<Appointment> pastAppointments; // Added pastAppointments

  const AppointmentLoaded({
    // this.appointments = const [], // Removed
    this.upcomingAppointments = const [],
    this.pastAppointments = const [], // Initialized
  });

  @override
  List<Object?> get props => [upcomingAppointments, pastAppointments]; // Updated props
}

class AppointmentError extends AppointmentState {
  final String message;

  const AppointmentError(this.message);

  @override
  List<Object?> get props => [message];
}

class AppointmentOperationSuccess extends AppointmentState {
  final String message;

  final List<Appointment> upcomingAppointments;
  final List<Appointment> pastAppointments; // Added pastAppointments

  const AppointmentOperationSuccess(
      this.message, { // Changed to positional parameter for message

        this.upcomingAppointments = const [],
        this.pastAppointments = const [], // Initialized
      });

  @override
  List<Object?> get props => [message, upcomingAppointments, pastAppointments]; // Updated props
}
