import 'package:expenses/expenses.dart';
import 'package:expenses_hive/src/adapters/expense_adapter.dart';
import 'package:expenses_hive/src/utils/hive_boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/subjects.dart';

/// {@template expenses_hive}
/// A flutter package implementing the expenses library
/// {@endtemplate}
class ExpensesHive extends ExpensesApi {
  /// {@macro expenses_hive}
  ExpensesHive({
    required Box<ExpenseSchema> box,
  }) : _box = box {
    _expensesStreamController.add(
      _box.values
          .map(
            (e) => e.toExpense(),
          )
          .toList(),
    );
  }

  final Box<ExpenseSchema> _box;

  final _expensesStreamController =
      BehaviorSubject<List<Expense>>.seeded(const []);

  /// Initializes the [ExpensesHive] instance.
  static Future<ExpensesHive> initializer() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExpenseSchemaAdapter());
    final box = await Hive.openBox<ExpenseSchema>(HiveBoxes.expenses);
    return ExpensesHive(box: box);
  }

  @override
  Future<void> deleteExpense(Expense expense) {
    final expenses = [..._expensesStreamController.value]
      ..removeWhere((t) => t.id == expense.id);
    _expensesStreamController.add(expenses);
    return Hive.box<ExpenseSchema>(HiveBoxes.expenses).delete(expense.id);
  }

  @override
  Stream<List<Expense>> getExpenses() =>
      _expensesStreamController.asBroadcastStream();

  @override
  Future<void> saveExpense(Expense expense) {
    final expenses = [..._expensesStreamController.value];
    final expenseIndex = expenses.indexWhere((t) => t.id == expense.id);
    if (expenseIndex >= 0) {
      expenses[expenseIndex] = expense;
    } else {
      expenses.add(expense);
    }
    _expensesStreamController.add(expenses);
    final expense0 = ExpenseSchema.fromExpense(expense);
    return Hive.box<ExpenseSchema>(HiveBoxes.expenses)
        .put(expense.id, expense0);
  }
}
