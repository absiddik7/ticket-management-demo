import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ticket_management/data/models/contact.dart';
import 'package:ticket_management/data/models/filter.dart';
import 'package:ticket_management/data/models/ticket.dart';
import 'package:ticket_management/data/models/user_profile.dart';

class MockData {
  MockData._();

  // Cached data to avoid reading files multiple times
  static List<Ticket>? _cachedTickets;
  static List<Contact>? _cachedContacts;
  static UserProfile? _cachedUserProfile;
  static List<Map<String, String>>? _cachedAssignedRoles;
  static List<FilterGroup>? _cachedFilterGroups;

  static Future<List<Ticket>> loadTickets() async {
    if (_cachedTickets != null) return _cachedTickets!;
    
    final String jsonString = await rootBundle.loadString('assets/json/tickets.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    _cachedTickets = jsonList
        .map((item) => Ticket.fromJson(item as Map<String, dynamic>))
        .toList();
    return _cachedTickets!;
  }

  static Future<List<Contact>> loadContacts() async {
    if (_cachedContacts != null) return _cachedContacts!;
    
    final String jsonString = await rootBundle.loadString('assets/json/contacts.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    _cachedContacts = jsonList
        .map((item) => Contact.fromJson(item as Map<String, dynamic>))
        .toList();
    return _cachedContacts!;
  }

  static Future<UserProfile> loadUserProfile() async {
    if (_cachedUserProfile != null) return _cachedUserProfile!;
    
    final String jsonString = await rootBundle.loadString('assets/json/user_profile.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _cachedUserProfile = UserProfile.fromJson(jsonMap);
    return _cachedUserProfile!;
  }

  static Future<List<Map<String, String>>> loadAssignedRoles() async {
    if (_cachedAssignedRoles != null) return _cachedAssignedRoles!;
    
    final String jsonString = await rootBundle.loadString('assets/json/assigned_roles.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    _cachedAssignedRoles = jsonList
        .map((item) => Map<String, String>.from(item as Map<String, dynamic>))
        .toList();
    return _cachedAssignedRoles!;
  }

  static Future<List<FilterGroup>> loadFilterGroups() async {
    if (_cachedFilterGroups != null) return _cachedFilterGroups!;
    
    final String jsonString = await rootBundle.loadString('assets/json/filter_groups.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    _cachedFilterGroups = jsonList
        .map((item) => FilterGroup.fromJson(item as Map<String, dynamic>))
        .toList();
    return _cachedFilterGroups!;
  }

  static void clearCache() {
    _cachedTickets = null;
    _cachedContacts = null;
    _cachedUserProfile = null;
    _cachedAssignedRoles = null;
    _cachedFilterGroups = null;
  }
}
