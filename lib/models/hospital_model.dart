class Hospital {
  final String name;
  final String district;
  final String imageUrl;

  final DateTime createdAt;
  final DateTime updatedAt;
  const Hospital({
    required this.name,
    required this.district,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a copy with modified fields
  Hospital copyWith({
    String? name,
    String? district,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Hospital(
      name: name ?? this.name,
      district: district ?? this.district,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'name': name,
      'district': district,
      'imageUrl': imageUrl,
    };
  }

  // Create from JSON
  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      name: json['name'],
      district: json['district'],
      imageUrl: json['imageUrl'],
    );
  }

  @override
  String toString() {
    return 'Hospital{createdAt: $createdAt, updatedAt: $updatedAt, name: $name, district: $district, imageUrl: $imageUrl}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Hospital &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.name == name &&
        other.district == district &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
        updatedAt.hashCode ^
        name.hashCode ^
        district.hashCode ^
        imageUrl.hashCode;
  }
}
