import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bloc.dart';
import '../../core/constants/constants.dart';
import '../widgets/widgets.dart';
import '../widgets/ticket_detail_sheet.dart';
import 'filter_screen.dart';

/// Screen displaying the list of tickets
class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  void initState() {
    super.initState();
    // Load tickets and filter options when screen initializes
    context.read<TicketBloc>()
      ..add(const LoadTickets())
      ..add(const LoadFilterOptions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      title: const Text(
        'Gain Solutions',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      centerTitle: false,
      actions: [
        // Notification bell with badge
        Padding(
          padding: const EdgeInsets.only(right: AppDimensions.paddingL),
          child: Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  size: 32,
                  color: AppColors.textPrimary,
                ),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surface, width: 2),
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: AppColors.textOnPrimary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return BlocBuilder<TicketBloc, TicketState>(
      builder: (context, state) {
        switch (state.status) {
          case TicketStateStatus.initial:
          case TicketStateStatus.loading:
            return const LoadingIndicator(message: AppStrings.loading);

          case TicketStateStatus.error:
            return ErrorState(
              message: state.errorMessage ?? AppStrings.errorGeneric,
              onRetry: () =>
                  context.read<TicketBloc>().add(const LoadTickets()),
            );

          case TicketStateStatus.loaded:
            if (state.displayTickets.isEmpty) {
              return _buildEmptyState(state.isFiltered);
            }
            return Column(
              children: [
                // Top row with ticket count and filter button
                Container(
                  width: double.infinity,
                  color: AppColors.background,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingL,
                    //vertical: AppDimensions.paddingM,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${state.tickets.length} tickets',
                        style: const TextStyle(
                          fontSize: AppDimensions.fontM,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      BlocBuilder<TicketBloc, TicketState>(
                        builder: (context, s) {
                          return IconButton(
                            onPressed: () => _openFilterScreen(context),
                            icon: const Icon(
                              Icons.filter_list,
                              color: AppColors.textPrimary,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(child: _buildTicketList(state)),
              ],
            );
        }
      },
    );
  }

  Widget _buildEmptyState(bool isFiltered) {
    return EmptyState(
      icon: isFiltered ? Icons.search_off : Icons.confirmation_number_outlined,
      title: isFiltered ? AppStrings.emptySearch : AppStrings.noTicketsFound,
      message: isFiltered
          ? 'Try adjusting your filters'
          : AppStrings.noTicketsMessage,
      action: isFiltered
          ? TextButton(
              onPressed: () =>
                  context.read<TicketBloc>().add(const ClearFilters()),
              child: const Text(AppStrings.filterClear),
            )
          : null,
    );
  }

  Widget _buildTicketList(TicketState state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<TicketBloc>().add(const RefreshTickets());
      },
      child: Column(
        children: [
          // Active filters indicator
          if (state.isFiltered)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingL,
                vertical: AppDimensions.paddingS,
              ),
              color: AppColors.primary.withValues(alpha: 0.1),
              child: Row(
                children: [
                  const Icon(
                    Icons.filter_list,
                    size: AppDimensions.iconS,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppDimensions.spacingS),
                  Text(
                    '${state.activeFilterCount} filter${state.activeFilterCount > 1 ? 's' : ''} applied',
                    style: const TextStyle(
                      fontSize: AppDimensions.fontS,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () =>
                        context.read<TicketBloc>().add(const ClearFilters()),
                    child: const Text(
                      AppStrings.filterClear,
                      style: TextStyle(
                        fontSize: AppDimensions.fontS,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Ticket list
          Expanded(
            child: ListView.builder(
              itemCount: state.displayTickets.length,
              itemBuilder: (context, index) {
                final ticket = state.displayTickets[index];
                return TicketCard(
                  ticket: ticket,
                  onTap: () => _showTicketDetails(ticket),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openFilterScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<TicketBloc>(),
          child: const FilterScreen(),
        ),
      ),
    );
  }

  void _showTicketDetails(ticket) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TicketDetailSheet(ticket: ticket),
    );
  }
}

// Ticket detail sheet moved to `lib/ui/widgets/ticket_detail_sheet.dart`.
