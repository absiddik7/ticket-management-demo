/// Application string constants
/// All user-facing strings for easy localization and maintenance
class AppStrings {
  AppStrings._();

  // App Info
  static const String appName = 'Ticket Manager';
  static const String appVersion = '1.0.0';

  // Navigation Labels
  static const String navTickets = 'Tickets';
  static const String navContacts = 'Contacts';
  static const String navProfile = 'Profile';

  // Ticket Screen
  static const String ticketsTitle = 'My Tickets';
  static const String ticketsSubtitle = 'Manage your support tickets';
  static const String noTicketsFound = 'No tickets found';
  static const String noTicketsMessage = 'You don\'t have any tickets yet.';
  static const String ticketId = 'Ticket ID';
  static const String ticketCreated = 'Created';
  static const String ticketUpdated = 'Updated';
  static const String ticketPriority = 'Priority';
  static const String ticketStatus = 'Status';
  static const String ticketAssignee = 'Assignee';
  static const String ticketDescription = 'Description';

  // Ticket Status
  static const String statusOpen = 'Open';
  static const String statusInProgress = 'In Progress';
  static const String statusResolved = 'Resolved';
  static const String statusClosed = 'Closed';
  static const String statusPending = 'Pending';

  // Ticket Priority
  static const String priorityLow = 'Low';
  static const String priorityMedium = 'Medium';
  static const String priorityHigh = 'High';
  static const String priorityCritical = 'Critical';

  // Filter Screen
  static const String filterTitle = 'Filter Tickets';
  static const String filterApply = 'Apply Filters';
  static const String filterReset = 'Reset';
  static const String filterClear = 'Clear All';
  static const String filterBy = 'Filter by';
  static const String selectAll = 'Select All';
  static const String deselectAll = 'Deselect All';

  // Contact Screen
  static const String contactsTitle = 'Contacts';
  static const String contactsSubtitle = 'Find your team members';
  static const String searchContacts = 'Search contacts';
  static const String noContactsFound = 'No contacts found';
  static const String noContactsMessage = 'Try a different search term';
  static const String contactEmail = 'Email';
  static const String contactPhone = 'Phone';
  static const String contactDepartment = 'Department';
  static const String contactRole = 'Role';

  // Profile Screen
  static const String profileTitle = 'My Profile';
  static const String profileEdit = 'Edit Profile';
  static const String profileLogout = 'Log Out';
  static const String profileSettings = 'Settings';
  static const String profileName = 'Name';
  static const String profileEmail = 'Email';
  static const String profilePhone = 'Phone';
  static const String profileDepartment = 'Department';
  static const String profileRole = 'Role';
  static const String profileJoined = 'Joined';
  static const String profileTicketsCreated = 'Tickets Created';
  static const String profileTicketsResolved = 'Tickets Resolved';

  // Common
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String close = 'Close';
  static const String back = 'Back';
  static const String next = 'Next';
  static const String done = 'Done';
  static const String ok = 'OK';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String search = 'Search';
  static const String filter = 'Filter';
  static const String sort = 'Sort';
  static const String refresh = 'Refresh';
  static const String viewAll = 'View All';
  static const String seeMore = 'See More';
  static const String seeLess = 'See Less';

  // Error Messages
  static const String errorGeneric = 'Something went wrong';
  static const String errorNetwork = 'Network error. Please check your connection.';
  static const String errorTimeout = 'Request timed out. Please try again.';
  static const String errorNotFound = 'Resource not found';
  static const String errorUnauthorized = 'Unauthorized access';

  // Success Messages
  static const String successSaved = 'Saved successfully';
  static const String successDeleted = 'Deleted successfully';
  static const String successUpdated = 'Updated successfully';

  // Empty States
  static const String emptyTickets = 'No tickets to display';
  static const String emptyContacts = 'No contacts to display';
  static const String emptySearch = 'No results found';

  // Date Formats
  static const String dateFormatDisplay = 'MMM dd, yyyy';
  static const String dateTimeFormatDisplay = 'MMM dd, yyyy HH:mm';
  static const String timeFormatDisplay = 'HH:mm';
}
