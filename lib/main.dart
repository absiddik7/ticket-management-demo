import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'core/theme/theme.dart';
import 'core/constants/constants.dart';
import 'ui/screens/screens.dart';

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
