import '../models/models.dart';

/// Mock data for simulating API responses
/// This class provides static data for testing purposes
class MockData {
  MockData._();

  /// Mock tickets list
  static List<Ticket> get tickets => [
        Ticket(
          id: 'TKT-001',
          title: 'Login page not loading',
          description:
              'Users are experiencing issues with the login page not loading properly on mobile devices. The page shows a blank white screen.',
          status: TicketStatus.open,
          priority: TicketPriority.high,
          assignee: 'John Smith',
          assigneeAvatar: 'https://i.pravatar.cc/150?img=1',
          category: 'Bug',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 4)),
        ),
        Ticket(
          id: 'TKT-002',
          title: 'Add dark mode support',
          description:
              'Feature request to implement dark mode across the entire application for better user experience.',
          status: TicketStatus.inProgress,
          priority: TicketPriority.medium,
          assignee: 'Sarah Johnson',
          assigneeAvatar: 'https://i.pravatar.cc/150?img=5',
          category: 'Feature Request',
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
          updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        Ticket(
          id: 'TKT-003',
          title: 'Payment gateway timeout',
          description:
              'Critical: Payment gateway is timing out during checkout process, affecting all users.',
          status: TicketStatus.pending,
          priority: TicketPriority.critical,
          assignee: 'Mike Chen',
          assigneeAvatar: 'https://i.pravatar.cc/150?img=3',
          category: 'Bug',
          createdAt: DateTime.now().subtract(const Duration(hours: 6)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        Ticket(
          id: 'TKT-004',
          title: 'Update user documentation',
          description:
              'The user documentation needs to be updated with the latest features and screenshots.',
          status: TicketStatus.resolved,
          priority: TicketPriority.low,
          assignee: 'Emily Davis',
          assigneeAvatar: 'https://i.pravatar.cc/150?img=9',
          category: 'Documentation',
          createdAt: DateTime.now().subtract(const Duration(days: 10)),
          updatedAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
        Ticket(
          id: 'TKT-005',
          title: 'Mobile app crash on startup',
          description:
              'Some Android users report app crashing immediately after launch on Android 13 devices.',
          status: TicketStatus.open,
          priority: TicketPriority.critical,
          assignee: 'Alex Wilson',
          assigneeAvatar: 'https://i.pravatar.cc/150?img=7',
          category: 'Bug',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 8)),
        ),
        Ticket(
          id: 'TKT-006',
          title: 'Improve search functionality',
          description:
              'Request to add advanced search filters and improve search result relevance.',
          status: TicketStatus.closed,
          priority: TicketPriority.medium,
          assignee: 'Lisa Brown',
          assigneeAvatar: 'https://i.pravatar.cc/150?img=10',
          category: 'Feature Request',
          createdAt: DateTime.now().subtract(const Duration(days: 15)),
          updatedAt: DateTime.now().subtract(const Duration(days: 7)),
        ),
        Ticket(
          id: 'TKT-007',
          title: 'Email notifications not received',
          description:
              'Users are not receiving email notifications for password reset requests.',
          status: TicketStatus.inProgress,
          priority: TicketPriority.high,
          assignee: 'David Lee',
          assigneeAvatar: 'https://i.pravatar.cc/150?img=4',
          category: 'Bug',
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
        ),
        Ticket(
          id: 'TKT-008',
          title: 'Add export to PDF feature',
          description:
              'Users want the ability to export reports and data to PDF format.',
          status: TicketStatus.open,
          priority: TicketPriority.low,
          assignee: 'Jennifer Martinez',
          assigneeAvatar: 'https://i.pravatar.cc/150?img=11',
          category: 'Feature Request',
          createdAt: DateTime.now().subtract(const Duration(days: 8)),
          updatedAt: DateTime.now().subtract(const Duration(days: 4)),
        ),
      ];

  /// Mock contacts list
  static List<Contact> get contacts => [
        const Contact(
          id: 'CNT-001',
          name: 'John Smith',
          email: 'john.smith@gainsolutions.com',
          phone: '+1 (555) 123-4567',
          department: 'Engineering',
          role: 'Senior Developer',
          avatarUrl: 'https://i.pravatar.cc/150?img=1',
          isOnline: true,
        ),
        const Contact(
          id: 'CNT-002',
          name: 'Sarah Johnson',
          email: 'sarah.johnson@gainsolutions.com',
          phone: '+1 (555) 234-5678',
          department: 'Design',
          role: 'UI/UX Designer',
          avatarUrl: 'https://i.pravatar.cc/150?img=5',
          isOnline: true,
        ),
        const Contact(
          id: 'CNT-003',
          name: 'Mike Chen',
          email: 'mike.chen@gainsolutions.com',
          phone: '+1 (555) 345-6789',
          department: 'Engineering',
          role: 'Backend Developer',
          avatarUrl: 'https://i.pravatar.cc/150?img=3',
          isOnline: false,
        ),
        const Contact(
          id: 'CNT-004',
          name: 'Emily Davis',
          email: 'emily.davis@gainsolutions.com',
          phone: '+1 (555) 456-7890',
          department: 'Product',
          role: 'Product Manager',
          avatarUrl: 'https://i.pravatar.cc/150?img=9',
          isOnline: true,
        ),
        const Contact(
          id: 'CNT-005',
          name: 'Alex Wilson',
          email: 'alex.wilson@gainsolutions.com',
          phone: '+1 (555) 567-8901',
          department: 'Engineering',
          role: 'Mobile Developer',
          avatarUrl: 'https://i.pravatar.cc/150?img=7',
          isOnline: false,
        ),
        const Contact(
          id: 'CNT-006',
          name: 'Lisa Brown',
          email: 'lisa.brown@gainsolutions.com',
          phone: '+1 (555) 678-9012',
          department: 'QA',
          role: 'QA Engineer',
          avatarUrl: 'https://i.pravatar.cc/150?img=10',
          isOnline: true,
        ),
        const Contact(
          id: 'CNT-007',
          name: 'David Lee',
          email: 'david.lee@gainsolutions.com',
          phone: '+1 (555) 789-0123',
          department: 'Engineering',
          role: 'DevOps Engineer',
          avatarUrl: 'https://i.pravatar.cc/150?img=4',
          isOnline: false,
        ),
        const Contact(
          id: 'CNT-008',
          name: 'Jennifer Martinez',
          email: 'jennifer.martinez@gainsolutions.com',
          phone: '+1 (555) 890-1234',
          department: 'Support',
          role: 'Support Specialist',
          avatarUrl: 'https://i.pravatar.cc/150?img=11',
          isOnline: true,
        ),
        const Contact(
          id: 'CNT-009',
          name: 'Robert Taylor',
          email: 'robert.taylor@gainsolutions.com',
          phone: '+1 (555) 901-2345',
          department: 'Management',
          role: 'Engineering Manager',
          avatarUrl: 'https://i.pravatar.cc/150?img=12',
          isOnline: false,
        ),
        const Contact(
          id: 'CNT-010',
          name: 'Amanda White',
          email: 'amanda.white@gainsolutions.com',
          phone: '+1 (555) 012-3456',
          department: 'HR',
          role: 'HR Manager',
          avatarUrl: 'https://i.pravatar.cc/150?img=13',
          isOnline: true,
        ),
      ];

  /// Mock user profile
  static UserProfile get userProfile => UserProfile(
        id: 'USR-001',
        name: 'Alex Thompson',
        email: 'alex.thompson@gainsolutions.com',
        phone: '+1 (555) 111-2222',
        department: 'Engineering',
        role: 'Flutter Developer',
        avatarUrl: 'https://i.pravatar.cc/150?img=8',
        joinedAt: DateTime(2023, 3, 15),
        ticketsCreated: 24,
        ticketsResolved: 18,
      );

  /// Mock filter groups (dynamic filters from API)
  static List<FilterGroup> get filterGroups => [
        const FilterGroup(
          id: 'status',
          title: 'Status',
          options: [
            FilterOption(id: 'open', label: 'Open', value: 'open'),
            FilterOption(
                id: 'in_progress', label: 'In Progress', value: 'in_progress'),
            FilterOption(id: 'pending', label: 'Pending', value: 'pending'),
            FilterOption(id: 'resolved', label: 'Resolved', value: 'resolved'),
            FilterOption(id: 'closed', label: 'Closed', value: 'closed'),
          ],
        ),
        const FilterGroup(
          id: 'priority',
          title: 'Priority',
          options: [
            FilterOption(id: 'critical', label: 'Critical', value: 'critical'),
            FilterOption(id: 'high', label: 'High', value: 'high'),
            FilterOption(id: 'medium', label: 'Medium', value: 'medium'),
            FilterOption(id: 'low', label: 'Low', value: 'low'),
          ],
        ),
        const FilterGroup(
          id: 'category',
          title: 'Category',
          options: [
            FilterOption(id: 'bug', label: 'Bug', value: 'bug'),
            FilterOption(
                id: 'feature', label: 'Feature Request', value: 'feature'),
            FilterOption(id: 'docs', label: 'Documentation', value: 'docs'),
            FilterOption(id: 'support', label: 'Support', value: 'support'),
          ],
        ),
      ];
}
