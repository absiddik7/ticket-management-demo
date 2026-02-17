import 'package:flutter/material.dart';

abstract class ThemeEvent {
  const ThemeEvent();
}

class ToggleTheme extends ThemeEvent {
  const ToggleTheme();
}

class SetThemeMode extends ThemeEvent {
  final ThemeMode themeMode;
  
  const SetThemeMode(this.themeMode);
}

class LoadSavedTheme extends ThemeEvent {
  const LoadSavedTheme();
}
