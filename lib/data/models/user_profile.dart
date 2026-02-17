import 'package:equatable/equatable.dart';

/// User profile model
class UserProfile extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String department;
  final String role;
  final String avatarUrl;
  final DateTime joinedAt;
  final int ticketsCreated;
  final int ticketsResolved;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.department,
    required this.role,
    required this.avatarUrl,
    required this.joinedAt,
    required this.ticketsCreated,
    required this.ticketsResolved,
  });

  /// Create a UserProfile from JSON map
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      department: json['department'] as String,
      role: json['role'] as String,
      avatarUrl: json['avatar_url'] as String,
      joinedAt: DateTime.parse(json['joined_at'] as String),
      ticketsCreated: json['tickets_created'] as int,
      ticketsResolved: json['tickets_resolved'] as int,
    );
  }

  /// Convert UserProfile to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'department': department,
      'role': role,
      'avatar_url': avatarUrl,
      'joined_at': joinedAt.toIso8601String(),
      'tickets_created': ticketsCreated,
      'tickets_resolved': ticketsResolved,
    };
  }

  /// Get initials from name
  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '';
  }

  /// Create a copy with updated fields
  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? department,
    String? role,
    String? avatarUrl,
    DateTime? joinedAt,
    int? ticketsCreated,
    int? ticketsResolved,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      department: department ?? this.department,
      role: role ?? this.role,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      joinedAt: joinedAt ?? this.joinedAt,
      ticketsCreated: ticketsCreated ?? this.ticketsCreated,
      ticketsResolved: ticketsResolved ?? this.ticketsResolved,
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
        joinedAt,
        ticketsCreated,
        ticketsResolved,
      ];
}
