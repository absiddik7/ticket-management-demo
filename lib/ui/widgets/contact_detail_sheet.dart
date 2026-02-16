import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';

/// Bottom sheet showing contact details
class ContactDetailSheet extends StatelessWidget {
  final dynamic contact;

  const ContactDetailSheet({required this.contact, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
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
                color: AppColors.border,
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
                        backgroundColor: AppColors.slideGrey,
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
                                color: AppColors.surface,
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
                    style: const TextStyle(
                      fontSize: AppDimensions.fontXXL,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingXS),
                  // Role
                  Text(
                    contact.role,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontM,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingXL),
                  // Contact info
                  _buildInfoTile(
                    icon: Icons.email_outlined,
                    label: AppStrings.contactEmail,
                    value: contact.email,
                  ),
                  _buildInfoTile(
                    icon: Icons.phone_outlined,
                    label: AppStrings.contactPhone,
                    value: contact.phone,
                  ),
                  _buildInfoTile(
                    icon: Icons.business_outlined,
                    label: AppStrings.contactDepartment,
                    value: contact.department,
                  ),
                  _buildInfoTile(
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

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
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
                  style: const TextStyle(
                    fontSize: AppDimensions.fontS,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontM,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
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
