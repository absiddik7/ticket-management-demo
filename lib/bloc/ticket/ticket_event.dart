import 'package:equatable/equatable.dart';

/// Base class for all ticket events
abstract class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all tickets
class LoadTickets extends TicketEvent {
  const LoadTickets();
}

/// Event to refresh tickets
class RefreshTickets extends TicketEvent {
  const RefreshTickets();
}

/// Event to apply filters to tickets
class ApplyFilters extends TicketEvent {
  final Map<String, List<String>> selectedFilters;

  const ApplyFilters({required this.selectedFilters});

  @override
  List<Object?> get props => [selectedFilters];
}

/// Event to clear all filters
class ClearFilters extends TicketEvent {
  const ClearFilters();
}

/// Event to load filter options
class LoadFilterOptions extends TicketEvent {
  const LoadFilterOptions();
}

/// Event to toggle a filter option
class ToggleFilterOption extends TicketEvent {
  final String groupId;
  final String optionId;

  const ToggleFilterOption({
    required this.groupId,
    required this.optionId,
  });

  @override
  List<Object?> get props => [groupId, optionId];
}

/// Event to reset all filter selections
class ResetFilterSelections extends TicketEvent {
  const ResetFilterSelections();
}
