import 'package:flutter/material.dart';

/// Base class for all theme events
abstract class ThemeEvent {
  const ThemeEvent();
}

/// Event to toggle between light and dark theme
class ToggleTheme extends ThemeEvent {
  const ToggleTheme();
}

/// Event to set a specific theme mode
class SetThemeMode extends ThemeEvent {
  final ThemeMode themeMode;
  
  const SetThemeMode(this.themeMode);
}

/// Event to load saved theme preference
class LoadSavedTheme extends ThemeEvent {
  const LoadSavedTheme();
}
