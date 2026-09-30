class User {
  final String nrp;
  final String role;
  final bool isActive;

  const User({
    required this.nrp,
    required this.role,
    required this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        nrp: json['nrp'] as String? ?? '',
        role: json['role'] as String? ?? 'user',
        isActive: json['is_active'] as bool? ?? true,
      );

  Map<String, dynamic> toJson() => {
        'nrp': nrp,
        'role': role,
        'is_active': isActive,
      };

  User copyWith({
    String? nrp,
    String? role,
    bool? isActive,
  }) {
    return User(
      nrp: nrp ?? this.nrp,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
    );
  }
}
