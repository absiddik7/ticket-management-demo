import 'package:flutter/material.dart';
import 'package:ticket_management/core/constants/app_colors.dart';
import 'package:ticket_management/core/constants/app_dimensions.dart';

class CommonSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final TextEditingController? controller;

  const CommonSearchBar({
    super.key,
    this.hintText = 'Search...',
    this.onChanged,
    this.onClear,
    this.controller,

  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2C) : AppColors.background,
        borderRadius: BorderRadius.circular(AppDimensions.radiusCircle),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: theme.textTheme.bodyLarge?.color),
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.transparent,
          hintStyle: TextStyle(
            color: isDark ? const Color(0xFF757575) : AppColors.textHint,
            fontSize: AppDimensions.fontM,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: isDark ? const Color(0xFF757575) : AppColors.iconSecondary,
          ),
          suffixIcon: controller != null && controller!.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    controller?.clear();
                    onClear?.call();
                  },
                  icon: Icon(
                    Icons.clear,
                    color: isDark ? const Color(0xFF757575) : AppColors.iconSecondary,
                  ),
                )
              : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingL,
            vertical: AppDimensions.paddingM,
          ),
        ),
      ),
    );
  }
}
