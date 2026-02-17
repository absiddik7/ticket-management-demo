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
  final String brand;
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
    required this.brand,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create a Ticket from JSON map
  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: _parseStatus(json['status'] as String),
      priority: _parsePriority(json['priority'] as String),
      assignee: json['assignee'] as String,
      assigneeAvatar: json['assignee_avatar'] as String,
      category: json['category'] as String,
      brand: json['brand'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Convert Ticket to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status.name,
      'priority': priority.name,
      'assignee': assignee,
      'assignee_avatar': assigneeAvatar,
      'category': category,
      'brand': brand,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  static TicketStatus _parseStatus(String status) {
    switch (status) {
      case 'open':
        return TicketStatus.open;
      case 'inProgress':
      case 'in_progress':
        return TicketStatus.inProgress;
      case 'resolved':
        return TicketStatus.resolved;
      case 'closed':
        return TicketStatus.closed;
      case 'pending':
        return TicketStatus.pending;
      default:
        return TicketStatus.open;
    }
  }

  static TicketPriority _parsePriority(String priority) {
    switch (priority) {
      case 'low':
        return TicketPriority.low;
      case 'medium':
        return TicketPriority.medium;
      case 'high':
        return TicketPriority.high;
      case 'critical':
        return TicketPriority.critical;
      default:
        return TicketPriority.medium;
    }
  }

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
    String? brand,
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
      brand: brand ?? this.brand,
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
        brand,
        createdAt,
        updatedAt,
      ];
}
