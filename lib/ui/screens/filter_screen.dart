import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_management/bloc/ticket/ticket_bloc.dart';
import 'package:ticket_management/bloc/ticket/ticket_event.dart';
import 'package:ticket_management/bloc/ticket/ticket_state.dart';
import 'package:ticket_management/core/constants/app_colors.dart';
import 'package:ticket_management/core/constants/app_dimensions.dart';
import 'package:ticket_management/core/constants/app_strings.dart';
import 'package:ticket_management/data/models/filter.dart';
import 'package:ticket_management/ui/widgets/common_search_bar.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final Map<String, TextEditingController> _searchControllers = {};
  final Map<String, String> _searchQueries = {};

  @override
  void initState() {
    super.initState();
    // Load filter options only if not already loaded
    final state = context.read<TicketBloc>().state;
    if (state.filterGroups.isEmpty) {
      context.read<TicketBloc>().add(const LoadFilterOptions());
    }
  }

  @override
  void dispose() {
    for (final controller in _searchControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(
          Icons.close,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      title: Text(
        AppStrings.filterTitle,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      centerTitle: false,
      actions: [
        // Clear filters button
        BlocBuilder<TicketBloc, TicketState>(
          builder: (context, state) {
            final hasSelections = state.filterGroups.any(
              (group) => group.options.any((o) => o.isSelected),
            );
            if (!hasSelections) return const SizedBox.shrink();
            return TextButton(
              onPressed: () {
                context.read<TicketBloc>().add(const ResetFilterSelections());
              },
              child: const Text(
                'Clear',
                style: TextStyle(
                  color: AppColors.error,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        ),
        // Apply button
        TextButton(
          onPressed: () => _applyFilters(context),
          child: const Text(
            'Apply',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _applyFilters(BuildContext context) {
    final state = context.read<TicketBloc>().state;
    final selectedFilters = <String, List<String>>{};

    for (final group in state.filterGroups) {
      final selectedValues = group.options
          .where((o) => o.isSelected)
          .map((o) => o.value)
          .toList();
      if (selectedValues.isNotEmpty) {
        selectedFilters[group.id] = selectedValues;
      }
    }

    context.read<TicketBloc>().add(
      ApplyFilters(selectedFilters: selectedFilters),
    );
    Navigator.of(context).pop();
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<TicketBloc, TicketState>(
      builder: (context, state) {
        if (state.filterGroups.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingL,
            vertical: AppDimensions.paddingM,
          ),
          itemCount: state.filterGroups.length,
          itemBuilder: (context, index) {
            final group = state.filterGroups[index];
            return _buildFilterGroup(context, group);
          },
        );
      },
    );
  }

  Widget _buildFilterGroup(BuildContext context, FilterGroup group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppDimensions.spacingM),
        // Title
        Text(
          group.title,
          style: TextStyle(
            fontSize: AppDimensions.fontL,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        const SizedBox(height: AppDimensions.spacingM),
        // Content based on display type
        _buildFilterContent(context, group),
        const SizedBox(height: AppDimensions.spacingXL),
      ],
    );
  }

  Widget _buildFilterContent(BuildContext context, FilterGroup group) {
    switch (group.displayType) {
      case FilterDisplayType.chips:
        return _buildChipsFilter(context, group);
      case FilterDisplayType.dropdown:
        return _buildDropdownFilter(context, group);
      case FilterDisplayType.checkboxList:
        return _buildCheckboxListFilter(context, group);
      case FilterDisplayType.searchWithChips:
        return _buildSearchWithChipsFilter(context, group);
    }
  }

  Widget _buildChipsFilter(BuildContext context, FilterGroup group) {
    return Wrap(
      spacing: AppDimensions.spacingS,
      runSpacing: AppDimensions.spacingS,
      children: group.options.map((option) {
        return _FilterChip(
          label: option.label,
          isSelected: option.isSelected,
          colorHex: option.colorHex,
          onTap: () {
            context.read<TicketBloc>().add(
              ToggleFilterOption(groupId: group.id, optionId: option.id),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildDropdownFilter(BuildContext context, FilterGroup group) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final selectedOption = group.options.where((o) => o.isSelected).firstOrNull;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: isDark ? const Color(0xFF3D3D3D) : AppColors.border,
        ),
        color: isDark ? const Color(0xFF2C2C2C) : AppColors.background,
      ),
      child: PopupMenuButton<String>(
        offset: const Offset(0, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        elevation: 8,
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width - 64,
        ),
        itemBuilder: (context) {
          return group.options.map((option) {
            return PopupMenuItem<String>(
              value: option.id,
              child: Row(
                children: [
                  if (option.colorHex != null) ...[
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _hexToColor(option.colorHex!),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.spacingM),
                  ],
                  Expanded(child: Text(option.label)),
                  if (option.isSelected)
                    const Icon(Icons.check, size: 20, color: AppColors.primary),
                ],
              ),
            );
          }).toList();
        },
        onSelected: (value) {
          // For single-select, clear previous selections first
          final bloc = context.read<TicketBloc>();
          for (final option in group.options) {
            if (option.isSelected && option.id != value) {
              bloc.add(
                ToggleFilterOption(groupId: group.id, optionId: option.id),
              );
            }
          }
          // Toggle the new selection
          final targetOption = group.options.firstWhere((o) => o.id == value);
          if (!targetOption.isSelected) {
            bloc.add(ToggleFilterOption(groupId: group.id, optionId: value));
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (selectedOption != null) ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (selectedOption.colorHex != null)
                    Container(
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.only(
                        right: AppDimensions.spacingS,
                      ),
                      decoration: BoxDecoration(
                        color: _hexToColor(selectedOption.colorHex!),
                        shape: BoxShape.circle,
                      ),
                    ),
                  Text(
                    selectedOption.label,
                    style: TextStyle(
                      color: theme.textTheme.bodyLarge?.color,
                      fontSize: AppDimensions.fontM,
                    ),
                  ),
                ],
              ),
            ] else
              Text(
                group.hintText ?? 'Select ${group.title.toLowerCase()}',
                style: TextStyle(
                  color: isDark ? const Color(0xFF757575) : AppColors.textHint,
                  fontSize: AppDimensions.fontM,
                ),
              ),
            Icon(
              Icons.keyboard_arrow_down,
              color: isDark ? const Color(0xFF757575) : AppColors.iconSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxListFilter(BuildContext context, FilterGroup group) {
    final theme = Theme.of(context);

    return Column(
      children: group.options.map((option) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingXS,
          ),
          child: InkWell(
            onTap: () {
              context.read<TicketBloc>().add(
                ToggleFilterOption(groupId: group.id, optionId: option.id),
              );
            },
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.paddingS,
              ),
              child: Row(
                children: [
                  // Checkbox
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: option.isSelected,
                      onChanged: (_) {
                        context.read<TicketBloc>().add(
                          ToggleFilterOption(
                            groupId: group.id,
                            optionId: option.id,
                          ),
                        );
                      },
                      activeColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingM),
                  // Icon avatar
                  if (option.iconName != null || option.colorHex != null)
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: option.colorHex != null
                          ? _hexToColor(option.colorHex!)
                          : AppColors.primary,
                      child: Icon(
                        _getIconData(option.iconName),
                        color: AppColors.textOnPrimary,
                        size: 18,
                      ),
                    ),
                  const SizedBox(width: AppDimensions.spacingM),
                  // Label
                  Text(
                    option.label,
                    style: TextStyle(
                      fontSize: AppDimensions.fontM,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSearchWithChipsFilter(BuildContext context, FilterGroup group) {
    // Initialize search controller if needed
    _searchControllers.putIfAbsent(group.id, () => TextEditingController());
    _searchQueries.putIfAbsent(group.id, () => '');

    final searchQuery = _searchQueries[group.id] ?? '';
    final filteredOptions = searchQuery.isEmpty
        ? group.options
        : group.options
              .where(
                (o) =>
                    o.label.toLowerCase().contains(searchQuery.toLowerCase()),
              )
              .toList();

    return Column(
      children: [
        // Search field using CommonSearchBar
        CommonSearchBar(
          controller: _searchControllers[group.id],
          hintText: group.hintText ?? 'Search ${group.title.toLowerCase()}',
          onChanged: (value) {
            setState(() {
              _searchQueries[group.id] = value;
            });
          },
          onClear: () {
            setState(() {
              _searchQueries[group.id] = '';
            });
          },
        ),

        const SizedBox(height: AppDimensions.spacingM),
        // Chips
        Wrap(
          spacing: AppDimensions.spacingS,
          runSpacing: AppDimensions.spacingS,
          children: filteredOptions.map((option) {
            return _FilterChip(
              label: option.label,
              isSelected: option.isSelected,
              colorHex: option.colorHex,
              onTap: () {
                context.read<TicketBloc>().add(
                  ToggleFilterOption(groupId: group.id, optionId: option.id),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Color _hexToColor(String hex) {
    final hexCode = hex.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  IconData _getIconData(String? iconName) {
    switch (iconName) {
      case 'business':
        return Icons.business;
      case 'person':
        return Icons.person;
      case 'label':
        return Icons.label;
      case 'bug_report':
        return Icons.bug_report;
      case 'star':
        return Icons.star;
      default:
        return Icons.circle;
    }
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final String? colorHex;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.colorHex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final chipColor = colorHex != null
        ? Color(int.parse('FF${colorHex!.replaceAll('#', '')}', radix: 16))
        : AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingS,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? chipColor
              : (isDark ? const Color(0xFF1E1E1E) : AppColors.surface),
          borderRadius: BorderRadius.circular(AppDimensions.radiusCircle),
          border: Border.all(
            color: isSelected
                ? chipColor
                : (isDark ? const Color(0xFF3D3D3D) : AppColors.border),
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
                fontSize: AppDimensions.fontS,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? AppColors.textOnPrimary
                    : theme.textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
