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
      backgroundColor: AppColors.surface,
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
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.paddingL,
                AppDimensions.paddingL,
                AppDimensions.paddingL,
                0,
              ),
              child: CommonSearchBar(
                controller: _searchController,
                hintText: AppStrings.searchContacts,
                onChanged: (query) {
                  context.read<ContactBloc>().add(SearchContacts(query: query));
                },
                onClear: () {
                  context.read<ContactBloc>().add(const ClearSearch());
                },
              ),
            ),
            const SizedBox(height: AppDimensions.spacingL),

            // contacts count
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingL,
              ),
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
                child:
                    state.status == ContactStateStatus.loading &&
                        state.displayContacts.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(
                          bottom: AppDimensions.paddingXXL,
                          top: AppDimensions.spacingS,
                        ),
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

  void _showContactDetails(contact) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ContactDetailSheet(contact: contact),
    );
  }
}
