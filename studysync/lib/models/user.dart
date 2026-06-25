class User {
  final String id;
  final String name;
  final String email;
  final String? profilePictureUrl;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profilePictureUrl,
    required this.createdAt,
  });

  /// Copy with method for immutability
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profilePictureUrl,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Create from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;
}