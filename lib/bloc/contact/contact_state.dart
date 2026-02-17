import 'package:equatable/equatable.dart';
import 'package:ticket_management/data/models/contact.dart';

enum ContactStateStatus { initial, loading, loaded, error }

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

  List<Contact> get displayContacts =>
      searchQuery.isNotEmpty ? searchResults : contacts;

  bool get isSearching => searchQuery.isNotEmpty;

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
