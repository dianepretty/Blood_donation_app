import 'dart:async';
import 'package:blood_system/blocs/auth/event.dart';
import 'package:blood_system/blocs/auth/state.dart';
import 'package:blood_system/service/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  StreamSubscription<User?>? _authStateSubscription;
  Timer? _emailVerificationTimer;

  AuthBloc({required AuthService authService})
    : _authService = authService,
      super(AuthInitial()) {
    // Register event handlers
    on<AuthStarted>(_onAuthStarted);
    on<AuthSignUpRequested>(_onAuthSignUpRequested);
    on<AuthSignInRequested>(_onAuthSignInRequested);
    on<AuthSignOutRequested>(_onAuthSignOutRequested);
    on<AuthUserChanged>(_onAuthUserChanged);
    on<AuthResetPasswordRequested>(_onAuthResetPasswordRequested);
    on<AuthUpdateUserDataRequested>(_onAuthUpdateUserDataRequested);
    on<AuthErrorCleared>(_onAuthErrorCleared);
    on<AuthGoogleSignInRequested>(_onAuthGoogleSignInRequested);
    on<AuthEmailVerificationRequested>(_onAuthEmailVerificationRequested);
    on<AuthCheckEmailVerificationRequested>(
      _onAuthCheckEmailVerificationRequested,
    );
    on<AuthStartEmailVerificationTimer>(_onAuthStartEmailVerificationTimer);
    on<AuthStopEmailVerificationTimer>(_onAuthStopEmailVerificationTimer);
  }

  // Start listening to auth state changes
  void _onAuthStarted(AuthStarted event, Emitter<AuthState> emit) {
    _authStateSubscription?.cancel();
    _authStateSubscription = _authService.authStateChanges.listen(
      (user) => add(AuthUserChanged(user)),
    );
  }

  // Handle user state changes
  Future<void> _onAuthUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) async {
    print('AuthBloc - _onAuthUserChanged called');
    print('AuthBloc - User: ${event.user?.uid}');

    if (event.user != null) {
      print('AuthBloc - User is not null, emitting AuthLoading');
      emit(AuthLoading());
      try {
        // Get user data from Firestore
        print('AuthBloc - Getting user data from Firestore');
        final userData = await _authService.getUserData(event.user!.uid);
        print('AuthBloc - User data retrieved: ${userData?.toJson()}');
        emit(AuthAuthenticated(firebaseUser: event.user!, userData: userData));
        print('AuthBloc - Emitted AuthAuthenticated');
      } catch (e) {
        print('AuthBloc - Error getting user data: ${e.toString()}');
        emit(AuthError('Failed to load user data: ${e.toString()}'));
      }
    } else {
      print('AuthBloc - User is null, emitting AuthUnauthenticated');
      emit(AuthUnauthenticated());
    }
  }

  // Handle sign up
  Future<void> _onAuthSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    print('AuthBloc - _onAuthSignUpRequested called');
    print('AuthBloc - Email: ${event.email}');
    print('AuthBloc - Role: ${event.role}');
    print('AuthBloc - Hospital: ${event.hospital}');
    emit(AuthLoading());
    try {
      print('AuthBloc - Calling signUpWithEmailAndPassword ${event.hospital}');
      await _authService.signUpWithEmailAndPassword(
        fullName: event.fullName,
        email: event.email,
        districtName: event.districtName,
        password: event.password,
        phoneNumber: event.phoneNumber,
        gender: event.gender,
        role: event.role,
        bloodType: event.bloodType,
        imageUrl: event.imageUrl,
        hospital: event.hospital,
      );

      // After successful signup, emit success state first
      print('AuthBloc - Signup successful, emitting AuthSignUpSuccess');
      emit(AuthSignUpSuccess('Account created successfully!'));

      // After successful signup, emit email verification sent state
      final currentUser = _authService.currentUser;
      if (currentUser != null) {
        print(
          'AuthBloc - Signup successful, emitting AuthEmailVerificationSent',
        );
        emit(AuthEmailVerificationSent(currentUser.email ?? ''));
      }
    } on FirebaseAuthException catch (e) {
      print('AuthBloc - FirebaseAuthException during signup: ${e.code}');
      final errorMessage = _getErrorMessage(e.code);
      print('AuthBloc - Emitting AuthError during signup: $errorMessage');
      emit(AuthError(errorMessage));
    } catch (e) {
      print('AuthBloc - Unexpected error during signup: ${e.toString()}');
      final errorMessage = 'An unexpected error occurred: ${e.toString()}';
      print('AuthBloc - Emitting AuthError during signup: $errorMessage');
      emit(AuthError(errorMessage));
    }
  }

  // Handle sign in
  Future<void> _onAuthSignInRequested(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    print('AuthBloc - _onAuthSignInRequested called');
    print('AuthBloc - Email: ${event.email}');
    emit(AuthLoading());
    try {
      print('AuthBloc - Calling signInWithEmailAndPassword');
      await _authService.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // Emit success state
      emit(AuthSignInSuccess('Login successful! Welcome back.'));
      print('AuthBloc - Sign in successful, AuthUserChanged will be triggered');

      // AuthUserChanged will be triggered automatically by auth state stream
    } on FirebaseAuthException catch (e) {
      print('AuthBloc - FirebaseAuthException: ${e.code}');
      final errorMessage = _getErrorMessage(e.code);
      print('AuthBloc - Emitting AuthError: $errorMessage');
      debugPrint('FirebaseAuthException in signIn: ${e.code} - ${e.message}');

      // Handle specific reCAPTCHA related errors
      if (e.code == 'recaptcha-not-enabled' ||
          e.code == 'missing-recaptcha-token' ||
          e.message?.contains('reCAPTCHA') == true) {
        throw FirebaseAuthException(
          code: 'recaptcha-error',
          message:
              'reCAPTCHA verification failed. Please try again or contact support.',
        );
      }

      emit(AuthError(errorMessage));
    } catch (e) {
      print('AuthBloc - Unexpected error: ${e.toString()}');
      final errorMessage = 'An unexpected error occurred: ${e.toString()}';
      print('AuthBloc - Emitting AuthError: $errorMessage');
      emit(AuthError(errorMessage));
    }
  }

  // Handle sign out
  Future<void> _onAuthSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _authService.signOut();
      // AuthUserChanged will be triggered automatically by auth state stream
    } catch (e) {
      emit(AuthError('Error signing out: ${e.toString()}'));
    }
  }

  // Handle password reset
  Future<void> _onAuthResetPasswordRequested(
    AuthResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _authService.resetPassword(event.email);
      emit(AuthPasswordResetSent(event.email));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_getErrorMessage(e.code)));
    } catch (e) {
      emit(AuthError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  // Handle user data update
  Future<void> _onAuthUpdateUserDataRequested(
    AuthUpdateUserDataRequested event,
    Emitter<AuthState> emit,
  ) async {
    final currentState = state;
    if (currentState is AuthAuthenticated) {
      try {
        await _authService.updateUserData(
          currentState.firebaseUser.uid,
          event.data,
        );

        // Reload user data
        final updatedUserData = await _authService.getUserData(
          currentState.firebaseUser.uid,
        );

        emit(
          AuthAuthenticated(
            firebaseUser: currentState.firebaseUser,
            userData: updatedUserData,
          ),
        );
      } catch (e) {
        emit(AuthError('Error updating user data: ${e.toString()}'));
      }
    }
  }

  // Clear error
  void _onAuthErrorCleared(AuthErrorCleared event, Emitter<AuthState> emit) {
    if (state is AuthError) {
      emit(AuthUnauthenticated());
    }
  }

  // Handle Google sign in
  Future<void> _onAuthGoogleSignInRequested(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authService.signInWithGoogle();
      // AuthUserChanged will be triggered automatically by auth state stream
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_getErrorMessage(e.code)));
    } catch (e) {
      emit(AuthError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  // Handle email verification request
  Future<void> _onAuthEmailVerificationRequested(
    AuthEmailVerificationRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _authService.sendEmailVerification();
      final currentUser = _authService.currentUser;
      if (currentUser != null) {
        emit(AuthEmailVerificationSent(currentUser.email ?? ''));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_getErrorMessage(e.code)));
    } catch (e) {
      emit(AuthError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  // Handle email verification check
  Future<void> _onAuthCheckEmailVerificationRequested(
    AuthCheckEmailVerificationRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _authService.reloadUser();
      if (_authService.isEmailVerified()) {
        // User is verified - update authentication state
        final currentUser = _authService.currentUser;
        if (currentUser != null) {
          // Get updated user data and emit authenticated state
          final userData = await _authService.getUserData(currentUser.uid);
          emit(
            AuthAuthenticated(firebaseUser: currentUser, userData: userData),
          );
        } else {
          emit(AuthEmailVerified('Email verified successfully!'));
        }
      } else {
        emit(
          AuthEmailNotVerified(
            'Please verify your email address before continuing.',
          ),
        );
      }
    } catch (e) {
      emit(AuthError('Error checking email verification: ${e.toString()}'));
    }
  }

  // Start email verification timer
  void _onAuthStartEmailVerificationTimer(
    AuthStartEmailVerificationTimer event,
    Emitter<AuthState> emit,
  ) {
    _emailVerificationTimer?.cancel();
    _emailVerificationTimer = Timer.periodic(const Duration(seconds: 3), (
      timer,
    ) {
      add(AuthCheckEmailVerificationRequested());
    });
  }

  // Stop email verification timer
  void _onAuthStopEmailVerificationTimer(
    AuthStopEmailVerificationTimer event,
    Emitter<AuthState> emit,
  ) {
    _emailVerificationTimer?.cancel();
    _emailVerificationTimer = null;
  }

  // Get user-friendly error messages
  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'operation-not-allowed':
        return 'Operation not allowed.';
      case 'email-not-verified':
        return 'Please verify your email address before signing in. Check your inbox for a verification link.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but different sign-in credentials.';
      case 'popup-closed-by-user':
        return 'Sign-in was cancelled.';
      case 'popup-blocked':
        return 'Sign-in popup was blocked. Please allow popups for this site.';
      case 'recaptcha-not-enabled':
      case 'missing-recaptcha-token':
      case 'recaptcha-error':
        return 'Security verification failed. Please try again or contact support if the issue persists.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection and try again.';
      case 'invalid-credential':
        return 'Invalid login credentials. Please check your email and password.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    _emailVerificationTimer?.cancel();
    return super.close();
  }
}
