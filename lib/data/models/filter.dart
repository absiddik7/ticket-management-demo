import 'package:equatable/equatable.dart';

/// Filter option model for dynamic filtering
class FilterOption extends Equatable {
  final String id;
  final String label;
  final String value;
  final bool isSelected;

  const FilterOption({
    required this.id,
    required this.label,
    required this.value,
    this.isSelected = false,
  });

  /// Create a copy with updated fields
  FilterOption copyWith({
    String? id,
    String? label,
    String? value,
    bool? isSelected,
  }) {
    return FilterOption(
      id: id ?? this.id,
      label: label ?? this.label,
      value: value ?? this.value,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [id, label, value, isSelected];
}

/// Filter group model containing multiple filter options
class FilterGroup extends Equatable {
  final String id;
  final String title;
  final List<FilterOption> options;
  final bool allowMultiple;

  const FilterGroup({
    required this.id,
    required this.title,
    required this.options,
    this.allowMultiple = true,
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
  }) {
    return FilterGroup(
      id: id ?? this.id,
      title: title ?? this.title,
      options: options ?? this.options,
      allowMultiple: allowMultiple ?? this.allowMultiple,
    );
  }

  @override
  List<Object?> get props => [id, title, options, allowMultiple];
}
