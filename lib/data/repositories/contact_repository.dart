import 'package:ticket_management/data/models/contact.dart';
import 'mock_data.dart';

class ContactRepository {
  Future<List<Contact>> getContacts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return await MockData.loadContacts();
  }

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
