import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bloc.dart';
import '../../core/constants/constants.dart';
import '../widgets/widgets.dart';

/// Screen displaying contacts with search functionality
class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ContactBloc>().add(const LoadContacts());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
        AppStrings.contactsTitle,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      centerTitle: false,
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // search area
            Padding(
              padding: const EdgeInsets.fromLTRB(AppDimensions.paddingL, AppDimensions.paddingL, AppDimensions.paddingL, 0),
              child: _buildSearchBar(),
            ),
            const SizedBox(height: AppDimensions.spacingM),

            // contacts count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
              child: Text(
                '${state.contacts.length} Contacts',
                style: const TextStyle(
                  fontSize: AppDimensions.fontM,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),

            // list
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<ContactBloc>().add(const LoadContacts());
                },
                child: state.status == ContactStateStatus.loading && state.displayContacts.isEmpty
                    ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: AppDimensions.paddingXXL, top: AppDimensions.spacingS),
                        itemCount: state.displayContacts.length,
                        itemBuilder: (context, index) {
                          final contact = state.displayContacts[index];
                          return ContactCard(
                            contact: contact,
                            onTap: () => _showContactDetails(contact),
                          );
                        },
                      ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (query) {
          context.read<ContactBloc>().add(SearchContacts(query: query));
        },
        decoration: InputDecoration(
          hintText: AppStrings.searchContacts,
          hintStyle: const TextStyle(
            color: AppColors.textHint,
            fontSize: AppDimensions.fontM,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.iconSecondary,
          ),
          suffixIcon: BlocBuilder<ContactBloc, ContactState>(
            builder: (context, state) {
              if (state.searchQuery.isNotEmpty) {
                return IconButton(
                  onPressed: () {
                    _searchController.clear();
                    context.read<ContactBloc>().add(const ClearSearch());
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: AppColors.iconSecondary,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingL,
            vertical: AppDimensions.paddingM,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isSearching) {
    return EmptyState(
      icon: isSearching ? Icons.search_off : Icons.people_outline,
      title: isSearching ? AppStrings.noContactsFound : AppStrings.emptyContacts,
      message: isSearching ? AppStrings.noContactsMessage : null,
    );
  }

  Widget _buildContactList(ContactState state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ContactBloc>().add(const LoadContacts());
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: AppDimensions.paddingXXL),
        itemCount: state.displayContacts.length,
        itemBuilder: (context, index) {
          final contact = state.displayContacts[index];
          return ContactCard(
            contact: contact,
            onTap: () => _showContactDetails(contact),
          );
        },
      ),
    );
  }

  void _showContactDetails(contact) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ContactDetailSheet(contact: contact),
    );
  }
}

/// Bottom sheet showing contact details
class _ContactDetailSheet extends StatelessWidget {
  final dynamic contact;

  const _ContactDetailSheet({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXL),
        ),
      ),
      child: Column(
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
                children: [
                  // Avatar
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: AppDimensions.avatarXL / 2,
                        backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                        backgroundImage: NetworkImage(contact.avatarUrl),
                        onBackgroundImageError: (_, __) {},
                        child: Text(
                          contact.initials,
                          style: const TextStyle(
                            fontSize: AppDimensions.fontXXXL,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      if (contact.isOnline)
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.surface,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spacingL),
                  // Name
                  Text(
                    contact.name,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontXXL,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingXS),
                  // Role
                  Text(
                    contact.role,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontM,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingXL),
                  // Contact info
                  _buildInfoTile(
                    icon: Icons.email_outlined,
                    label: AppStrings.contactEmail,
                    value: contact.email,
                  ),
                  _buildInfoTile(
                    icon: Icons.phone_outlined,
                    label: AppStrings.contactPhone,
                    value: contact.phone,
                  ),
                  _buildInfoTile(
                    icon: Icons.business_outlined,
                    label: AppStrings.contactDepartment,
                    value: contact.department,
                  ),
                  const SizedBox(height: AppDimensions.spacingXL),
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.email_outlined),
                          label: const Text('Email'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, AppDimensions.buttonHeightM),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spacingM),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.phone_outlined),
                          label: const Text('Call'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(0, AppDimensions.buttonHeightM),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Icon(
              icon,
              size: AppDimensions.iconM,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppDimensions.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontS,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontM,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
