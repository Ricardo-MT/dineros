import 'package:dineros/expense/view/expense_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders ExpensePage', (tester) async {
      expect(find.byType(ExpensePage), findsOneWidget);
    });
  });
}
