import 'package:ticket_management/data/models/user_profile.dart';
import 'mock_data.dart';

class ProfileRepository {
  Future<UserProfile> getUserProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));
    return await MockData.loadUserProfile();
  }

  Future<List<Map<String, String>>> getAssignedRoles() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return await MockData.loadAssignedRoles();
  }

  Future<UserProfile> updateProfile(UserProfile updatedProfile) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, this would send the update to the server
    return updatedProfile;
  }
}
