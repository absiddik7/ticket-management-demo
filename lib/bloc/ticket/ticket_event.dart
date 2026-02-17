import 'package:equatable/equatable.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object?> get props => [];
}

class LoadTickets extends TicketEvent {
  const LoadTickets();
}

class RefreshTickets extends TicketEvent {
  const RefreshTickets();
}

class ApplyFilters extends TicketEvent {
  final Map<String, List<String>> selectedFilters;

  const ApplyFilters({required this.selectedFilters});

  @override
  List<Object?> get props => [selectedFilters];
}

class ClearFilters extends TicketEvent {
  const ClearFilters();
}

class LoadFilterOptions extends TicketEvent {
  const LoadFilterOptions();
}

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

class ResetFilterSelections extends TicketEvent {
  const ResetFilterSelections();
}
