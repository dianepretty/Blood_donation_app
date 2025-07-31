import 'package:blood_system/models/appointment_model.dart';
import 'package:blood_system/models/hospital_model.dart';
import 'package:equatable/equatable.dart';

enum AppointmentStatus { initial, loading, success, error }

class AppointmentState extends Equatable {
  final AppointmentStatus status;
  final List<Appointment> appointments;
  final List<Hospital> hospitals;
  final List<String> availableTimeSlots;

  // Form fields
  final DateTime? selectedDate;
  final String? selectedHospitalName;
  final String? selectedTimeSlot;
  final String? notes;

  // User details
  final String? fullName;
  final String? phoneNumber;
  final String? bloodGroup;

  // Status indicators
  final bool isBooking;
  final bool isLoadingTimeSlots;
  final bool isLoadingHospitals;
  final bool isRescheduling;
  final String? errorMessage;
  final String? successMessage;

  const AppointmentState({
    this.status = AppointmentStatus.initial,
    this.appointments = const [],
    this.hospitals = const [],
    this.availableTimeSlots = const [],
    this.selectedDate,
    this.selectedHospitalName,
    this.selectedTimeSlot,
    this.notes,
    this.isBooking = false,
    this.isLoadingTimeSlots = false,
    this.isLoadingHospitals = false,
    this.isRescheduling = false,
    this.errorMessage,
    this.successMessage,
    this.fullName,
    this.phoneNumber,
    this.bloodGroup,
  });

  // FIXED: Use selectedHospitalName instead of selectedHospitalId
  bool get canBookAppointment =>
      selectedDate != null &&
      selectedHospitalName != null &&
      selectedTimeSlot != null &&
      !isBooking;

  bool get hasFormData =>
      selectedDate != null ||
      selectedHospitalName != null ||
      selectedTimeSlot != null;

  List<Appointment> get upcomingAppointments =>
      appointments
          .where((apt) => apt.appointmentDate.isAfter(DateTime.now()))
          .toList();

  List<Appointment> get pastAppointments =>
      appointments
          .where((apt) => apt.appointmentDate.isBefore(DateTime.now()))
          .toList();

  AppointmentState copyWith({
    AppointmentStatus? status,
    List<Appointment>? appointments,
    List<Hospital>? hospitals,
    List<String>? availableTimeSlots,
    DateTime? selectedDate,
    String? selectedHospitalName,
    String? selectedTimeSlot,
    String? notes,
    bool? isBooking,
    bool? isLoadingTimeSlots,
    bool? isLoadingHospitals,
    bool? isRescheduling,
    String? errorMessage,
    String? successMessage,
    String? fullName,
    String? phoneNumber,
    String? bloodGroup,
  }) {
    return AppointmentState(
      status: status ?? this.status,
      appointments: appointments ?? this.appointments,
      hospitals: hospitals ?? this.hospitals,
      availableTimeSlots: availableTimeSlots ?? this.availableTimeSlots,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedHospitalName: selectedHospitalName ?? this.selectedHospitalName,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      notes: notes ?? this.notes,
      isBooking: isBooking ?? this.isBooking,
      isLoadingTimeSlots: isLoadingTimeSlots ?? this.isLoadingTimeSlots,
      isLoadingHospitals: isLoadingHospitals ?? this.isLoadingHospitals,
      isRescheduling: isRescheduling ?? this.isRescheduling,
      errorMessage: errorMessage,
      successMessage: successMessage,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bloodGroup: bloodGroup ?? this.bloodGroup,
    );
  }

  // Clear form fields
  AppointmentState clearForm() {
    return copyWith(
      selectedDate: null,
      selectedHospitalName: null,
      selectedTimeSlot: null,
      notes: null,
      availableTimeSlots: [],
      errorMessage: null,
      successMessage: null,
    );
  }

  // Clear error and success messages
  AppointmentState clearMessages() {
    return copyWith(
      selectedDate: null,
      selectedHospitalName: null,
      selectedTimeSlot: null,
      availableTimeSlots: [],
      errorMessage: null,
      successMessage: null,
    );
  }

  @override
  List<Object?> get props => [
    status,
    appointments,
    hospitals,
    availableTimeSlots,
    selectedDate,
    selectedHospitalName,
    selectedTimeSlot,
    notes,
    isBooking,
    isLoadingTimeSlots,
    isLoadingHospitals,
    isRescheduling,
    errorMessage,
    successMessage,
    fullName,
    phoneNumber,
    bloodGroup,
  ];

  @override
  String toString() {
    return '''AppointmentState {
      status: $status,
      appointmentsCount: ${appointments.length},
      hospitalsCount: ${hospitals.length},
      selectedDate: $selectedDate,
      selectedHospital: $selectedHospitalName,
      selectedTime: $selectedTimeSlot,
      canBook: $canBookAppointment,
      isBooking: $isBooking,
      error: $errorMessage
    }''';
  }
}
