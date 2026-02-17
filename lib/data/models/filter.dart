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

  /// Create a FilterOption from JSON map
  factory FilterOption.fromJson(Map<String, dynamic> json) {
    return FilterOption(
      id: json['id'] as String,
      label: json['label'] as String,
      value: json['value'] as String,
      isSelected: json['is_selected'] as bool? ?? false,
      iconName: json['icon_name'] as String?,
      colorHex: json['color_hex'] as String?,
    );
  }

  /// Convert FilterOption to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'value': value,
      'is_selected': isSelected,
      if (iconName != null) 'icon_name': iconName,
      if (colorHex != null) 'color_hex': colorHex,
    };
  }

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

  /// Create a FilterGroup from JSON map
  factory FilterGroup.fromJson(Map<String, dynamic> json) {
    return FilterGroup(
      id: json['id'] as String,
      title: json['title'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => FilterOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      allowMultiple: json['allow_multiple'] as bool? ?? true,
      displayType: _parseDisplayType(json['display_type'] as String?),
      hintText: json['hint_text'] as String?,
    );
  }

  /// Convert FilterGroup to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'options': options.map((e) => e.toJson()).toList(),
      'allow_multiple': allowMultiple,
      'display_type': displayType.name,
      if (hintText != null) 'hint_text': hintText,
    };
  }

  static FilterDisplayType _parseDisplayType(String? type) {
    switch (type) {
      case 'chips':
        return FilterDisplayType.chips;
      case 'dropdown':
        return FilterDisplayType.dropdown;
      case 'checkboxList':
      case 'checkbox_list':
        return FilterDisplayType.checkboxList;
      case 'searchWithChips':
      case 'search_with_chips':
        return FilterDisplayType.searchWithChips;
      default:
        return FilterDisplayType.chips;
    }
  }

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
