import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object?> get props => [];
}

class LanguageChanged extends LanguageEvent {
  final Locale locale;

  const LanguageChanged(this.locale);

  @override
  List<Object?> get props => [locale];
}

class LanguageLoaded extends LanguageEvent {}

// States
abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object?> get props => [];
}

class LanguageInitial extends LanguageState {}

class LanguageLoading extends LanguageState {}

class LanguageLoadedState extends LanguageState {
  final Locale locale;

  const LanguageLoadedState(this.locale);

  @override
  List<Object?> get props => [locale];
}

class LanguageError extends LanguageState {
  final String message;

  const LanguageError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  static const String _languageKey = 'selected_language';
  
  LanguageBloc() : super(LanguageInitial()) {
    on<LanguageLoaded>(_onLanguageLoaded);
    on<LanguageChanged>(_onLanguageChanged);
  }

  Future<void> _onLanguageLoaded(LanguageLoaded event, Emitter<LanguageState> emit) async {
    try {
      emit(LanguageLoading());
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString(_languageKey) ?? 'en';
      emit(LanguageLoadedState(Locale(languageCode)));
    } catch (e) {
      emit(LanguageError('Failed to load language preference'));
    }
  }

  Future<void> _onLanguageChanged(LanguageChanged event, Emitter<LanguageState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, event.locale.languageCode);
      emit(LanguageLoadedState(event.locale));
    } catch (e) {
      emit(LanguageError('Failed to save language preference'));
    }
  }
} 