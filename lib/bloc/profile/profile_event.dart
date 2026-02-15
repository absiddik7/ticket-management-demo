import 'package:equatable/equatable.dart';

/// Base class for all profile events
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load user profile
class LoadProfile extends ProfileEvent {
  const LoadProfile();
}

/// Event to refresh profile
class RefreshProfile extends ProfileEvent {
  const RefreshProfile();
}
