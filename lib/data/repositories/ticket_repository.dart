import '../models/models.dart';
import 'mock_data.dart';

/// Repository for ticket-related operations
/// Simulates API calls using mock data
class TicketRepository {
  /// Get all tickets (simulates API call)
  Future<List<Ticket>> getTickets() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return MockData.tickets;
  }

  /// Get filtered tickets based on selected filters
  Future<List<Ticket>> getFilteredTickets({
    List<String>? statuses,
    List<String>? priorities,
    List<String>? categories,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    List<Ticket> filteredTickets = MockData.tickets;

    // Apply status filter
    if (statuses != null && statuses.isNotEmpty) {
      filteredTickets = filteredTickets.where((ticket) {
        final statusValue = _getStatusValue(ticket.status);
        return statuses.contains(statusValue);
      }).toList();
    }

    // Apply priority filter
    if (priorities != null && priorities.isNotEmpty) {
      filteredTickets = filteredTickets.where((ticket) {
        final priorityValue = _getPriorityValue(ticket.priority);
        return priorities.contains(priorityValue);
      }).toList();
    }

    // Apply category filter
    if (categories != null && categories.isNotEmpty) {
      filteredTickets = filteredTickets.where((ticket) {
        final categoryValue = _getCategoryValue(ticket.category);
        return categories.contains(categoryValue);
      }).toList();
    }

    return filteredTickets;
  }

  /// Get ticket by ID
  Future<Ticket?> getTicketById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return MockData.tickets.firstWhere((ticket) => ticket.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Get filter options (simulates dynamic filters from API)
  Future<List<FilterGroup>> getFilterOptions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.filterGroups;
  }

  String _getStatusValue(TicketStatus status) {
    switch (status) {
      case TicketStatus.open:
        return 'open';
      case TicketStatus.inProgress:
        return 'in_progress';
      case TicketStatus.pending:
        return 'pending';
      case TicketStatus.resolved:
        return 'resolved';
      case TicketStatus.closed:
        return 'closed';
    }
  }

  String _getPriorityValue(TicketPriority priority) {
    switch (priority) {
      case TicketPriority.low:
        return 'low';
      case TicketPriority.medium:
        return 'medium';
      case TicketPriority.high:
        return 'high';
      case TicketPriority.critical:
        return 'critical';
    }
  }

  String _getCategoryValue(String category) {
    switch (category.toLowerCase()) {
      case 'bug':
        return 'bug';
      case 'feature request':
        return 'feature';
      case 'documentation':
        return 'docs';
      case 'support':
        return 'support';
      default:
        return category.toLowerCase();
    }
  }
}
