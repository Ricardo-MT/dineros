import 'package:dineros/expense/bloc/expense_bloc.dart';
import 'package:dineros/expense/view/android_expense_page.dart';
import 'package:dineros/expense/view/ios_expense_page.dart';
import 'package:dineros/widgets/PlatformAwareWidget/platform_aware_widget.dart';
import 'package:expenses_repository/expenses_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExpenseBloc(
        expenseRepository: context.read<ExpensesRepository>(),
      )..add(ExpenseSubscriptionRequested()),
      child: const PlatformAwareWidget(
        androidWidget: AndroidExpenseView(),
        iosWidget: IosExpenseView(),
      ),
    );
  }
}
