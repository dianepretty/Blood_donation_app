import 'package:equatable/equatable.dart';

abstract class HospitalEvent extends Equatable {
  const HospitalEvent();

  @override
  List<Object?> get props => [];
}

// Event to load all hospitals
class LoadAllHospitals extends HospitalEvent {
  const LoadAllHospitals();
}

// Event to load hospitals by district
class LoadHospitalsByDistrict extends HospitalEvent {
  final String district;

  const LoadHospitalsByDistrict(this.district);

  @override
  List<Object?> get props => [district];
}

// Event to load a specific hospital by ID
class LoadHospitalById extends HospitalEvent {
  final String hospitalId;

  const LoadHospitalById(this.hospitalId);

  @override
  List<Object?> get props => [hospitalId];
}

// Event to clear hospital data
class ClearHospitalData extends HospitalEvent {
  const ClearHospitalData();
}

// Event to refresh hospital data
class RefreshHospitals extends HospitalEvent {
  const RefreshHospitals();
}

// Event to load districts
class LoadDistricts extends HospitalEvent {
  const LoadDistricts();
}
