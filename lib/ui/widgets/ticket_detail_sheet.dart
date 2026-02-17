import 'package:flutter/material.dart';
import 'package:ticket_management/core/constants/app_colors.dart';
import 'package:ticket_management/core/constants/app_dimensions.dart';
import 'package:ticket_management/core/constants/app_strings.dart';
import 'package:ticket_management/data/models/ticket.dart';

class TicketDetailSheet extends StatelessWidget {
  final Ticket ticket;

  const TicketDetailSheet({required this.ticket, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXL),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: AppDimensions.paddingM),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF3D3D3D) : AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Content
          SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.paddingXXL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ticket.id,
                      style: TextStyle(
                        fontSize: AppDimensions.fontM,
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingM,
                        vertical: AppDimensions.paddingXS,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusS,
                        ),
                      ),
                      child: Text(
                        ticket.statusDisplayText,
                        style: const TextStyle(
                          fontSize: AppDimensions.fontS,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.spacingL),
                // Title
                Text(
                  ticket.title,
                  style: TextStyle(
                    fontSize: AppDimensions.fontXXL,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingL),
                // Description
                Text(
                  AppStrings.ticketDescription,
                  style: TextStyle(
                    fontSize: AppDimensions.fontM,
                    fontWeight: FontWeight.w600,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingS),
                Text(
                  ticket.description,
                  style: TextStyle(
                    fontSize: AppDimensions.fontM,
                    color: theme.textTheme.bodyLarge?.color,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingXL),
                const Divider(),
                const SizedBox(height: AppDimensions.spacingL),
                // Details grid
                _buildDetailRow(
                  context,
                  AppStrings.ticketPriority,
                  ticket.priorityDisplayText,
                ),
                _buildDetailRow(context, AppStrings.ticketAssignee, ticket.assignee),
                _buildDetailRow(context, 'Category', ticket.category),
                const SizedBox(height: AppDimensions.spacingL),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: AppDimensions.fontM,
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: AppDimensions.fontM,
                fontWeight: FontWeight.w500,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
