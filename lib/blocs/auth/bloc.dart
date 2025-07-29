import 'dart:async';
import 'package:blood_system/blocs/auth/event.dart';
import 'package:blood_system/blocs/auth/state.dart';
import 'package:blood_system/service/user_service.dart';
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
      onError: (error) {
        print('AuthBloc - Auth state stream error: $error');
        add(AuthUserChanged(null));
      },
    );
  }

  // Handle user state changes OLD VERSION
  // Future<void> _onAuthUserChanged(
  //   AuthUserChanged event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   print('AuthBloc - _onAuthUserChanged called');
  //   print('AuthBloc - User: ${event.user?.uid}');

  //   if (event.user != null) {
  //     print('AuthBloc - User is not null, emitting AuthLoading');
  //     emit(AuthLoading());
  //     try {
  //       // Check if email is verified
  //       if (!event.user!.emailVerified) {
  //         print(
  //           'AuthBloc - Email not verified, emitting AuthEmailVerificationSent',
  //         );
  //         emit(AuthEmailVerificationSent(event.user!.email ?? ''));
  //         return;
  //       }

  //       // Get user data from Firestore
  //       print('AuthBloc - Getting user data from Firestore');
  //       final userData = await _authService.getUserData(event.user!.uid);
  //       print('AuthBloc - User data retrieved: ${userData?.toJson()}');
  //       emit(AuthAuthenticated(firebaseUser: event.user!, userData: userData));
  //       print('AuthBloc - Emitted AuthAuthenticated');
  //     } catch (e) {
  //       print('AuthBloc - Error getting user data: ${e.toString()}');
  //       emit(AuthError('Failed to load user data: ${e.toString()}'));
  //     }
  //   } else {
  //     print('AuthBloc - User is null, emitting AuthUnauthenticated');
  //     emit(AuthUnauthenticated());
  //   }
  // }

  // Handle sign up
  Future<void> _onAuthSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
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
      );

      // Send verification email immediately after signup
      await _authService.sendEmailVerification();

      // Let AuthUserChanged handle the rest
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_getErrorMessage(e.code)));
    } catch (e) {
      emit(AuthError('An unexpected error occurred: ${e.toString()}'));
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
      print('AuthBloc - Sign in successful, AuthUserChanged will be triggered');
      // AuthUserChanged will be triggered automatically by auth state stream
    } on FirebaseAuthException catch (e) {
      print('AuthBloc - FirebaseAuthException: ${e.code}');
      final errorMessage = _getErrorMessage(e.code);
      print('AuthBloc - Emitting AuthError: $errorMessage');
      emit(AuthError(errorMessage));
    } catch (e) {
      print('AuthBloc - Unexpected error: ${e.toString()}');
      final errorMessage = 'An unexpected error occurred: ${e.toString()}';
      print('AuthBloc - Emitting AuthError: $errorMessage');
      emit(AuthError(errorMessage));
    }
  }

  // Handle Google sign in
  Future<void> _onAuthGoogleSignInRequested(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    print('AuthBloc - _onAuthGoogleSignInRequested called');
    emit(AuthLoading());
    try {
      print('AuthBloc - Calling signInWithGoogle');
      await _authService.signInWithGoogle();
      print(
        'AuthBloc - Google sign in successful, AuthUserChanged will be triggered',
      );
      // AuthUserChanged will be triggered automatically by auth state stream
    } on FirebaseAuthException catch (e) {
      print(
        'AuthBloc - FirebaseAuthException during Google sign-in: ${e.code}',
      );
      emit(AuthError(_getGoogleSignInErrorMessage(e.code)));
    } catch (e) {
      print(
        'AuthBloc - Unexpected error during Google sign-in: ${e.toString()}',
      );
      emit(AuthError('Google sign-in failed: ${e.toString()}'));
    }
  }

  // Updated _onAuthUserChanged to handle profile completion
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
        // Check if email is verified (skip for Google sign-in)
        final isGoogleUser = event.user!.providerData.any(
          (provider) => provider.providerId == 'google.com',
        );

        if (!isGoogleUser && !event.user!.emailVerified) {
          print(
            'AuthBloc - Email not verified, emitting AuthEmailVerificationSent',
          );
          emit(AuthEmailVerificationSent(event.user!.email ?? ''));
          return;
        }

        // Get user data from Firestore
        print('AuthBloc - Getting user data from Firestore');
        final userData = await _authService.getUserData(event.user!.uid)
            .timeout(const Duration(seconds: 15));
        print('AuthBloc - User data retrieved: $userData');

        if (userData != null) {
          emit(AuthAuthenticated(firebaseUser: event.user!, userData: userData));
          print('AuthBloc - Emitted AuthAuthenticated');
        } else {
          // If user data is null, emit unauthenticated state
          print('AuthBloc - User data is null, emitting AuthUnauthenticated');
          emit(AuthUnauthenticated());
        }
      } catch (e) {
        print('AuthBloc - Error getting user data: ${e.toString()}');
        // Instead of emitting error, emit unauthenticated to prevent infinite loading
        emit(AuthUnauthenticated());
      }
    } else {
      print('AuthBloc - User is null, emitting AuthUnauthenticated');
      emit(AuthUnauthenticated());
    }
  }

  // Add Google-specific error messages
  String _getGoogleSignInErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but different sign-in credentials.';
      case 'invalid-credential':
        return 'The credential received is malformed or has expired.';
      case 'operation-not-allowed':
        return 'Google sign-in is not enabled for this project.';
      case 'user-disabled':
        return 'The user account has been disabled by an administrator.';
      case 'user-not-found':
        return 'No user found for this account.';
      case 'wrong-password':
        return 'Invalid password for this account.';
      case 'invalid-verification-code':
        return 'Invalid verification code.';
      case 'invalid-verification-id':
        return 'Invalid verification ID.';
      case 'sign_in_canceled':
        return 'Google sign-in was canceled.';
      case 'google-sign-in-failed':
        return 'Google sign-in failed. Please try again.';
      default:
        return 'An error occurred during Google sign-in. Please try again.';
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

  // // Handle Google sign in
  // Future<void> _onAuthGoogleSignInRequested(
  //   AuthGoogleSignInRequested event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   emit(AuthLoading());
  //   try {
  //     await _authService.signInWithGoogle();
  //     // AuthUserChanged will be triggered automatically by auth state stream
  //   } on FirebaseAuthException catch (e) {
  //     emit(AuthError(_getErrorMessage(e.code)));
  //   } catch (e) {
  //     emit(AuthError('An unexpected error occurred: ${e.toString()}'));
  //   }
  // }

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
    _emailVerificationTimer = Timer.periodic(const Duration(seconds: 15), (
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
