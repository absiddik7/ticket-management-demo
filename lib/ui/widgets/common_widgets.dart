import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';

/// Loading indicator widget
class LoadingIndicator extends StatelessWidget {
  final String? message;

  const LoadingIndicator({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: AppColors.primary,
          ),
          if (message != null) ...[
            const SizedBox(height: AppDimensions.spacingL),
            Text(
              message!,
              style: TextStyle(
                color: theme.textTheme.bodySmall?.color,
                fontSize: AppDimensions.fontM,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Empty state widget
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? message;
  final Widget? action;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingXXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppDimensions.iconXXXL,
              color: theme.brightness == Brightness.dark
                  ? const Color(0xFF757575)
                  : AppColors.iconSecondary,
            ),
            const SizedBox(height: AppDimensions.spacingL),
            Text(
              title,
              style: TextStyle(
                fontSize: AppDimensions.fontXL,
                fontWeight: FontWeight.w600,
                color: theme.textTheme.bodyLarge?.color,
              ),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: AppDimensions.spacingS),
              Text(
                message!,
                style: TextStyle(
                  fontSize: AppDimensions.fontM,
                  color: theme.textTheme.bodySmall?.color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: AppDimensions.spacingXL),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Error state widget
class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorState({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingXXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: AppDimensions.iconXXXL,
              color: AppColors.error,
            ),
            const SizedBox(height: AppDimensions.spacingL),
            Text(
              AppStrings.error,
              style: TextStyle(
                fontSize: AppDimensions.fontXL,
                fontWeight: FontWeight.w600,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingS),
            Text(
              message,
              style: TextStyle(
                fontSize: AppDimensions.fontM,
                color: theme.textTheme.bodySmall?.color,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppDimensions.spacingXL),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text(AppStrings.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
