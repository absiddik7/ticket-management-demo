import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/repositories.dart';
import 'profile_event.dart';
import 'profile_state.dart';

/// BLoC for managing profile state
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc({ProfileRepository? profileRepository})
      : _profileRepository = profileRepository ?? ProfileRepository(),
        super(const ProfileState()) {
    on<LoadProfile>(_onLoadProfile);
    on<RefreshProfile>(_onRefreshProfile);
  }

  /// Handle load profile event
  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStateStatus.loading));

    try {
      final results = await Future.wait([
        _profileRepository.getUserProfile(),
        _profileRepository.getAssignedRoles(),
      ]);
      
      emit(state.copyWith(
        status: ProfileStateStatus.loaded,
        profile: results[0] as dynamic,
        assignedRoles: results[1] as List<Map<String, String>>,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Handle refresh profile event
  Future<void> _onRefreshProfile(
    RefreshProfile event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      final results = await Future.wait([
        _profileRepository.getUserProfile(),
        _profileRepository.getAssignedRoles(),
      ]);
      
      emit(state.copyWith(
        status: ProfileStateStatus.loaded,
        profile: results[0] as dynamic,
        assignedRoles: results[1] as List<Map<String, String>>,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
