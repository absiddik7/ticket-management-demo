import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_management/bloc/theme/theme_bloc.dart';
import 'package:ticket_management/bloc/theme/theme_event.dart';
import 'package:ticket_management/bloc/theme/theme_state.dart';
import 'package:ticket_management/core/constants/app_strings.dart';
import 'package:ticket_management/core/theme/app_theme.dart';
import 'package:ticket_management/ui/screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TicketManagementApp());
}

class TicketManagementApp extends StatelessWidget {
  const TicketManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (_) => ThemeBloc()..add(const LoadSavedTheme()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.themeMode,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
