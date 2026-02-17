import '../models/models.dart';
import 'mock_data.dart';

/// Repository for contact-related operations
/// Simulates API calls using mock data loaded from JSON files
class ContactRepository {
  /// Get all contacts (simulates API call)
  Future<List<Contact>> getContacts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return await MockData.loadContacts();
  }

  /// Search contacts by query
  Future<List<Contact>> searchContacts(String query) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    final contacts = await MockData.loadContacts();
    
    if (query.isEmpty) {
      return contacts;
    }

    final lowerQuery = query.toLowerCase();
    return contacts.where((contact) {
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
      final contacts = await MockData.loadContacts();
      return contacts.firstWhere((contact) => contact.id == id);
    } catch (_) {
      return null;
    }
  }
}
