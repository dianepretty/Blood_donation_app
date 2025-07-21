class User {
  final String id;
  final String fullName;
  final String email;
  final String districtName;
  final String password;
  final String phoneNumber;
  final String gender;
  final String role;
  final String imageUrl;
  final String bloodType;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
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

  // Create a copy with modified fields
  User copyWith({
    String? id,
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
    return User(
      id: id ?? this.id,
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

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'districtName': districtName,
      'password': password,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'role': role,
      'imageUrl': imageUrl,
      'bloodType': bloodType,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      districtName: json['districtName'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      role: json['role'],
      imageUrl: json['imageUrl'],
      bloodType: json['bloodType'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  String toString() {
    return 'User{id: $id, fullName: $fullName, email: $email, districtName: $districtName, password: $password, phoneNumber: $phoneNumber, gender: $gender, role: $role, imageUrl: $imageUrl, bloodType: $bloodType, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
