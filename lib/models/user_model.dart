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
  final bool isProfileComplete;
  final String hospital;
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
    this.isProfileComplete = false, // Default to false
    this.hospital = '', // Made optional with default empty string
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
    String? hospital,
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
      hospital: hospital ?? this.hospital,
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
      'hospital':
          hospital.isEmpty ? null : hospital, // Only include if not empty
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
      hospital: json['hospital'] ?? '', // Will use default empty string if null
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  String toString() {
    return 'UserModel{fullName: $fullName, email: $email, districtName: $districtName, phoneNumber: $phoneNumber, gender: $gender, role: $role, imageUrl: $imageUrl, bloodType: $bloodType, hospital: $hospital, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
