import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bloc.dart';
import '../../core/constants/constants.dart';

/// Screen for filtering tickets with dynamic filter options
class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.close, color: AppColors.textPrimary),
      ),
      title: const Text(
        AppStrings.filterTitle,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      centerTitle: false,
      actions: [
        TextButton(
          onPressed: () {
            // Build selected filters map and apply
            final state = context.read<TicketBloc>().state;
            final selectedFilters = <String, List<String>>{};
            for (final group in state.filterGroups) {
              final selectedIds = group.options.where((o) => o.isSelected).map((o) => o.value).toList();
              if (selectedIds.isNotEmpty) selectedFilters[group.id] = selectedIds;
            }
            context.read<TicketBloc>().add(ApplyFilters(selectedFilters: selectedFilters));
            Navigator.of(context).pop();
          },
          child: const Text(
            'Apply',
            style: TextStyle(
              color: AppColors.textHint,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<TicketBloc, TicketState>(
      builder: (context, state) {
        if (state.filterGroups.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        }

        // Example static brands.
        final brands = [
          'Gains',
          'GainSolution',
          'GainHQ',
        ];

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL, vertical: AppDimensions.paddingM),
          children: [
            const SizedBox(height: AppDimensions.spacingM),

            // Brand section
            const Text(
              'Brand',
              style: TextStyle(fontSize: AppDimensions.fontL, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
            const SizedBox(height: AppDimensions.spacingL),
            ...brands.map((b) => _buildBrandRow(b)).toList(),
            const SizedBox(height: AppDimensions.spacingXL),

            // Priority
            const Text(
              'Priority',
              style: TextStyle(fontSize: AppDimensions.fontL, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            _buildPriorityDropdown(context, state),
            const SizedBox(height: AppDimensions.spacingXL),

            // Tags
            const Text(
              'Tags',
              style: TextStyle(fontSize: AppDimensions.fontL, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            _buildTagSearch(),
            const SizedBox(height: AppDimensions.spacingM),
            _buildTagChips(),
            const SizedBox(height: AppDimensions.spacingXXL),
          ],
        );
      },
    );
  }

  Widget _buildBrandRow(String brand) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingS),
      child: Row(
        children: [
          Checkbox(value: false, onChanged: (_) {}),
          const SizedBox(width: AppDimensions.spacingM),
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.business, color: AppColors.textOnPrimary),
          ),
          const SizedBox(width: AppDimensions.spacingM),
          Text(brand, style: const TextStyle(fontSize: AppDimensions.fontM, color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _buildPriorityDropdown(BuildContext context, TicketState state) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL, vertical: AppDimensions.paddingM),
          border: InputBorder.none,
        ),
        hint: const Text('Select priority', style: TextStyle(color: AppColors.textHint)),
        items: const [
          DropdownMenuItem(value: 'low', child: Text('Low')),
          DropdownMenuItem(value: 'medium', child: Text('Medium')),
          DropdownMenuItem(value: 'high', child: Text('High')),
          DropdownMenuItem(value: 'critical', child: Text('Critical')),
        ],
        onChanged: (v) {},
      ),
    );
  }

  Widget _buildTagSearch() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL, vertical: AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: const [
          Icon(Icons.search, color: AppColors.iconSecondary),
          SizedBox(width: AppDimensions.spacingM),
          Expanded(child: Text('Search tags', style: TextStyle(color: AppColors.textHint)))
        ],
      ),
    );
  }

  Widget _buildTagChips() {
    final tags = [
      'Tag one', 'Tag two', 'Tag three wit long text', 'Tag four', 'Tag five', 'Tag six with long text', 'Tag seven'
    ];

    return Wrap(
      spacing: AppDimensions.spacingS,
      runSpacing: AppDimensions.spacingS,
      children: tags.map((t) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM, vertical: AppDimensions.paddingXS),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(t, style: const TextStyle(color: AppColors.textPrimary)),
        );
      }).toList(),
    );
  }

}

/// Custom filter chip widget
class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusCircle),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              const Icon(
                Icons.check,
                size: AppDimensions.iconS,
                color: AppColors.textOnPrimary,
              ),
              const SizedBox(width: AppDimensions.spacingXS),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: AppDimensions.fontM,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? AppColors.textOnPrimary
                    : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
