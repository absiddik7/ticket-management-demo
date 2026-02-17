import '../models/models.dart';
import 'mock_data.dart';

/// Repository for user profile operations
/// Simulates API calls using mock data loaded from JSON files
class ProfileRepository {
  /// Get current user profile (simulates API call)
  Future<UserProfile> getUserProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));
    return await MockData.loadUserProfile();
  }

  /// Get assigned roles for user (simulates API call)
  Future<List<Map<String, String>>> getAssignedRoles() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return await MockData.loadAssignedRoles();
  }

  /// Update user profile (simulates API call)
  Future<UserProfile> updateProfile(UserProfile updatedProfile) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, this would send the update to the server
    return updatedProfile;
  }
}
