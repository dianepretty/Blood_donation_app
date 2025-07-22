import 'package:blood_system/models/hospital_model.dart';
import 'package:equatable/equatable.dart';

abstract class HospitalState extends Equatable {
  const HospitalState();

  @override
  List<Object?> get props => [];
}

// Initial state
class HospitalInitial extends HospitalState {
  const HospitalInitial();
}

// Loading state
class HospitalLoading extends HospitalState {
  const HospitalLoading();
}

// State when hospitals are loaded successfully
class HospitalsLoaded extends HospitalState {
  final List<Hospital> hospitals;
  final String? selectedDistrict;

  const HospitalsLoaded({required this.hospitals, this.selectedDistrict});

  @override
  List<Object?> get props => [hospitals, selectedDistrict];

  HospitalsLoaded copyWith({
    List<Hospital>? hospitals,
    String? selectedDistrict,
  }) {
    return HospitalsLoaded(
      hospitals: hospitals ?? this.hospitals,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
    );
  }
}

// State when a single hospital is loaded
class HospitalDetailLoaded extends HospitalState {
  final Hospital hospital;

  const HospitalDetailLoaded(this.hospital);

  @override
  List<Object?> get props => [hospital];
}

// State when hospital is not found
class HospitalNotFound extends HospitalState {
  final String hospitalId;

  const HospitalNotFound(this.hospitalId);

  @override
  List<Object?> get props => [hospitalId];
}

// Error state
class HospitalError extends HospitalState {
  final String message;

  const HospitalError(this.message);

  @override
  List<Object?> get props => [message];
}

// State when districts are loaded
class DistrictsLoaded extends HospitalState {
  final List<String> districts;

  const DistrictsLoaded(this.districts);

  @override
  List<Object?> get props => [districts];
}

// Combined state for hospitals and districts
class HospitalsWithDistrictsLoaded extends HospitalState {
  final List<Hospital> hospitals;
  final List<String> districts;
  final String? selectedDistrict;

  const HospitalsWithDistrictsLoaded({
    required this.hospitals,
    required this.districts,
    this.selectedDistrict,
  });

  @override
  List<Object?> get props => [hospitals, districts, selectedDistrict];

  HospitalsWithDistrictsLoaded copyWith({
    List<Hospital>? hospitals,
    List<String>? districts,
    String? selectedDistrict,
  }) {
    return HospitalsWithDistrictsLoaded(
      hospitals: hospitals ?? this.hospitals,
      districts: districts ?? this.districts,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
    );
  }
}
