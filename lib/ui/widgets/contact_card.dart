import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';
import '../../data/models/models.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;
  final VoidCallback? onTap;

  const ContactCard({super.key, required this.contact, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.spacingM,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Avatar
                  _buildAvatar(),
                  const SizedBox(width: AppDimensions.spacingL),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment:  MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize:  MainAxisSize.min,
                            children: [
                              Text(
                                contact.name,
                                style: const TextStyle(
                                  fontSize: AppDimensions.fontL,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_vert,
                            color: AppColors.iconSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Contact info (name + three lines)
              Container(
               // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppDimensions.spacingM),
              
                    Row(
                      children: [
                        const Icon(
                          Icons.email_outlined,
                          size: AppDimensions.iconS,
                          color: AppColors.iconSecondary,
                        ),
                        const SizedBox(width: AppDimensions.spacingS),
                        Expanded(
                          child: Text(
                            contact.email,
                            style: const TextStyle(
                              fontSize: AppDimensions.fontM,
                              color: AppColors.textHint,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.spacingXS),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone_outlined,
                          size: AppDimensions.iconS,
                          color: AppColors.iconSecondary,
                        ),
                        const SizedBox(width: AppDimensions.spacingS),
                        Expanded(
                          child: Text(
                            contact.phone,
                            style: const TextStyle(
                              fontSize: AppDimensions.fontM,
                              color: AppColors.textHint,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.spacingXS),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: AppDimensions.iconS,
                          color: AppColors.iconSecondary,
                        ),
                        const SizedBox(width: AppDimensions.spacingS),
                        Expanded(
                          child: Text(
                            contact.department,
                            style: const TextStyle(
                              fontSize: AppDimensions.fontM,
                              color: AppColors.textHint,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
          radius: AppDimensions.avatarM / 2,
          backgroundColor: AppColors.primary.withValues(alpha: 0.2),
          backgroundImage: NetworkImage(contact.avatarUrl),
          onBackgroundImageError: (_, __) {},
          child: Text(
            contact.initials,
            style: const TextStyle(
              fontSize: AppDimensions.fontL,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
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
                border: Border.all(color: AppColors.surface, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
