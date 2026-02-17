import 'package:flutter/material.dart';
import 'package:ticket_management/core/constants/app_colors.dart';
import 'package:ticket_management/core/constants/app_dimensions.dart';
import 'package:ticket_management/core/constants/app_strings.dart';

class ContactDetailSheet extends StatelessWidget {
  final dynamic contact;

  const ContactDetailSheet({required this.contact, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXL),
        ),
      ),
      child: Column(
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.paddingXXL),
              child: Column(
                children: [
                  // Avatar
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: AppDimensions.avatarXL / 2,
                        backgroundColor: isDark ? const Color(0xFF3D3D3D) : AppColors.slideGrey,
                        backgroundImage: NetworkImage(contact.avatarUrl),
                        onBackgroundImageError: (_, __) {},
                      ),
                      if (contact.isOnline)
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: theme.colorScheme.surface,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spacingL),
                  // Name
                  Text(
                    contact.name,
                    style: TextStyle(
                      fontSize: AppDimensions.fontXXL,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingXS),
                  // Role
                  Text(
                    contact.role,
                    style: TextStyle(
                      fontSize: AppDimensions.fontM,
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingXL),
                  // Contact info
                  _buildInfoTile(
                    context,
                    icon: Icons.email_outlined,
                    label: AppStrings.contactEmail,
                    value: contact.email,
                  ),
                  _buildInfoTile(
                    context,
                    icon: Icons.phone_outlined,
                    label: AppStrings.contactPhone,
                    value: contact.phone,
                  ),
                  _buildInfoTile(
                    context,
                    icon: Icons.business_outlined,
                    label: AppStrings.contactDepartment,
                    value: contact.department,
                  ),
                  _buildInfoTile(
                    context,
                    icon: Icons.location_on_outlined,
                    label: 'Location',
                    value: contact.location,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Icon(
              icon,
              size: AppDimensions.iconM,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppDimensions.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: AppDimensions.fontS,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: AppDimensions.fontM,
                    fontWeight: FontWeight.w500,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
