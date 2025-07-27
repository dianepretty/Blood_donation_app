import 'package:blood_system/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign up with email and password
  Future<UserCredential?> signUpWithEmailAndPassword({
    required String fullName,
    required String email,
    required String districtName,
    required String password,
    required String phoneNumber,
    required String gender,
    required String role,
    required String bloodType,
    String imageUrl = '',
  }) async {
    try {
      // Create Firebase Auth user
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user document in Firestore
      if (result.user != null) {
        final now = DateTime.now();
        final userDoc = UserModel(
          fullName: fullName,
          email: email,
          districtName: districtName,
          password: '', // Don't store password in Firestore
          phoneNumber: phoneNumber,
          gender: gender,
          role: role,
          imageUrl: imageUrl,
          bloodType: bloodType,
          createdAt: now,
          updatedAt: now,
        );

        await _firestore
            .collection('users')
            .doc(result.user!.uid)
            .set(userDoc.toJson());

        // Update display name
        await result.user!.updateDisplayName(fullName);

        // Send email verification
        await result.user!.sendEmailVerification();
      }

      return result;
    } catch (e) {
      debugPrint('Sign up error: $e');
      rethrow;
    }
  }

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } catch (e) {
      debugPrint('Sign in error: $e');
      rethrow;
    }
  }

  // Get user data from Firestore
  Future<UserModel?> getUserData(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      debugPrint('Get user data error: $e');
      return null;
    }
  }

  // Update user data
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      data['updatedAt'] = DateTime.now().toIso8601String();
      await _firestore.collection('users').doc(uid).update(data);
    } catch (e) {
      debugPrint('Update user data error: $e');
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint('Sign out error: $e');
      rethrow;
    }
  }

  // Delete account
  Future<void> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Delete user document from Firestore
        await _firestore.collection('users').doc(user.uid).delete();
        // Delete Firebase Auth account
        await user.delete();
      }
    } catch (e) {
      debugPrint('Delete account error: $e');
      rethrow;
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      debugPrint('Reset password error: $e');
      rethrow;
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      // Add scopes if needed
      googleProvider.addScope(
        'https://www.googleapis.com/auth/contacts.readonly',
      );

      // Once signed in, return the UserCredential
      UserCredential result = await _auth.signInWithPopup(googleProvider);

      // Check if user exists in Firestore, if not create user document
      if (result.user != null) {
        final userDoc =
            await _firestore.collection('users').doc(result.user!.uid).get();

        if (!userDoc.exists) {
          // Create new user document for Google sign-in
          final now = DateTime.now();
          final newUser = UserModel(
            fullName: result.user!.displayName ?? 'Google User',
            email: result.user!.email ?? '',
            districtName: '',
            password: '',
            phoneNumber: result.user!.phoneNumber ?? '',
            gender: '',
            role: 'VOLUNTEER', // Default role for Google users
            imageUrl: result.user!.photoURL ?? '',
            bloodType: '',
            createdAt: now,
            updatedAt: now,
          );

          await _firestore
              .collection('users')
              .doc(result.user!.uid)
              .set(newUser.toJson());
        }
      }

      return result;
    } catch (e) {
      debugPrint('Google sign in error: $e');
      rethrow;
    }
  }

  // Send email verification
  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      debugPrint('Send email verification error: $e');
      rethrow;
    }
  }

  // Check if email is verified
  bool isEmailVerified() {
    final user = _auth.currentUser;
    return user?.emailVerified ?? false;
  }

  // Reload user to check verification status
  Future<void> reloadUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.reload();
      }
    } catch (e) {
      debugPrint('Reload user error: $e');
      rethrow;
    }
  }
}
