// Basic widget test for Ticket Management app

import 'package:flutter_test/flutter_test.dart';

import 'package:ticket_management/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TicketManagementApp());

    // Verify the app loads with the Tickets title
    expect(find.text('My Tickets'), findsOneWidget);
  });
}
