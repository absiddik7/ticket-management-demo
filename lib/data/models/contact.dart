import 'package:equatable/equatable.dart';

/// Contact model representing a team member
class Contact extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String department;
  final String role;
  final String avatarUrl;
  final bool isOnline;

  const Contact({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.department,
    required this.role,
    required this.avatarUrl,
    this.isOnline = false,
  });

  /// Get initials from name
  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '';
  }

  /// Create a copy with updated fields
  Contact copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? department,
    String? role,
    String? avatarUrl,
    bool? isOnline,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      department: department ?? this.department,
      role: role ?? this.role,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        department,
        role,
        avatarUrl,
        isOnline,
      ];
}
