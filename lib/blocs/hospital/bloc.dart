import 'dart:async';
import 'package:blood_system/blocs/hospital/event.dart';
import 'package:blood_system/blocs/hospital/state.dart';
import 'package:blood_system/models/hospital_model.dart';
import 'package:blood_system/service/hospital_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalBloc extends Bloc<HospitalEvent, HospitalState> {
  final HospitalService _hospitalService;
  StreamSubscription<List<Hospital>>? _hospitalsSubscription;
  StreamSubscription<Hospital?>? _hospitalSubscription;

  HospitalBloc({required HospitalService hospitalService})
    : _hospitalService = hospitalService,
      super(const HospitalInitial()) {
    on<LoadAllHospitals>(_onLoadAllHospitals);
    on<LoadHospitalsByDistrict>(_onLoadHospitalsByDistrict);
    on<LoadHospitalById>(_onLoadHospitalById);
    on<ClearHospitalData>(_onClearHospitalData);
    on<RefreshHospitals>(_onRefreshHospitals);
    on<LoadDistricts>(_onLoadDistricts);
  }

  void _onLoadAllHospitals(
    LoadAllHospitals event,
    Emitter<HospitalState> emit,
  ) async {
    emit(const HospitalLoading());

    try {
      await _hospitalsSubscription?.cancel();
      final hospitals = await _hospitalService.getAllHospitals();
      emit(HospitalsLoaded(hospitals: hospitals));
    } catch (e) {
      emit(HospitalError(e.toString()));
    }
  }

  void _onLoadHospitalsByDistrict(
    LoadHospitalsByDistrict event,
    Emitter<HospitalState> emit,
  ) async {
    emit(const HospitalLoading());

    try {
      await _hospitalsSubscription?.cancel();
      _hospitalsSubscription = _hospitalService
          .getHospitalsByDistrict(event.district)
          .listen(
            (hospitals) => emit(
              HospitalsLoaded(
                hospitals: hospitals,
                selectedDistrict: event.district,
              ),
            ),
            onError: (error) => emit(HospitalError(error.toString())),
          );
    } catch (e) {
      emit(HospitalError(e.toString()));
    }
  }

  void _onLoadHospitalById(
    LoadHospitalById event,
    Emitter<HospitalState> emit,
  ) async {
    emit(const HospitalLoading());

    try {
      await _hospitalSubscription?.cancel();
      _hospitalSubscription = _hospitalService
          .getHospitalById(event.hospitalId)
          .listen((hospital) {
            if (hospital != null) {
              emit(HospitalDetailLoaded(hospital));
            } else {
              emit(HospitalNotFound(event.hospitalId));
            }
          }, onError: (error) => emit(HospitalError(error.toString())));
    } catch (e) {
      emit(HospitalError(e.toString()));
    }
  }

  void _onClearHospitalData(
    ClearHospitalData event,
    Emitter<HospitalState> emit,
  ) async {
    await _hospitalsSubscription?.cancel();
    await _hospitalSubscription?.cancel();
    emit(const HospitalInitial());
  }

  void _onRefreshHospitals(
    RefreshHospitals event,
    Emitter<HospitalState> emit,
  ) async {
    final currentState = state;
    if (currentState is HospitalsLoaded) {
      if (currentState.selectedDistrict != null) {
        add(LoadHospitalsByDistrict(currentState.selectedDistrict!));
      } else {
        add(const LoadAllHospitals());
      }
    } else {
      add(const LoadAllHospitals());
    }
  }

  void _onLoadDistricts(
    LoadDistricts event,
    Emitter<HospitalState> emit,
  ) async {
    emit(const HospitalLoading());

    try {
      final districts = await _hospitalService.getAllDistricts();
      emit(DistrictsLoaded(districts));
    } catch (e) {
      emit(HospitalError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _hospitalsSubscription?.cancel();
    _hospitalSubscription?.cancel();
    return super.close();
  }
}
