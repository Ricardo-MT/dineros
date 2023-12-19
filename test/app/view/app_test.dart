import 'package:dineros/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
