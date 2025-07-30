import 'package:blood_system/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User firebaseUser;
  final UserModel? userData;

  const AuthAuthenticated({required this.firebaseUser, this.userData});

  @override
  List<Object?> get props => [firebaseUser, userData];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthPasswordResetSent extends AuthState {
  final String email;

  const AuthPasswordResetSent(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthEmailVerificationSent extends AuthState {
  final String email;

  const AuthEmailVerificationSent(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthEmailNotVerified extends AuthState {
  final String message;

  const AuthEmailNotVerified(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthEmailVerified extends AuthState {
  final String message;

  const AuthEmailVerified(this.message);

  @override
  List<Object?> get props => [message];
}

// New state for when user data is loaded for a specific user
class AuthUserDataLoaded extends AuthState {
  final String userId;
  final UserModel? userData;

  const AuthUserDataLoaded({required this.userId, this.userData});

  @override
  List<Object?> get props => [userId, userData];
}

class AuthSignInSuccess extends AuthState {
  final String message;

  const AuthSignInSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AuthSignUpSuccess extends AuthState {
  final String message;

  const AuthSignUpSuccess(this.message);

  @override
  List<Object> get props => [message];
}
