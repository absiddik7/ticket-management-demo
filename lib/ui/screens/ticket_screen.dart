import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bloc.dart';
import '../../core/constants/constants.dart';
import '../widgets/widgets.dart';
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
                  color: AppColors.textPrimary,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
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
                    vertical: AppDimensions.paddingM,
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
              padding: const EdgeInsets.only(bottom: AppDimensions.paddingXXL),
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
      builder: (context) => _TicketDetailSheet(ticket: ticket),
    );
  }
}

/// Bottom sheet showing ticket details
class _TicketDetailSheet extends StatelessWidget {
  final dynamic ticket;

  const _TicketDetailSheet({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXL),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: AppDimensions.paddingM),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.paddingXXL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ticket.id,
                        style: const TextStyle(
                          fontSize: AppDimensions.fontM,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingM,
                          vertical: AppDimensions.paddingXS,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusS,
                          ),
                        ),
                        child: Text(
                          ticket.statusDisplayText,
                          style: const TextStyle(
                            fontSize: AppDimensions.fontS,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spacingL),
                  // Title
                  Text(
                    ticket.title,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontXXL,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingL),
                  // Description
                  const Text(
                    AppStrings.ticketDescription,
                    style: TextStyle(
                      fontSize: AppDimensions.fontM,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingS),
                  Text(
                    ticket.description,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontM,
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingXL),
                  const Divider(),
                  const SizedBox(height: AppDimensions.spacingL),
                  // Details grid
                  _buildDetailRow(
                    AppStrings.ticketPriority,
                    ticket.priorityDisplayText,
                  ),
                  _buildDetailRow(AppStrings.ticketAssignee, ticket.assignee),
                  _buildDetailRow('Category', ticket.category),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: AppDimensions.fontM,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: AppDimensions.fontM,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
