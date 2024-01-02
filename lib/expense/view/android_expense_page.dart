import 'package:dineros/expense/bloc/expense_bloc.dart';
import 'package:dineros/expense/view/android_widgets.dart';
import 'package:dineros/expense_add_edit/view/add_edit_expense.dart';
import 'package:dineros/expense_add_edit/view/android_add_edit_expense.dart';
import 'package:dineros/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AndroidExpenseView extends StatelessWidget {
  const AndroidExpenseView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: const _Title(),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight * 0.5),
          child: _SubTitle(),
        ),
        actions: const [AndroidExpenseFilterButton()],
      ),
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          if (state.expenses.isEmpty) {
            return const AndroidNoExpenses();
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: state.expenses.length,
            itemBuilder: (context, index) {
              final expense = state.expenses[index];
              return GestureDetector(
                onLongPress: () {
                  HapticFeedback.heavyImpact();
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (_) => SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Text(
                                expense.name,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                showAdaptiveDialog<void>(
                                  context: context,
                                  builder: (_) => AndroidAddEditExpenseView(
                                    initialExpense: expense,
                                  ),
                                );
                              },
                              child: Text(l10n.edit),
                            ),
                            TextButton(
                              onPressed: () async {
                                final expenseBloc = context.read<ExpenseBloc>();
                                Navigator.of(context).pop();
                                final res = await showAdaptiveDialog<bool?>(
                                  context: context,
                                  builder: (_) => AlertDialog.adaptive(
                                    title: Text(
                                      '${l10n.deletingExpenseTitle} ${expense.name}',
                                    ),
                                    content: Text(
                                      l10n.deletingExpenseDescription,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: Text(l10n.cancel),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        child: Text(l10n.delete),
                                      ),
                                    ],
                                  ),
                                );
                                if (res == true) {
                                  expenseBloc.add(ExpenseDelete(expense));
                                }
                              },
                              child: Text(
                                l10n.delete,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: Navigator.of(context).pop,
                              child: Text(l10n.cancel),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: expense.id,
                  child: AndroidExpenseListItem(expense: expense),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAdaptiveDialog<void>(
          context: context,
          builder: (_) => const AddEditExpense(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(context.l10n.expensesPageTitle);
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        final totalAmount = state.expenses.fold<double>(
          0,
          (previousValue, element) => previousValue + element.price,
        );
        final totalAmountIsInteger = totalAmount == totalAmount.toInt();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
            bottom: 8,
          ),
          child: Row(
            children: [
              Text(
                '${context.l10n.total}: ',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                NumberFormat.simpleCurrency(
                  locale: Localizations.localeOf(context).languageCode,
                  decimalDigits: totalAmountIsInteger ? 0 : null,
                ).format(
                  totalAmountIsInteger ? totalAmount.toInt() : totalAmount,
                ),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
