// ignore_for_file: prefer_const_constructors
import 'package:expenses/expenses.dart';
import 'package:test/test.dart';

void main() {
  group('Expenses', () {
    test('can be instantiated', () {
      expect(ExpensesApi, isNotNull);
    });
  });
}
