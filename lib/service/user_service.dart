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
}

// Updated User model for Firestore (without password field)
class UserModel {
  final String fullName;
  final String email;
  final String districtName;
  final String password; // Keep for local use, but don't store in Firestore
  final String phoneNumber;
  final String gender;
  final String role;
  final String imageUrl;
  final String bloodType;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.fullName,
    required this.email,
    required this.districtName,
    required this.password,
    required this.phoneNumber,
    required this.gender,
    required this.role,
    required this.imageUrl,
    required this.bloodType,
    required this.createdAt,
    required this.updatedAt,
  });

  UserModel copyWith({
    String? fullName,
    String? email,
    String? districtName,
    String? password,
    String? phoneNumber,
    String? gender,
    String? role,
    String? imageUrl,
    String? bloodType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      districtName: districtName ?? this.districtName,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      role: role ?? this.role,
      imageUrl: imageUrl ?? this.imageUrl,
      bloodType: bloodType ?? this.bloodType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'districtName': districtName,
      // Don't include password in Firestore
      'phoneNumber': phoneNumber,
      'gender': gender,
      'role': role,
      'imageUrl': imageUrl,
      'bloodType': bloodType,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      districtName: json['districtName'] ?? '',
      password: '', // Password not stored in Firestore
      phoneNumber: json['phoneNumber'] ?? '',
      gender: json['gender'] ?? '',
      role: json['role'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      bloodType: json['bloodType'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  String toString() {
    return 'UserModel{fullName: $fullName, email: $email, districtName: $districtName, phoneNumber: $phoneNumber, gender: $gender, role: $role, imageUrl: $imageUrl, bloodType: $bloodType, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
