import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/repositories.dart';
import 'contact_event.dart';
import 'contact_state.dart';

/// BLoC for managing contact state
class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository _contactRepository;

  ContactBloc({ContactRepository? contactRepository})
      : _contactRepository = contactRepository ?? ContactRepository(),
        super(const ContactState()) {
    on<LoadContacts>(_onLoadContacts);
    on<SearchContacts>(_onSearchContacts);
    on<ClearSearch>(_onClearSearch);
  }

  /// Handle load contacts event
  Future<void> _onLoadContacts(
    LoadContacts event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(status: ContactStateStatus.loading));

    try {
      final contacts = await _contactRepository.getContacts();
      emit(state.copyWith(
        status: ContactStateStatus.loaded,
        contacts: contacts,
        searchResults: contacts,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ContactStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Handle search contacts event
  Future<void> _onSearchContacts(
    SearchContacts event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(
      searchQuery: event.query,
      status: ContactStateStatus.loading,
    ));

    try {
      final results = await _contactRepository.searchContacts(event.query);
      emit(state.copyWith(
        status: ContactStateStatus.loaded,
        searchResults: results,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ContactStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Handle clear search event
  void _onClearSearch(
    ClearSearch event,
    Emitter<ContactState> emit,
  ) {
    emit(state.copyWith(
      searchQuery: '',
      searchResults: state.contacts,
    ));
  }
}
