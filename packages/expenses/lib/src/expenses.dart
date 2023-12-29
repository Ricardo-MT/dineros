import 'package:expenses/expenses.dart';

/// {@template expenses}
/// A dart packages defining classes and interfaces relevant to expenses
/// {@endtemplate}
abstract class ExpensesApi {
  /// {@macro expenses}
  const ExpensesApi();

  /// Provides a [Stream] of all expenses.
  Stream<List<Expense>> getExpenses();

  /// Saves the provided [expense], either updating or creating it.
  Future<void> saveExpense(Expense expense);

  /// Deletes the provided [expense].
  Future<void> deleteExpense(Expense expense);
}
