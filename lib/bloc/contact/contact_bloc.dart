import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_management/data/repositories/contact_repository.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository _contactRepository;

  ContactBloc({ContactRepository? contactRepository})
    : _contactRepository = contactRepository ?? ContactRepository(),
      super(const ContactState()) {
    on<LoadContacts>(_onLoadContacts);
    on<SearchContacts>(_onSearchContacts);
    on<ClearSearch>(_onClearSearch);
  }

  Future<void> _onLoadContacts(
    LoadContacts event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(status: ContactStateStatus.loading));

    try {
      final contacts = await _contactRepository.getContacts();
      emit(
        state.copyWith(
          status: ContactStateStatus.loaded,
          contacts: contacts,
          searchResults: contacts,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ContactStateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSearchContacts(
    SearchContacts event,
    Emitter<ContactState> emit,
  ) async {
    emit(
      state.copyWith(
        searchQuery: event.query,
        status: ContactStateStatus.loading,
      ),
    );

    try {
      final results = await _contactRepository.searchContacts(event.query);
      emit(
        state.copyWith(
          status: ContactStateStatus.loaded,
          searchResults: results,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ContactStateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onClearSearch(ClearSearch event, Emitter<ContactState> emit) {
    emit(state.copyWith(searchQuery: '', searchResults: state.contacts));
  }
}
