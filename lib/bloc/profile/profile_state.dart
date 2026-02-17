import 'package:equatable/equatable.dart';
import 'package:ticket_management/data/models/user_profile.dart';

enum ProfileStateStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  final ProfileStateStatus status;
  final UserProfile? profile;
  final List<Map<String, String>> assignedRoles;
  final String? errorMessage;

  const ProfileState({
    this.status = ProfileStateStatus.initial,
    this.profile,
    this.assignedRoles = const [],
    this.errorMessage,
  });

  ProfileState copyWith({
    ProfileStateStatus? status,
    UserProfile? profile,
    List<Map<String, String>>? assignedRoles,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      assignedRoles: assignedRoles ?? this.assignedRoles,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, profile, assignedRoles, errorMessage];
}
