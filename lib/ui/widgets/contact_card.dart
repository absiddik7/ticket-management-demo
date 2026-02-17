import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';
import '../../data/models/models.dart';

/// Widget displaying a single contact item in a list
class ContactCard extends StatelessWidget {
  final Contact contact;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onViewTickets;
  final VoidCallback? onDelete;

  const ContactCard({
    super.key,
    required this.contact,
    this.onTap,
    this.onEdit,
    this.onViewTickets,
    this.onDelete,
  });

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
              // Header with avatar and info
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar
                  _buildAvatar(),
                  const SizedBox(width: AppDimensions.spacingL),
                  // Name and role
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  contact.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: theme.textTheme.bodyLarge?.color,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  contact.department,
                                  style: TextStyle(
                                    fontSize: AppDimensions.fontS,
                                    color: theme.textTheme.bodySmall?.color,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            const Spacer(),
                            PopupMenuButton<String>(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              onSelected: (value) {
                                if (value == 'edit') {
                                  onEdit?.call();
                                } else if (value == 'view_tickets') {
                                  onViewTickets?.call();
                                } else if (value == 'delete') {
                                  onDelete?.call();
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                    const PopupMenuItem<String>(
                                      value: 'edit',
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: AppDimensions.spacingM,
                                        ),
                                        child: Text('Edit'),
                                      ),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'view_tickets',
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: AppDimensions.spacingM,
                                        ),
                                        child: Text('View tickets'),
                                      ),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'delete',
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: AppDimensions.spacingM,
                                        ),
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  ],
                              icon: const Icon(
                                Icons.more_vert,
                                size: AppDimensions.iconM,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.spacingM),
              Divider(color: isDark ? const Color(0xFF3D3D3D) : AppColors.divider, thickness: 1),
              const SizedBox(height: AppDimensions.spacingM),
              // Contact info
              _buildInfoRow(context, icon: Icons.email_outlined, value: contact.email),
              const SizedBox(height: AppDimensions.spacingS),
              _buildInfoRow(context, icon: Icons.phone_outlined, value: contact.phone),
              const SizedBox(height: AppDimensions.spacingS),
              // location
              _buildInfoRow(
                context,
                icon: Icons.location_on_outlined,
                value: contact.location,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.background,
          backgroundImage: NetworkImage(contact.avatarUrl),
          onBackgroundImageError: (_, __) {},
        ),
        if (contact.isOnline)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.background, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, {required IconData icon, required String value}) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        Icon(icon, size: AppDimensions.iconS, color: theme.textTheme.bodySmall?.color),
        const SizedBox(width: AppDimensions.spacingS),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: AppDimensions.fontS,
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
