import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_management/data/models/filter.dart';
import 'package:ticket_management/data/repositories/ticket_repository.dart';
import 'ticket_event.dart';
import 'ticket_state.dart';

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

  Future<void> _onRefreshTickets(
    RefreshTickets event,
    Emitter<TicketState> emit,
  ) async {
    try {
      final tickets = await _ticketRepository.getTickets();

      // Re-apply existing filters if any
      if (state.hasActiveFilters) {
        final filteredTickets = await _ticketRepository.getFilteredTickets(
          priorities: state.selectedFilters['priority'],
          brands: state.selectedFilters['brand'],
          tags: state.selectedFilters['tags'],
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

  Future<void> _onLoadFilterOptions(
    LoadFilterOptions event,
    Emitter<TicketState> emit,
  ) async {
    try {
      final filterGroups = await _ticketRepository.getFilterOptions();
      
      // Preserve existing selections from selectedFilters
      final updatedGroups = filterGroups.map((group) {
        final selectedIds = state.selectedFilters[group.id] ?? [];
        if (selectedIds.isEmpty) return group;
        
        return group.copyWith(
          options: group.options.map((option) {
            // Check if this option's value is in the selected filters
            final isSelected = selectedIds.contains(option.value);
            return option.copyWith(isSelected: isSelected);
          }).toList(),
        );
      }).toList();
      
      emit(state.copyWith(filterGroups: updatedGroups));
    } catch (e) {
      // Silently fail for filter options
    }
  }

  void _onToggleFilterOption(
    ToggleFilterOption event,
    Emitter<TicketState> emit,
  ) {
    // Find the target group and option
    final targetGroup = state.filterGroups.firstWhere(
      (g) => g.id == event.groupId,
      orElse: () => const FilterGroup(id: '', title: '', options: []),
    );
    final targetOption = targetGroup.options.firstWhere(
      (o) => o.id == event.optionId,
      orElse: () => const FilterOption(id: '', label: '', value: ''),
    );
    
    if (targetOption.id.isEmpty) return;
    
    // Create a mutable copy of selected filters
    final updatedFilters = Map<String, List<String>>.from(state.selectedFilters);

    // Get or create the list for this group (store VALUES, not IDs)
    final groupFilters = List<String>.from(updatedFilters[event.groupId] ?? []);

    // Toggle the option using its value
    final optionValue = targetOption.value;
    if (groupFilters.contains(optionValue)) {
      groupFilters.remove(optionValue);
    } else {
      groupFilters.add(optionValue);
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

  Future<void> _onApplyFilters(
    ApplyFilters event,
    Emitter<TicketState> emit,
  ) async {
    emit(state.copyWith(status: TicketStateStatus.loading));

    try {
      final filteredTickets = await _ticketRepository.getFilteredTickets(
        priorities: event.selectedFilters['priority'],
        brands: event.selectedFilters['brand'],
        tags: event.selectedFilters['tags'],
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
