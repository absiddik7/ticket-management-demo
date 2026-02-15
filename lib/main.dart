import 'package:flutter/material.dart';
import 'core/theme/theme.dart';
import 'core/constants/constants.dart';
import 'ui/screens/screens.dart';

void main() {
  runApp(const TicketManagementApp());
}

class TicketManagementApp extends StatelessWidget {
  const TicketManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainScreen(),
    );
  }
}
