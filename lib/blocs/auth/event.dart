import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthSignUpRequested extends AuthEvent {
  final String fullName;
  final String email;
  final String districtName;
  final String password;
  final String phoneNumber;
  final String gender;
  final String role;
  final String bloodType;
  final String imageUrl;
  final String hospital;

  const AuthSignUpRequested({
    required this.fullName,
    required this.email,
    required this.districtName,
    required this.password,
    required this.phoneNumber,
    required this.gender,
    required this.role,
    required this.bloodType,
    this.imageUrl = '',
    required this.hospital,
  });

  @override
  List<Object?> get props => [
    fullName,
    email,
    districtName,
    password,
    phoneNumber,
    gender,
    role,
    bloodType,
    imageUrl,
    hospital,
  ];
}

class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthSignOutRequested extends AuthEvent {}

class AuthUserChanged extends AuthEvent {
  final User? user;

  const AuthUserChanged(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthResetPasswordRequested extends AuthEvent {
  final String email;

  const AuthResetPasswordRequested(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthUpdateUserDataRequested extends AuthEvent {
  final Map<String, dynamic> data;

  const AuthUpdateUserDataRequested(this.data);

  @override
  List<Object?> get props => [data];
}

class AuthErrorCleared extends AuthEvent {}

class AuthGoogleSignInRequested extends AuthEvent {}

class AuthEmailVerificationRequested extends AuthEvent {}

class AuthCheckEmailVerificationRequested extends AuthEvent {}

class AuthStartEmailVerificationTimer extends AuthEvent {}

class AuthStopEmailVerificationTimer extends AuthEvent {}

// New event for getting user data by userId
class AuthGetUserDataRequested extends AuthEvent {
  final String userId;

  const AuthGetUserDataRequested(this.userId);

  @override
  List<Object?> get props => [userId];
}
