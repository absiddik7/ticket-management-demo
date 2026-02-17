import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _themeKey = 'is_dark_mode';
  
  ThemeBloc() : super(const ThemeState()) {
    on<ToggleTheme>(_onToggleTheme);
    on<SetThemeMode>(_onSetThemeMode);
    on<LoadSavedTheme>(_onLoadSavedTheme);
  }

  Future<void> _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) async {
    final isDark = !state.isDarkMode;
    emit(state.copyWith(
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      isDarkMode: isDark,
    ));
    
    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
  }

  Future<void> _onSetThemeMode(SetThemeMode event, Emitter<ThemeState> emit) async {
    final isDark = event.themeMode == ThemeMode.dark;
    emit(state.copyWith(
      themeMode: event.themeMode,
      isDarkMode: isDark,
    ));
    
    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
  }

  Future<void> _onLoadSavedTheme(LoadSavedTheme event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themeKey) ?? false;
    
    emit(ThemeState(
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      isDarkMode: isDark,
    ));
  }
}
