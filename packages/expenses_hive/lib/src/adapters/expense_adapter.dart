import 'package:expenses/expenses.dart';
import 'package:hive/hive.dart';

part 'expense_adapter.g.dart';

/// A Hive class mimmicking the Expense class
@HiveType(typeId: 1)
class ExpenseSchema extends HiveObject {
  /// Basic constructor
  ExpenseSchema({
    required this.id,
    required this.date,
    required this.name,
    required this.price,
  });

  /// Convenient constructor from EsnapColor
  factory ExpenseSchema.fromExpense(
    Expense item,
  ) {
    return ExpenseSchema(
      id: item.id,
      date: item.date,
      name: item.name,
      price: item.price,
    );
  }

  /// The unique id for the item
  @HiveField(0)
  String id;

  /// The item´s color
  @HiveField(1)
  DateTime date;

  /// The item´s classification
  @HiveField(2)
  String name;

  /// A list of the item's occasions.
  @HiveField(3)
  double price;

  /// Returns an item based on this instance values
  Expense toExpense() => Expense(
        id: id,
        date: date,
        name: name,
        price: price,
      );
}
