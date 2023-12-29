// ignore_for_file: prefer_const_constructors
import 'package:expenses_repository/expenses_repository.dart';
import 'package:test/test.dart';

void main() {
  group('ExpensesRepository', () {
    test('can be instantiated', () {
      expect(ExpensesRepository, isNotNull);
    });
  });
}
