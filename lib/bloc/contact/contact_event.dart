import 'package:equatable/equatable.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object?> get props => [];
}

class LoadContacts extends ContactEvent {
  const LoadContacts();
}

class SearchContacts extends ContactEvent {
  final String query;

  const SearchContacts({required this.query});

  @override
  List<Object?> get props => [query];
}

class ClearSearch extends ContactEvent {
  const ClearSearch();
}
