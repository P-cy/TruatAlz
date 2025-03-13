import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:truat_alz/pages/calendar.dart';

void main() {
  // Set up mock initial values for SharedPreferences
  SharedPreferences.setMockInitialValues({});

  testWidgets('Calendar screen loads quiz results',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(
      home: DailyQuizCalendarScreen(),
    ));

    // Verify that the CircularProgressIndicator is shown while loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the async operations to complete
    await tester.pumpAndSettle();

    // Verify that the CircularProgressIndicator is no longer shown
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // Verify that the calendar is displayed
    expect(find.byType(TableCalendar), findsOneWidget);
  });
}
