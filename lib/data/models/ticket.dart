import 'package:equatable/equatable.dart';

/// Ticket priority levels
enum TicketPriority { low, medium, high, critical }

/// Ticket status states
enum TicketStatus { open, inProgress, resolved, closed, pending }

/// Ticket model representing a support ticket
class Ticket extends Equatable {
  final String id;
  final String title;
  final String description;
  final TicketStatus status;
  final TicketPriority priority;
  final String assignee;
  final String assigneeAvatar;
  final String category;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Ticket({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.assignee,
    required this.assigneeAvatar,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Get display string for status
  String get statusDisplayText {
    switch (status) {
      case TicketStatus.open:
        return 'Open';
      case TicketStatus.inProgress:
        return 'In Progress';
      case TicketStatus.resolved:
        return 'Resolved';
      case TicketStatus.closed:
        return 'Closed';
      case TicketStatus.pending:
        return 'Pending';
    }
  }

  /// Get display string for priority
  String get priorityDisplayText {
    switch (priority) {
      case TicketPriority.low:
        return 'Low';
      case TicketPriority.medium:
        return 'Medium';
      case TicketPriority.high:
        return 'High';
      case TicketPriority.critical:
        return 'Critical';
    }
  }

  /// Create a copy with updated fields
  Ticket copyWith({
    String? id,
    String? title,
    String? description,
    TicketStatus? status,
    TicketPriority? priority,
    String? assignee,
    String? assigneeAvatar,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Ticket(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      assignee: assignee ?? this.assignee,
      assigneeAvatar: assigneeAvatar ?? this.assigneeAvatar,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        priority,
        assignee,
        assigneeAvatar,
        category,
        createdAt,
        updatedAt,
      ];
}
