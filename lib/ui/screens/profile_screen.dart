import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bloc.dart';
import '../../core/constants/constants.dart';
import '../../data/repositories/mock_data.dart';
import '../widgets/widgets.dart';

/// Screen displaying user profile information
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      title: const Text(
        AppStrings.profileTitle,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      centerTitle: false,
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        switch (state.status) {
          case ProfileStateStatus.initial:
          case ProfileStateStatus.loading:
            return const LoadingIndicator(message: AppStrings.loading);

          case ProfileStateStatus.error:
            return ErrorState(
              message: state.errorMessage ?? AppStrings.errorGeneric,
              onRetry: () => context.read<ProfileBloc>().add(const LoadProfile()),
            );

          case ProfileStateStatus.loaded:
            if (state.profile == null) {
              return const ErrorState(message: 'Profile not found');
            }
            return _buildProfileContent(state.profile!);
        }
      },
    );
  }

  Widget _buildProfileContent(profile) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ProfileBloc>().add(const RefreshProfile());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: AppDimensions.paddingL),

            // Profile summary card (light blue)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
              child: _buildProfileCard(profile),
            ),
            const SizedBox(height: AppDimensions.spacingL),

            // Basic info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
              child: _buildBasicInfo(profile),
            ),
            const SizedBox(height: AppDimensions.spacingL),

            // Assigned roles (horizontal)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
              child: _buildRolesSection(),
            ),
            const SizedBox(height: AppDimensions.spacingL),

            // Logout button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout, color: AppColors.error),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
                  child: Text(
                    'Log out',
                    style: TextStyle(fontSize: AppDimensions.fontL, color: AppColors.error),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.errorLight,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingXXL),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(profile) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(profile.avatarUrl),
            backgroundColor: AppColors.surface,
            onBackgroundImageError: (_, __) {},
          ),
          const SizedBox(width: AppDimensions.spacingL),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: const TextStyle(fontSize: AppDimensions.fontXXL, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                const SizedBox(height: AppDimensions.spacingXS),
                Text(
                  profile.role,
                  style: const TextStyle(fontSize: AppDimensions.fontM, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined, color: AppColors.iconSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfo(profile) {
    final parts = profile.name.split(' ');
    final first = parts.isNotEmpty ? parts.first : '';
    final last = parts.length > 1 ? parts.sublist(1).join(' ') : '';

    Widget infoRow(String label, String value) {
      return Padding(
        padding: const EdgeInsets.only(bottom: AppDimensions.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: AppDimensions.fontS, color: AppColors.textSecondary)),
            const SizedBox(height: AppDimensions.spacingXS),
            Text(value, style: const TextStyle(fontSize: AppDimensions.fontL, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Basic info', style: TextStyle(fontSize: AppDimensions.fontL, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: AppDimensions.spacingM),
        infoRow('First name', first),
        infoRow('Last name', last),
        infoRow('Email', profile.email),
      ],
    );
  }

  Widget _buildRolesSection() {
    final roles = MockData.assignedRoles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Assigned roles (${roles.length})', style: const TextStyle(fontSize: AppDimensions.fontM, color: AppColors.textSecondary)),
        const SizedBox(height: AppDimensions.spacingM),
        SizedBox(
          height: 190,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: roles.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppDimensions.spacingM),
            itemBuilder: (context, index) {
              final c = roles[index];
              return Container(
                width: 280,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cardShadow.withValues(alpha: 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(AppDimensions.paddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['title']!,
                      style: const TextStyle(fontSize: AppDimensions.fontXXL, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: AppDimensions.spacingM),
                    const Divider(color: AppColors.divider, thickness: 1),
                    const SizedBox(height: AppDimensions.spacingS),
                    const Text('Group', style: TextStyle(fontSize: AppDimensions.fontS, color: AppColors.textSecondary)),
                    const SizedBox(height: AppDimensions.spacingXS),
                    Text(c['group']!, style: const TextStyle(fontSize: AppDimensions.fontM, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const Spacer(),
                    const Text('Manager', style: TextStyle(fontSize: AppDimensions.fontS, color: AppColors.textSecondary)),
                    const SizedBox(height: AppDimensions.spacingXS),
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primary.withValues(alpha: 0.18), width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=${index + 1}'),
                            backgroundColor: AppColors.surface,
                            onBackgroundImageError: (_, __) {},
                          ),
                        ),
                        const SizedBox(width: AppDimensions.spacingS),
                        Expanded(
                          child: Text(
                            c['manager']!,
                            style: const TextStyle(fontSize: AppDimensions.fontM, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
