import '../models/models.dart';
import 'mock_data.dart';

/// Repository for contact-related operations
/// Simulates API calls using mock data
class ContactRepository {
  /// Get all contacts (simulates API call)
  Future<List<Contact>> getContacts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return MockData.contacts;
  }

  /// Search contacts by query
  Future<List<Contact>> searchContacts(String query) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    if (query.isEmpty) {
      return MockData.contacts;
    }

    final lowerQuery = query.toLowerCase();
    return MockData.contacts.where((contact) {
      return contact.name.toLowerCase().contains(lowerQuery) ||
          contact.email.toLowerCase().contains(lowerQuery) ||
          contact.department.toLowerCase().contains(lowerQuery) ||
          contact.role.toLowerCase().contains(lowerQuery) ||
          contact.location.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  /// Get contact by ID
  Future<Contact?> getContactById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return MockData.contacts.firstWhere((contact) => contact.id == id);
    } catch (_) {
      return null;
    }
  }
}
