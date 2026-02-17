import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';
import '../../data/models/models.dart';

/// Widget displaying a single ticket item in a list
class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final VoidCallback? onTap;

  const TicketCard({super.key, required this.ticket, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.spacingS,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2C2C2C) : AppColors.background,
            borderRadius: BorderRadius.circular(16),
            
          ),
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top tag (e.g., "New" for recent tickets or the ticket category)
              _buildTopPill(context),
              const SizedBox(height: AppDimensions.spacingS),

              // Ticket ID
              Text(
                '#${ticket.id}',
                style: TextStyle(
                  fontSize: AppDimensions.fontS,
                  color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppDimensions.spacingS),

              // Title
              Text(
                ticket.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: theme.textTheme.bodyLarge?.color,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppDimensions.spacingS),

              // Author and date
              Row(
                children: [
                  Text(
                    ticket.assignee,
                    style: TextStyle(
                      fontSize: AppDimensions.fontS,
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingS),
                  Text('•', style: TextStyle(color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6))),
                  const SizedBox(width: AppDimensions.spacingS),
                  Text(
                    _formatDate(ticket.createdAt),
                    style: TextStyle(
                      fontSize: AppDimensions.fontS,
                      color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppDimensions.spacingM),
              Divider(color: isDark ? const Color(0xFF3D3D3D) : AppColors.divider, thickness: 1),
              const SizedBox(height: AppDimensions.spacingM),

              // Chips
              Wrap(
                spacing: AppDimensions.spacingS,
                runSpacing: AppDimensions.spacingS,
                children: [
                  _buildSmallChip(
                    context,
                    ticket.priorityDisplayText,
                    _getPriorityColor(),
                  ),
                  _buildSmallChip(context, ticket.statusDisplayText, _getStatusColor()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopPill(BuildContext context) {
    final isNew = DateTime.now().difference(ticket.createdAt).inHours < 48;
    String label;
    Color color;

    if (isNew) {
      label = 'New';
      color = AppColors.info;
    } else {
      final cat = ticket.category.toLowerCase();
      switch (cat) {
        case 'bug':
          label = 'Bug';
          color = AppColors.error;
          break;
        case 'feature request':
          label = 'Feature';
          color = AppColors.primary;
          break;
        case 'documentation':
          label = 'Docs';
          color = AppColors.info;
          break;
        case 'support':
          label = 'Support';
          color = AppColors.warning;
          break;
        default:
          label = ticket.category;
          color = AppColors.primary;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingXS,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: AppDimensions.fontS,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  Widget _buildSmallChip(BuildContext context, String label, Color color) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingXS,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? const Color(0xFF3D3D3D) : AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(right: AppDimensions.spacingS),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: AppDimensions.fontS,
              color: theme.textTheme.bodyLarge?.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor() {
    switch (ticket.priority) {
      case TicketPriority.low:
        return AppColors.priorityLow;
      case TicketPriority.medium:
        return AppColors.priorityMedium;
      case TicketPriority.high:
        return AppColors.priorityHigh;
      case TicketPriority.critical:
        return AppColors.priorityCritical;
    }
  }

  Color _getStatusColor() {
    switch (ticket.status) {
      case TicketStatus.open:
        return AppColors.ticketOpen;
      case TicketStatus.inProgress:
        return AppColors.ticketInProgress;
      case TicketStatus.resolved:
        return AppColors.ticketResolved;
      case TicketStatus.closed:
        return AppColors.ticketClosed;
      case TicketStatus.pending:
        return AppColors.ticketPending;
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year} ${_formatTime(date)}';
  }

  String _formatTime(DateTime d) {
    final hour = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final minute = d.minute.toString().padLeft(2, '0');
    final period = d.hour >= 12 ? 'pm' : 'am';
    return '$hour:$minute $period';
  }
}
