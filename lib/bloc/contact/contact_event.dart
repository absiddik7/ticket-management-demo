import 'package:equatable/equatable.dart';

/// Base class for all contact events
abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all contacts
class LoadContacts extends ContactEvent {
  const LoadContacts();
}

/// Event to search contacts
class SearchContacts extends ContactEvent {
  final String query;

  const SearchContacts({required this.query});

  @override
  List<Object?> get props => [query];
}

/// Event to clear search
class ClearSearch extends ContactEvent {
  const ClearSearch();
}
