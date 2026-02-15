import 'package:equatable/equatable.dart';
import '../../data/models/models.dart';

/// Profile state status
enum ProfileStateStatus { initial, loading, loaded, error }

/// State class for profile BLoC
class ProfileState extends Equatable {
  final ProfileStateStatus status;
  final UserProfile? profile;
  final String? errorMessage;

  const ProfileState({
    this.status = ProfileStateStatus.initial,
    this.profile,
    this.errorMessage,
  });

  /// Create a copy with updated fields
  ProfileState copyWith({
    ProfileStateStatus? status,
    UserProfile? profile,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, profile, errorMessage];
}
