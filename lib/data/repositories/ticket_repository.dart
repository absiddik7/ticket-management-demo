import '../models/models.dart';
import 'mock_data.dart';

/// Repository for ticket-related operations
/// Simulates API calls using mock data loaded from JSON files
class TicketRepository {
  /// Get all tickets (simulates API call)
  Future<List<Ticket>> getTickets() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return await MockData.loadTickets();
  }

  /// Get filtered tickets based on selected filters
  /// Supports dynamic filter groups by ID
  Future<List<Ticket>> getFilteredTickets({
    List<String>? priorities,
    List<String>? brands,
    List<String>? tags,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    List<Ticket> filteredTickets = await MockData.loadTickets();

    // Apply priority filter
    if (priorities != null && priorities.isNotEmpty) {
      filteredTickets = filteredTickets.where((ticket) {
        final priorityValue = _getPriorityValue(ticket.priority);
        return priorities.contains(priorityValue);
      }).toList();
    }

    // Apply brand filter
    if (brands != null && brands.isNotEmpty) {
      filteredTickets = filteredTickets.where((ticket) {
        return brands.contains(ticket.brand);
      }).toList();
    }
    
    // Tags filter - includes status, category, and other tags
    if (tags != null && tags.isNotEmpty) {
      filteredTickets = filteredTickets.where((ticket) {
        // Check status tags
        for (final tag in tags) {
          final statusValue = _getStatusValue(ticket.status);
          if (tag == statusValue) return true;
        }
        
        // Check category tags
        for (final tag in tags) {
          final categoryValue = _getCategoryValue(ticket.category);
          if (tag == categoryValue) return true;
        }
        
        // Check other tags
        for (final tag in tags) {
          if (tag == 'urgent' && ticket.priority == TicketPriority.critical) return true;
          if (tag == 'backend' || tag == 'frontend' || tag == 'mobile' || tag == 'api') {
            // For demo, randomly match some tickets
            return ticket.id.hashCode % 3 == 0;
          }
        }
        return false;
      }).toList();
    }

    return filteredTickets;
  }

  /// Get ticket by ID
  Future<Ticket?> getTicketById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      final tickets = await MockData.loadTickets();
      return tickets.firstWhere((ticket) => ticket.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Get filter options (simulates dynamic filters from API)
  Future<List<FilterGroup>> getFilterOptions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return await MockData.loadFilterGroups();
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
