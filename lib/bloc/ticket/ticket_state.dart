import 'package:equatable/equatable.dart';
import 'package:ticket_management/data/models/filter.dart';
import 'package:ticket_management/data/models/ticket.dart';

enum TicketStateStatus { initial, loading, loaded, error }

class TicketState extends Equatable {
  final TicketStateStatus status;
  final List<Ticket> tickets;
  final List<Ticket> filteredTickets;
  final List<FilterGroup> filterGroups;
  final Map<String, List<String>> selectedFilters;
  final String? errorMessage;
  final bool isFiltered;

  const TicketState({
    this.status = TicketStateStatus.initial,
    this.tickets = const [],
    this.filteredTickets = const [],
    this.filterGroups = const [],
    this.selectedFilters = const {},
    this.errorMessage,
    this.isFiltered = false,
  });

  List<Ticket> get displayTickets => isFiltered ? filteredTickets : tickets;

  int get activeFilterCount {
    int count = 0;
    for (var filters in selectedFilters.values) {
      count += filters.length;
    }
    return count;
  }

  bool get hasActiveFilters => activeFilterCount > 0;

  TicketState copyWith({
    TicketStateStatus? status,
    List<Ticket>? tickets,
    List<Ticket>? filteredTickets,
    List<FilterGroup>? filterGroups,
    Map<String, List<String>>? selectedFilters,
    String? errorMessage,
    bool? isFiltered,
  }) {
    return TicketState(
      status: status ?? this.status,
      tickets: tickets ?? this.tickets,
      filteredTickets: filteredTickets ?? this.filteredTickets,
      filterGroups: filterGroups ?? this.filterGroups,
      selectedFilters: selectedFilters ?? this.selectedFilters,
      errorMessage: errorMessage ?? this.errorMessage,
      isFiltered: isFiltered ?? this.isFiltered,
    );
  }

  @override
  List<Object?> get props => [
        status,
        tickets,
        filteredTickets,
        filterGroups,
        selectedFilters,
        errorMessage,
        isFiltered,
      ];
}
