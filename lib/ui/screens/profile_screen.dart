import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bloc.dart';
import '../../core/constants/constants.dart';
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
      backgroundColor: AppColors.background,
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
              onRetry: () =>
                  context.read<ProfileBloc>().add(const LoadProfile()),
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

  Widget _buildHeader(profile) {
    return const SizedBox.shrink();
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
    final cards = [
      {
        'title': 'Manager',
        'group': 'Codecyaneon support',
        'manager': 'Jonaus Kahnwald',
      },
      {
        'title': 'Agent',
        'group': 'Laravel Ops',
        'manager': 'Sarah Johnson',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Assigned roles (3)', style: TextStyle(fontSize: AppDimensions.fontM, color: AppColors.textSecondary)),
        const SizedBox(height: AppDimensions.spacingM),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: cards.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppDimensions.spacingM),
            itemBuilder: (context, index) {
              final c = cards[index];
              return Container(
                width: 280,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(AppDimensions.paddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c['title']!, style: const TextStyle(fontSize: AppDimensions.fontXL, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    const SizedBox(height: AppDimensions.spacingM),
                    const Divider(color: AppColors.divider),
                    const SizedBox(height: AppDimensions.spacingS),
                    Text('Group', style: const TextStyle(fontSize: AppDimensions.fontS, color: AppColors.textSecondary)),
                    const SizedBox(height: AppDimensions.spacingXS),
                    Text(c['group']!, style: const TextStyle(fontSize: AppDimensions.fontM, color: AppColors.textPrimary)),
                    const Spacer(),
                    Row(
                      children: [
                        CircleAvatar(radius: 16, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1')),
                        const SizedBox(width: AppDimensions.spacingS),
                        Text(c['manager']!, style: const TextStyle(fontSize: AppDimensions.fontM, color: AppColors.textPrimary)),
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

  Widget _buildStatsSection(profile) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.add_task,
                    value: profile.ticketsCreated.toString(),
                    label: AppStrings.profileTicketsCreated,
                    color: AppColors.primary,
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: AppColors.divider,
                ),
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.check_circle_outline,
                    value: profile.ticketsResolved.toString(),
                    label: AppStrings.profileTicketsResolved,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: AppDimensions.iconL),
        const SizedBox(height: AppDimensions.spacingS),
        Text(
          value,
          style: const TextStyle(
            fontSize: AppDimensions.fontXXL,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: AppDimensions.fontXS,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildInfoSection(profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: AppDimensions.fontL,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimensions.spacingL),
              _buildInfoRow(
                icon: Icons.email_outlined,
                label: AppStrings.profileEmail,
                value: profile.email,
              ),
              const Divider(height: AppDimensions.spacingXL),
              _buildInfoRow(
                icon: Icons.phone_outlined,
                label: AppStrings.profilePhone,
                value: profile.phone,
              ),
              const Divider(height: AppDimensions.spacingXL),
              _buildInfoRow(
                icon: Icons.calendar_today_outlined,
                label: AppStrings.profileJoined,
                value: _formatDate(profile.joinedAt),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
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
    );
  }

  Widget _buildSettingsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        child: Column(
          children: [
            _buildSettingsTile(
              icon: Icons.edit_outlined,
              title: AppStrings.profileEdit,
              onTap: () {},
            ),
            const Divider(height: 1),
            _buildSettingsTile(
              icon: Icons.settings_outlined,
              title: AppStrings.profileSettings,
              onTap: () {},
            ),
            const Divider(height: 1),
            _buildSettingsTile(
              icon: Icons.logout,
              title: AppStrings.profileLogout,
              onTap: () {},
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: isDestructive ? AppColors.error : AppColors.iconPrimary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? AppColors.error : AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: isDestructive ? AppColors.error : AppColors.iconSecondary,
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
