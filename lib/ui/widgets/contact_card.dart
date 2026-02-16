import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';
import '../../data/models/models.dart';

/// Widget displaying a single contact item in a list
class ContactCard extends StatelessWidget {
  final Contact contact;
  final VoidCallback? onTap;

  const ContactCard({super.key, required this.contact, this.onTap});

  @override
  Widget build(BuildContext context) {
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
            color: AppColors.background,
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
                            Text(
                              contact.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.more_vert,
                              size: AppDimensions.iconM,
                              color: AppColors.textSecondary,
                            ),

                          ],
                        ),
                        Text(
                          contact.department,
                          style: const TextStyle(
                            fontSize: AppDimensions.fontS,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.spacingM),
              const Divider(color: AppColors.divider, thickness: 1),
              const SizedBox(height: AppDimensions.spacingM),
              // Contact info
              _buildInfoRow(icon: Icons.email_outlined, value: contact.email),
              const SizedBox(height: AppDimensions.spacingS),
              _buildInfoRow(icon: Icons.phone_outlined, value: contact.phone),
              const SizedBox(height: AppDimensions.spacingS),
              // location
              _buildInfoRow(icon: Icons.location_on_outlined, value: contact.location),
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

  Widget _buildInfoRow({required IconData icon, required String value}) {
    return Row(
      children: [
        Icon(icon, size: AppDimensions.iconS, color: AppColors.textSecondary),
        const SizedBox(width: AppDimensions.spacingS),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: AppDimensions.fontS,
              color: AppColors.textHint,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
