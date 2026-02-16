import 'package:equatable/equatable.dart';

/// Filter display type enumeration
/// Controls how the filter group is rendered in the UI
enum FilterDisplayType {
  /// Horizontal scrollable chips
  chips,
  /// Dropdown selector
  dropdown,
  /// Checkbox list with optional icons
  checkboxList,
  /// Search field with chip selection
  searchWithChips,
}

/// Filter option model for dynamic filtering
class FilterOption extends Equatable {
  final String id;
  final String label;
  final String value;
  final bool isSelected;
  /// Optional icon name for checkbox list display
  final String? iconName;
  /// Optional color for visual indicators
  final String? colorHex;

  const FilterOption({
    required this.id,
    required this.label,
    required this.value,
    this.isSelected = false,
    this.iconName,
    this.colorHex,
  });

  /// Create a copy with updated fields
  FilterOption copyWith({
    String? id,
    String? label,
    String? value,
    bool? isSelected,
    String? iconName,
    String? colorHex,
  }) {
    return FilterOption(
      id: id ?? this.id,
      label: label ?? this.label,
      value: value ?? this.value,
      isSelected: isSelected ?? this.isSelected,
      iconName: iconName ?? this.iconName,
      colorHex: colorHex ?? this.colorHex,
    );
  }

  @override
  List<Object?> get props => [id, label, value, isSelected, iconName, colorHex];
}

/// Filter group model containing multiple filter options
class FilterGroup extends Equatable {
  final String id;
  final String title;
  final List<FilterOption> options;
  final bool allowMultiple;
  /// Display type determines how this filter group is rendered
  final FilterDisplayType displayType;
  /// Optional hint text for search or dropdown
  final String? hintText;

  const FilterGroup({
    required this.id,
    required this.title,
    required this.options,
    this.allowMultiple = true,
    this.displayType = FilterDisplayType.chips,
    this.hintText,
  });

  /// Get selected options
  List<FilterOption> get selectedOptions =>
      options.where((option) => option.isSelected).toList();

  /// Create a copy with updated fields
  FilterGroup copyWith({
    String? id,
    String? title,
    List<FilterOption>? options,
    bool? allowMultiple,
    FilterDisplayType? displayType,
    String? hintText,
  }) {
    return FilterGroup(
      id: id ?? this.id,
      title: title ?? this.title,
      options: options ?? this.options,
      allowMultiple: allowMultiple ?? this.allowMultiple,
      displayType: displayType ?? this.displayType,
      hintText: hintText ?? this.hintText,
    );
  }

  @override
  List<Object?> get props => [id, title, options, allowMultiple, displayType, hintText];
}
