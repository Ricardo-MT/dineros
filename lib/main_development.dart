import 'package:dineros/app/app.dart';
import 'package:dineros/bootstrap.dart';
import 'package:expenses_hive/expenses_hive.dart';
import 'package:expenses_repository/expenses_repository.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final expenseRepository =
      ExpensesRepository(expensesApi: await ExpensesHive.initializer());
  await bootstrap(
    () => App(
      expensesRepository: expenseRepository,
    ),
  );
}
