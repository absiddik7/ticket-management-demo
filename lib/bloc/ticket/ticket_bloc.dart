import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/repositories.dart';
import 'ticket_event.dart';
import 'ticket_state.dart';

/// BLoC for managing ticket state
class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final TicketRepository _ticketRepository;

  TicketBloc({TicketRepository? ticketRepository})
      : _ticketRepository = ticketRepository ?? TicketRepository(),
        super(const TicketState()) {
    on<LoadTickets>(_onLoadTickets);
    on<RefreshTickets>(_onRefreshTickets);
    on<LoadFilterOptions>(_onLoadFilterOptions);
    on<ToggleFilterOption>(_onToggleFilterOption);
    on<ApplyFilters>(_onApplyFilters);
    on<ClearFilters>(_onClearFilters);
    on<ResetFilterSelections>(_onResetFilterSelections);
  }

  /// Handle load tickets event
  Future<void> _onLoadTickets(
    LoadTickets event,
    Emitter<TicketState> emit,
  ) async {
    emit(state.copyWith(status: TicketStateStatus.loading));

    try {
      final tickets = await _ticketRepository.getTickets();
      emit(state.copyWith(
        status: TicketStateStatus.loaded,
        tickets: tickets,
        filteredTickets: tickets,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TicketStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Handle refresh tickets event
  Future<void> _onRefreshTickets(
    RefreshTickets event,
    Emitter<TicketState> emit,
  ) async {
    try {
      final tickets = await _ticketRepository.getTickets();

      // Re-apply existing filters if any
      if (state.hasActiveFilters) {
        final filteredTickets = await _ticketRepository.getFilteredTickets(
          statuses: state.selectedFilters['status'],
          priorities: state.selectedFilters['priority'],
          categories: state.selectedFilters['category'],
        );
        emit(state.copyWith(
          status: TicketStateStatus.loaded,
          tickets: tickets,
          filteredTickets: filteredTickets,
        ));
      } else {
        emit(state.copyWith(
          status: TicketStateStatus.loaded,
          tickets: tickets,
          filteredTickets: tickets,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: TicketStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Handle load filter options event
  Future<void> _onLoadFilterOptions(
    LoadFilterOptions event,
    Emitter<TicketState> emit,
  ) async {
    try {
      final filterGroups = await _ticketRepository.getFilterOptions();
      emit(state.copyWith(filterGroups: filterGroups));
    } catch (e) {
      // Silently fail for filter options
    }
  }

  /// Handle toggle filter option event
  void _onToggleFilterOption(
    ToggleFilterOption event,
    Emitter<TicketState> emit,
  ) {
    // Create a mutable copy of selected filters
    final updatedFilters = Map<String, List<String>>.from(state.selectedFilters);

    // Get or create the list for this group
    final groupFilters = List<String>.from(updatedFilters[event.groupId] ?? []);

    // Toggle the option
    if (groupFilters.contains(event.optionId)) {
      groupFilters.remove(event.optionId);
    } else {
      groupFilters.add(event.optionId);
    }

    // Update or remove the group
    if (groupFilters.isEmpty) {
      updatedFilters.remove(event.groupId);
    } else {
      updatedFilters[event.groupId] = groupFilters;
    }

    // Update filter groups with selection state
    final updatedGroups = state.filterGroups.map((group) {
      if (group.id == event.groupId) {
        return group.copyWith(
          options: group.options.map((option) {
            if (option.id == event.optionId) {
              return option.copyWith(isSelected: !option.isSelected);
            }
            return option;
          }).toList(),
        );
      }
      return group;
    }).toList();

    emit(state.copyWith(
      selectedFilters: updatedFilters,
      filterGroups: updatedGroups,
    ));
  }

  /// Handle apply filters event
  Future<void> _onApplyFilters(
    ApplyFilters event,
    Emitter<TicketState> emit,
  ) async {
    emit(state.copyWith(status: TicketStateStatus.loading));

    try {
      final filteredTickets = await _ticketRepository.getFilteredTickets(
        statuses: event.selectedFilters['status'],
        priorities: event.selectedFilters['priority'],
        categories: event.selectedFilters['category'],
      );

      emit(state.copyWith(
        status: TicketStateStatus.loaded,
        filteredTickets: filteredTickets,
        selectedFilters: event.selectedFilters,
        isFiltered: event.selectedFilters.isNotEmpty,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TicketStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Handle clear filters event
  Future<void> _onClearFilters(
    ClearFilters event,
    Emitter<TicketState> emit,
  ) async {
    // Reset filter groups selection state
    final resetGroups = state.filterGroups.map((group) {
      return group.copyWith(
        options: group.options.map((option) {
          return option.copyWith(isSelected: false);
        }).toList(),
      );
    }).toList();

    emit(state.copyWith(
      filteredTickets: state.tickets,
      selectedFilters: const {},
      filterGroups: resetGroups,
      isFiltered: false,
    ));
  }

  /// Handle reset filter selections event
  void _onResetFilterSelections(
    ResetFilterSelections event,
    Emitter<TicketState> emit,
  ) {
    // Reset filter groups selection state
    final resetGroups = state.filterGroups.map((group) {
      return group.copyWith(
        options: group.options.map((option) {
          return option.copyWith(isSelected: false);
        }).toList(),
      );
    }).toList();

    emit(state.copyWith(
      filterGroups: resetGroups,
      selectedFilters: const {},
    ));
  }
}
