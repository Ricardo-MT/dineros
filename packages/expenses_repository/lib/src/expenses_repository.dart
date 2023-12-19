import 'package:expenses/expenses.dart';

/// {@template expenses_repository}
/// A dart package for comunicating with the espenses library
/// {@endtemplate}
class ExpensesRepository {
  /// {@macro expenses_repository}
  const ExpensesRepository({
    required ExpensesApi expensesApi,
  }) : _expensesApi = expensesApi;

  final ExpensesApi _expensesApi;

  /// Provides a [Stream] of all expenses.
  Stream<List<Expense>> getExpenses() => _expensesApi.getExpenses();

  /// Saves the provided [expense], either updating or creating it.
  Future<void> saveExpense(Expense expense) =>
      _expensesApi.saveExpense(expense);

  /// Deletes the provided [expense].
  Future<void> deleteExpense(Expense expense) =>
      _expensesApi.deleteExpense(expense);
}
