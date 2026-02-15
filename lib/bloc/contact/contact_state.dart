import 'package:equatable/equatable.dart';
import '../../data/models/models.dart';

/// Contact state status
enum ContactStateStatus { initial, loading, loaded, error }

/// State class for contact BLoC
class ContactState extends Equatable {
  final ContactStateStatus status;
  final List<Contact> contacts;
  final List<Contact> searchResults;
  final String searchQuery;
  final String? errorMessage;

  const ContactState({
    this.status = ContactStateStatus.initial,
    this.contacts = const [],
    this.searchResults = const [],
    this.searchQuery = '',
    this.errorMessage,
  });

  /// Get contacts to display (search results or all)
  List<Contact> get displayContacts =>
      searchQuery.isNotEmpty ? searchResults : contacts;

  /// Check if search is active
  bool get isSearching => searchQuery.isNotEmpty;

  /// Create a copy with updated fields
  ContactState copyWith({
    ContactStateStatus? status,
    List<Contact>? contacts,
    List<Contact>? searchResults,
    String? searchQuery,
    String? errorMessage,
  }) {
    return ContactState(
      status: status ?? this.status,
      contacts: contacts ?? this.contacts,
      searchResults: searchResults ?? this.searchResults,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        contacts,
        searchResults,
        searchQuery,
        errorMessage,
      ];
}
