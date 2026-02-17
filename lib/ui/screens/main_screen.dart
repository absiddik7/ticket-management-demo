import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bloc.dart';
import '../../core/constants/constants.dart';
import 'ticket_screen.dart';
import 'contact_screen.dart';
import 'profile_screen.dart';

/// Main navigation shell with bottom navigation bar
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    TicketScreen(),
    ContactScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TicketBloc>(
          create: (_) => TicketBloc(),
        ),
        BlocProvider<ContactBloc>(
          create: (_) => ContactBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc(),
        ),
      ],
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingS,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.confirmation_number_outlined,
                activeIcon: Icons.confirmation_number,
                label: AppStrings.navTickets,
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.people_outline,
                activeIcon: Icons.people,
                label: AppStrings.navContacts,
                index: 1,
              ),
              _buildNavItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: AppStrings.navProfile,
                index: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingS,
          vertical: AppDimensions.paddingXS,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pill background for selected item
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isSelected ? AppDimensions.spacingL : 8,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary.withValues(alpha: 0.12) : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: isSelected
                  ? Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        activeIcon,
                        color: AppColors.primary,
                      ),
                    )
                  : Icon(
                      icon,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF757575)
                          : AppColors.navInactive,
                    ),
            ),
            const SizedBox(height: AppDimensions.spacingXS),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Theme.of(context).textTheme.bodyMedium?.color
                    : Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF757575)
                        : AppColors.navInactive,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: AppDimensions.fontS,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
